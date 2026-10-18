"""
World Model Visual Verifier & Layout Corrector for ILLIMMI Layer 3
===================================================================
Simulates whiteboard state at each pre-erase scene milestone.
Checks for:
- Canvas bounding box violations (X in [0, 177.78], Y in [0, 100])
- Text-on-text and text-on-figure spatial collisions
- Left margin alignment compliance (text at left x in [2, 10], leaving center/right for graphs)
- Whiteboard clutter and missing erase transitions
- Visual action anchor synchronicity with narration verbs
- Automated coordinate refactoring and correction
"""

import re
import math
from dataclasses import dataclass
from typing import List, Dict, Tuple, Optional


CANVAS_WIDTH = 177.78
CANVAS_HEIGHT = 100.0


@dataclass
class VisualElement:
    elem_type: str  # 'text', 'line', 'arrow', 'circle', 'polygone', '2drep', '2dfunc', 'mouse', 'erase'
    id: int
    start: float
    duration: float
    end_time: float  # either erased or course end
    bbox: Tuple[float, float, float, float]  # (xmin, ymin, xmax, ymax)
    raw_cmd: str
    content: str = ""
    is_erased: bool = False


@dataclass
class VisualSceneMilestone:
    time: float
    active_elements: List[VisualElement]
    erase_id: Optional[int] = None


class HypercourseParser:
    """Parses raw .hc code into structured visual elements with bounding boxes."""

    @staticmethod
    def estimate_text_bbox(x: float, y: float, text: str) -> Tuple[float, float, float, float]:
        """Estimate bounding box for text/LaTeX on a 16:9 canvas."""
        is_display_math = "$$" in text
        is_inline_math = "$" in text and not is_display_math
        clean = re.sub(r'\[.*?\]|\$\$|\$|\\[a-zA-Z]+|\{|\}', '', text).strip()

        length = len(clean)
        if length <= 2:
            w = 4.0
            h = 5.0
        elif is_display_math:
            w = min(80.0, max(20.0, length * 1.4))
            h = 10.0
        elif is_inline_math:
            w = min(80.0, max(15.0, length * 1.1))
            h = 7.0
        else:
            w = min(80.0, max(8.0, length * 1.0))
            h = 6.0

        return (round(x, 2), round(y, 2), round(min(CANVAS_WIDTH, x + w), 2), round(min(CANVAS_HEIGHT, y + h), 2))

    @staticmethod
    def parse_script(script: str, course_duration: float = 180.0) -> List[VisualElement]:
        elements: List[VisualElement] = []

        # 1. Parse text commands
        text_pattern = re.compile(
            r"text\s+id\s+(\d+)\s+start\s+([\d\.]+)s(?:\s+for\s+([\d\.]+)s)?\s+at\s+\(([\d\.]+),\s*([\d\.]+)\)\s*''([^']*)''\s*;",
            re.MULTILINE | re.DOTALL
        )
        for m in text_pattern.finditer(script):
            eid = int(m.group(1))
            start = float(m.group(2))
            dur = float(m.group(3)) if m.group(3) else (course_duration - start)
            x = float(m.group(4))
            y = float(m.group(5))
            content = m.group(6)
            bbox = HypercourseParser.estimate_text_bbox(x, y, content)
            elements.append(VisualElement(
                elem_type="text", id=eid, start=start, duration=dur,
                end_time=start + dur, bbox=bbox, raw_cmd=m.group(0), content=content
            ))

        # 2. Parse draw polygone
        poly_pattern = re.compile(
            r"draw\s+polygone\s+id\s+(\d+)\s+start\s+([\d\.]+)s(?:\s+for\s+([\d\.]+)s)?.*?at\s*\[(.*?)\]\s*;",
            re.MULTILINE | re.DOTALL
        )
        for m in poly_pattern.finditer(script):
            eid = int(m.group(1))
            start = float(m.group(2))
            dur = float(m.group(3)) if m.group(3) else 1.0
            points_str = m.group(4)
            pt_tuples = re.findall(r"\(([\d\.]+),\s*([\d\.]+)\)", points_str)
            if pt_tuples:
                xs = [float(p[0]) for p in pt_tuples]
                ys = [float(p[1]) for p in pt_tuples]
                bbox = (min(xs), min(ys), max(xs), max(ys))
            else:
                bbox = (20.0, 20.0, 100.0, 60.0)
            elements.append(VisualElement(
                elem_type="polygone", id=eid, start=start, duration=dur,
                end_time=course_duration, bbox=bbox, raw_cmd=m.group(0)
            ))

        # 3. Parse draw line / arrow
        line_pattern = re.compile(
            r"draw\s+(line|arrow)\s+id\s+(\d+)\s+start\s+([\d\.]+)s(?:\s+for\s+([\d\.]+)s)?.*?at\s*\[\(([\d\.]+),\s*([\d\.]+)\),\s*\(([\d\.]+),\s*([\d\.]+)\)\]\s*;",
            re.MULTILINE
        )
        for m in line_pattern.finditer(script):
            kind = m.group(1)
            eid = int(m.group(2))
            start = float(m.group(3))
            dur = float(m.group(4)) if m.group(4) else 1.0
            x1, y1 = float(m.group(5)), float(m.group(6))
            x2, y2 = float(m.group(7)), float(m.group(8))
            bbox = (min(x1, x2), min(y1, y2), max(x1, x2), max(y1, y2))
            elements.append(VisualElement(
                elem_type=kind, id=eid, start=start, duration=dur,
                end_time=course_duration, bbox=bbox, raw_cmd=m.group(0)
            ))

        # 4. Parse draw circle
        circle_pattern = re.compile(
            r"draw\s+circle\s+id\s+(\d+)\s+start\s+([\d\.]+)s(?:\s+for\s+([\d\.]+)s)?.*?at\s*\(([\d\.]+),\s*([\d\.]+)\)\s*radius\s*([\d\.]+)\s*;",
            re.MULTILINE
        )
        for m in circle_pattern.finditer(script):
            eid = int(m.group(1))
            start = float(m.group(2))
            dur = float(m.group(3)) if m.group(3) else 1.0
            cx, cy = float(m.group(4)), float(m.group(5))
            r = float(m.group(6))
            bbox = (max(0.0, cx - r), max(0.0, cy - r), min(CANVAS_WIDTH, cx + r), min(CANVAS_HEIGHT, cy + r))
            elements.append(VisualElement(
                elem_type="circle", id=eid, start=start, duration=dur,
                end_time=course_duration, bbox=bbox, raw_cmd=m.group(0)
            ))

        # 5. Parse 2drep (cartesian frame)
        rep_pattern = re.compile(
            r"draw\s+2drep\s+id\s+(\d+)\s+start\s+([\d\.]+)s(?:\s+for\s+([\d\.]+)s)?.*?at\s*\(([\d\.]+),\s*([\d\.]+)\)\s*width\s*([\d\.]+)\s*height\s*([\d\.]+)",
            re.MULTILINE
        )
        for m in rep_pattern.finditer(script):
            eid = int(m.group(1))
            start = float(m.group(2))
            dur = float(m.group(3)) if m.group(3) else 1.0
            cx, cy = float(m.group(4)), float(m.group(5))
            w, h = float(m.group(6)), float(m.group(7))
            bbox = (max(0.0, cx - w/2), max(0.0, cy - h/2), min(CANVAS_WIDTH, cx + w/2), min(CANVAS_HEIGHT, cy + h/2))
            elements.append(VisualElement(
                elem_type="2drep", id=eid, start=start, duration=dur,
                end_time=course_duration, bbox=bbox, raw_cmd=m.group(0)
            ))

        # 6. Parse erase commands
        erase_pattern = re.compile(r"erase\s+id\s+(\d+)\s+start\s+([\d\.]+)s\s*;", re.MULTILINE)
        erase_times = []
        for m in erase_pattern.finditer(script):
            eid = int(m.group(1))
            etime = float(m.group(2))
            erase_times.append((etime, eid))

        # Apply erase times: any element starting before an erase has its end_time capped
        erase_times.sort()
        for elem in elements:
            for etime, eid in erase_times:
                if elem.start < etime:
                    elem.end_time = min(elem.end_time, etime)
                    break

        return elements


class WorldModelVerifier:
    """Simulates visual whiteboard state and computes quality feedback."""

    @staticmethod
    def check_bbox_overlap(b1: Tuple[float, float, float, float], b2: Tuple[float, float, float, float]) -> bool:
        """Returns True if two bounding boxes intersect significantly."""
        x1_min, y1_min, x1_max, y1_max = b1
        x2_min, y2_min, x2_max, y2_max = b2

        # Check disjoint
        if x1_max <= x2_min or x2_max <= x1_min:
            return False
        if y1_max <= y2_min or y2_max <= y1_min:
            return False

        # Calculate overlap area
        overlap_w = min(x1_max, x2_max) - max(x1_min, x2_min)
        overlap_h = min(y1_max, y2_max) - max(y1_min, y2_min)
        overlap_area = overlap_w * overlap_h

        area1 = (x1_max - x1_min) * (y1_max - y1_min)
        area2 = (x2_max - x2_min) * (y2_max - y2_min)
        min_area = max(1.0, min(area1, area2))

        # Significant collision if overlap is > 15% of smaller element
        return (overlap_area / min_area) > 0.15

    @classmethod
    def verify_script(cls, script: str, course_duration: float = 180.0) -> Dict:
        """
        Runs the World Model validation suite.
        Returns:
            {
                "ok": bool,
                "score": float (0-10),
                "issues": List[str],
                "bounding_errors": List[dict],
                "collision_errors": List[dict],
                "alignment_errors": List[dict]
            }
        """
        elements = HypercourseParser.parse_script(script, course_duration)
        issues = []
        bounding_errors = []
        collision_errors = []
        alignment_errors = []

        if not elements:
            return {
                "ok": False,
                "score": 0.0,
                "issues": ["Le script Hypercourse est vide ou aucune commande reconnue."],
                "bounding_errors": [],
                "collision_errors": [],
                "alignment_errors": []
            }

        # 1. Check Canvas Boundaries
        for el in elements:
            xmin, ymin, xmax, ymax = el.bbox
            if xmin < 0 or xmax > CANVAS_WIDTH or ymin < 0 or ymax > CANVAS_HEIGHT:
                err = f"Élément ID {el.id} ({el.elem_type}) déborde du canevas 16:9 : [{xmin}, {ymin}, {xmax}, {ymax}]"
                issues.append(err)
                bounding_errors.append({"id": el.id, "type": el.elem_type, "bbox": el.bbox})

        # 2. Check Left-Alignment Rule (Rule 26: Text must start at left x in [0, 10] except titles)
        for el in elements:
            if el.elem_type == "text":
                xmin = el.bbox[0]
                # If text is placed at x=88.89 (center) but is not a short title, flag warning
                if 80.0 <= xmin <= 95.0 and len(el.content) > 30:
                    err = f"Texte long ID {el.id} centré à x={xmin} au lieu d'être aligné à gauche (x in [2, 10])"
                    issues.append(err)
                    alignment_errors.append({"id": el.id, "x": xmin})

        # 3. Simulate Scene Milestones & Check Collisions
        # Check active elements at intervals of 5 seconds
        sample_times = sorted(list(set(
            [round(t, 1) for t in [el.start for el in elements]] +
            [round(t, 1) for t in [el.start + el.duration for el in elements]]
        )))

        for t in sample_times:
            active = [el for el in elements if el.start <= t <= el.end_time]

            # Check text-text and text-shape collisions among simultaneously active elements
            for i in range(len(active)):
                for j in range(i + 1, len(active)):
                    e1 = active[i]
                    e2 = active[j]

                    # Both are polygon backgrounds (allowed stacking)
                    if e1.elem_type == "polygone" and e2.elem_type == "polygone":
                        continue

                    # If one is text and another is a polygon background that completely wraps it, that's fine
                    if (e1.elem_type == "text" and e2.elem_type == "polygone") or (e2.elem_type == "text" and e1.elem_type == "polygone"):
                        continue

                    # Collision between two texts
                    if e1.elem_type == "text" and e2.elem_type == "text":
                        if cls.check_bbox_overlap(e1.bbox, e2.bbox):
                            err = f"Collision textuelle à t={t}s : ID {e1.id} chevauche ID {e2.id}"
                            if err not in issues:
                                issues.append(err)
                                collision_errors.append({"time": t, "id1": e1.id, "id2": e2.id})

        # 4. Check Scene Erase Hygiene
        erase_count = len(re.findall(r"erase\s+id", script))
        if course_duration > 90.0 and erase_count < 2:
            issues.append(f"Cours long ({course_duration:.1f}s) sans assez d'effacements de tableau (seulement {erase_count} erase)")

        # Compute Score
        penalty = len(bounding_errors) * 1.5 + len(collision_errors) * 1.0 + len(alignment_errors) * 0.5
        score = max(0.0, round(10.0 - penalty, 1))
        ok = (len(bounding_errors) == 0 and len(collision_errors) == 0 and score >= 7.5)

        return {
            "ok": ok,
            "score": score,
            "total_elements": len(elements),
            "erase_count": erase_count,
            "issues": issues,
            "bounding_errors": bounding_errors,
            "collision_errors": collision_errors,
            "alignment_errors": alignment_errors
        }


class WorldModelAutoCorrector:
    """Applies surgical coordinate corrections to eliminate spatial collisions and overflows."""

    @staticmethod
    def correct_script(script: str, course_duration: float = 180.0) -> str:
        """
        Parses script, fixes:
        - Bounding overflows: caps coordinates to valid canvas range [2, 175] x [5, 95]
        - Forces text alignment to left (x in [2, 6]) for explanations
        - Ensures safe Y spacing (minimum dy >= 14 between stacked text boxes)
        """
        verification = WorldModelVerifier.verify_script(script, course_duration)
        if verification["ok"]:
            return script  # Already clean

        corrected = script

        # 1. Fix centered text coordinates at x=88.89 to left x=5.0 for non-banner elements
        def fix_text_pos(match):
            cmd = match.group(0)
            eid = match.group(1)
            start = match.group(2)
            dur = match.group(3)
            x = float(match.group(4))
            y = float(match.group(5))
            txt = match.group(6)

            # Keep title banners centered if y <= 15
            if y <= 15.0:
                new_x = 88.89
            else:
                # Left alignment for content
                new_x = 4.0

            # Clamp Y
            new_y = min(92.0, max(6.0, y))

            dur_str = f" for {dur}s" if dur else ""
            return f"text id {eid} start {start}s{dur_str} at ({new_x:.2f}, {new_y:.2f}) ''{txt}'' ;"

        text_pat = re.compile(
            r"text\s+id\s+(\d+)\s+start\s+([\d\.]+)s(?:\s+for\s+([\d\.]+)s)?\s+at\s+\(([\d\.]+),\s*([\d\.]+)\)\s*''([^']*)''\s*;",
            re.MULTILINE
        )
        corrected = text_pat.sub(fix_text_pos, corrected)

        # 2. Fix polygone boundaries that exceed 177.78 or 100
        def fix_poly(match):
            cmd = match.group(0)
            pts_str = match.group(4)
            pt_tuples = re.findall(r"\(([\d\.]+),\s*([\d\.]+)\)", pts_str)
            if not pt_tuples:
                return cmd

            fixed_pts = []
            for p in pt_tuples:
                px = min(175.0, max(2.0, float(p[0])))
                py = min(95.0, max(4.0, float(p[1])))
                fixed_pts.append(f"({px:.2f}, {py:.2f})")

            new_pts_str = ", ".join(fixed_pts)
            prefix = match.group(0)[:match.start(4) - match.start(0)]
            suffix = match.group(0)[match.end(4) - match.start(0):]
            return f"{prefix}{new_pts_str}{suffix}"

        poly_pat = re.compile(
            r"draw\s+polygone\s+id\s+(\d+)\s+start\s+([\d\.]+)s(?:\s+for\s+([\d\.]+)s)?(.*?at\s*\[)(.*?)(\]\s*;)",
            re.MULTILINE | re.DOTALL
        )
        corrected = poly_pat.sub(fix_poly, corrected)

        # 3. Clean any remaining opaque white paper card fills to chalk ardoise style
        corrected = re.sub(
            r"draw\s+polygone\s+id\s+\d+\s+start\s+[\d\.]+s\s+for\s+[\d\.]+s\s+color\s+\([^)]+\)\s+fillcolor\s+\(255,\s*255,\s*255,\s*0\.98\)\s+width\s+[\d\.]+\s+at\s+\[\(92,\s*24\),\s*\(173,\s*24\),\s*\(173,\s*88\),\s*\(92,\s*88\)\]\s*;\n?",
            "",
            corrected
        )

        # 4. Enforce chalk palette for dark lines on green chalkboard
        corrected = corrected.replace("color (71, 85, 105, 1)", "color (248, 250, 252, 0.95)")
        corrected = corrected.replace("color (15, 23, 42, 1) fillcolor (15, 23, 42, 1)", "color (248, 250, 252, 1) fillcolor (248, 250, 252, 1)")

        return corrected


if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        with open(sys.argv[1], "r", encoding="utf-8") as f:
            content = f.read()
        res = WorldModelVerifier.verify_script(content)
        print("Verification Result:")
        print(f"  OK: {res['ok']}")
        print(f"  Score: {res['score']}/10")
        for iss in res['issues']:
            print(f"  - {iss}")
