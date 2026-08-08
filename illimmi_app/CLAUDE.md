# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

ILLIMMI is a Flutter app that parses and plays back **Hypercourse**, a custom DSL for
synchronizing visual teaching aids (text, shapes, cursor animation) with an audio
narration track. The full DSL reference, the 3-layer AI content-generation pipeline
(planning → audio/TTS → visual-aid generation), and the YouTube-based dataset pipeline
for fine-tuning the visual-aid generator are documented in `illimmi-doc.md` — read it
before making changes to the parser, tokenizer, or element model, since the DSL grammar
lives there, not in code comments.

## Commands

Standard Flutter workflow (run from `illimmi_app/`):

```bash
flutter pub get              # install dependencies
flutter analyze              # static analysis (flutter_lints rules, see analysis_options.yaml)
flutter test                 # run all tests
flutter test test/widget_test.dart   # run a single test file
flutter run                  # run lib/main.dart (see "Entry points" below)
flutter run -d windows        # run on a specific platform (windows/chrome/android/etc.)
```

There is no lint/test script beyond the Flutter defaults; there's a single test file
(`test/widget_test.dart`, currently a template — not yet adapted to this app's widgets).

## Entry points (important gotcha)

Three files in `lib/` have executable `main()` functions, and only one is the real app:

- `lib/main.dart` — **the actual entry point**. Defines the `MyApp` widget inline and
  `HypercourseDebugPage`, which reads `courses/introduction_geometrie.hc` from disk (relative to
  `Directory.current.path`, same convention as `PiperServices`), parses it, and launches
  `CoursePlayer`. This is what `flutter run` uses by default.
- `lib/my_app.dart` — despite the name, this is a disconnected manual test harness for
  `PiperServices` (TTS). It does **not** define the `MyApp` widget (that lives in
  `main.dart`) and is not imported anywhere. Only run it directly via `flutter run -t lib/my_app.dart`.
- `lib/main_set.dart` — another disconnected scratch entry point for exercising the
  parser directly. Also unused by default.

Don't assume importing `my_app.dart` gets you the `MyApp` widget — it won't.

## Architecture

### Pipeline: script text → tokens → Course → rendered frames

```
.hc script (String)
   → Tokenizer (lib/parsers/tokenizer/)         produces Token stream
   → HypercourseParser (lib/parsers/hypercourse_parser.dart)
        walks tokens, dispatches each top-level command to CommandParserFactory
   → Course (lib/models/course.dart)             holds all HyperElements
   → CoursePlayer (lib/player/course_player.dart) drives an AnimationController,
        queries Course.queryAll(currentTime) every tick
   → BoardPainter / LatexWidget / PlotWidget      render the elements currently alive
```

### Triple parallel factory pattern (the main extension point)

Adding a new `draw <shape>` command touches three symmetric locations, each with its
own factory dispatching on a type string:

1. **Command level** — `CommandParserFactory` (`lib/parsers/command_parsers/`) dispatches
   the top-level keyword (`text`, `draw`, `plot`, `erase`, `speech`, `mouse`) to a
   `CommandParser`. The `draw` command parser itself delegates further.
2. **Draw-shape level** — `DrawParserFactory` (`lib/parsers/draw_parsers/`) dispatches
   `draw <shape>` (`line`, `path`, `curve`, `polygon`, `circle`, `ellipse`, `arc`,
   `elliptic_arc`, `repere2d`, `function2d`) to a `DrawParser`, which builds the
   corresponding model in `lib/models/draw_elements/`.
3. **Rendering level** — `ElementPainterFactory` (`lib/board_painter/element_painters/`)
   dispatches a parsed `DrawElement` subtype to an `ElementPainter` that draws it on the
   `Canvas` in `board_painter.dart`.

A new shape therefore needs: a model in `models/draw_elements/`, a parser in
`parsers/draw_parsers/` registered in `DrawParserFactory._parsers`, and a painter in
`board_painter/element_painters/` registered in `ElementPainterFactory._painters`.
Follow the existing shapes (e.g. `circle_*`) as the template — the parsing convention
(loop over tokens until `;`, dispatch on keyword like `start`/`for`/`color`/`at`) is
identical across all draw parsers.

### ID namespace and families (`lib/models/id_config.dart`)

Every element ID must fall in a range determined by `idgap`: `text` is `1..idgap`,
`draw` is `idgap+1..2*idgap`, `speech` is `2*idgap+1..3*idgap`, `mouse` is
`3*idgap+1..4*idgap`, `erase` is `4*idgap+1..5*idgap`. `IdConfig.getFamilyIndex` derives
the family purely from the numeric ID — there's no explicit tagging. This determines
which `FamilyForest` (see below) an element is inserted into.

### Temporal index (`lib/models/course.dart`)

`Course` doesn't do a linear scan for "what's visible at time T". Each element family
gets its own `FamilyForest`, a binary segment tree (`SegmentNode`) over the timeline;
elements are inserted into the tree node(s) whose interval they cover (with a 0.5s
tolerance to avoid over-fragmenting near boundaries, and elements straddling a split
point get inserted into both children). `Course.queryAll(time)` walks every family's
tree and buckets currently-alive elements into `dynamicElement` (still animating: `time
<= startTime + duration`) vs `staticElement` (fully settled). `erase` doesn't remove
elements — it mutates the target's `endTime` in place (`HyperElement.endTime` is
mutable), which the tree already reflects since elements are stored by reference.
`Course.queryAll` also caches the last query time/result since it's called every
animation tick.

### Speech/TTS and temporal correction (legacy path)

`speech` commands are legacy (superseded by the external-audio model described in
`illimmi-doc.md` §1.1, where a course header specifies `audio "<file>.wav"` instead).
When a script does use `speech`, `HypercourseParser._applyTemporalCorrections` runs
**after** all elements are parsed but **before** they're inserted into `Course`: it
synthesizes each `SpeechElement`'s audio via `PiperServices` (bundled `speaker/piper/piper.exe`
subprocess + `speaker/piper/model/fr_FR-siwis-medium.onnx`), learns the real audio
duration, and shifts every later element's `startTime`/`endTime` forward to avoid
overlapping narrations — this is why insertion into `Course` must happen after this
async pass, not during parsing (see the comment in that method). Synthesized `.wav`
files are cached under `speaker/audios/<courseName>_<courseId>/` and reused if present.

### Rendering layout

`CoursePlayer` maps the DSL's normalized 16:9 coordinate space (`(0,0)`–`(177.78,100)`,
see `illimmi-doc.md` §1.2) onto the actual widget size itself (uniform scale + letterbox
offset computed in `_buildWhiteboardContent`), rather than delegating that to
`CoordinateSystem` (which `BoardPainter` uses internally for `CustomPainter` drawing).
Elements are split into a static layer (`isStatic: true`, always full-opacity/complete)
and a dynamic layer (progress-animated) painted in separate `Stack`s/`RepaintBoundary`s
per frame, driven by `Course.queryAll`.

`plot` command elements (`PlotElement`/`PlotWidget`) render via `webview_flutter` and
expect a **local Python server at `http://127.0.0.1:5000/plot_interactive`** that turns
submitted code into HTML — this is an external dependency not bundled in this repo; the
`plot` command won't work without that server running separately.

### Text/LaTeX formatting

`board_writter/latex_widget.dart` (`AdvancedTextWidget`, aliased as `LatexWidget`) parses
Hypercourse's inline text markup (`[bold]`, `[italic]`, `[color=#RRGGBB]`, `[font=...]`,
`$...$`/`$$...$$` for inline/display LaTeX via `flutter_math_fork`) and drives a
character-by-character reveal animation keyed off `progress`, treating each LaTeX
formula as a single "character" for animation-length purposes.

## Platform scaffolding

Platform folders (`android/`, `ios/`, `linux/`, `macos/`, `windows/`, `web/`) are
standard Flutter-generated scaffolding — don't hand-edit generated files
(`generated_plugin_registrant.*`, `.flutter-plugins-dependencies`, `.dart_tool/`, etc.).
