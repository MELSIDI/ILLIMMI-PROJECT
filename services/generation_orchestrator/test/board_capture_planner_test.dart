import 'package:test/test.dart';
import 'package:generation_orchestrator/hc_types.dart';
import 'package:generation_orchestrator/models/basic_elements/erase_element.dart';
import 'package:generation_orchestrator/models/basic_elements/text_element.dart';
import 'package:generation_orchestrator/models/course.dart';
import 'package:generation_orchestrator/models/draw_elements/arrow_element.dart';
import 'package:generation_orchestrator/models/draw_elements/circle_element.dart';
import 'package:generation_orchestrator/models/id_config.dart';
import 'package:generation_orchestrator/pipeline/board_capture_planner.dart';

Course _buildCourse() => Course('Test', IdConfig(duration: 120));

void main() {
  test('plans exactly 1 pre-erase scene capture for a course without erase', () {
    final course = _buildCourse();
    course.insert(
      TextElement(id: 1, startTime: 0, duration: 1, content: 'a', position: const Offset(0, 0)),
    );
    course.insert(
      ArrowElement(
        id: 100002,
        startTime: 5,
        duration: 0,
        width: 2,
        from: const Offset(0, 0),
        to: const Offset(1, 1),
      ),
    );
    course.insert(
      TextElement(id: 2, startTime: 5, duration: 0, content: 'b', position: const Offset(1, 1)),
    );

    final batches = planCaptures(course);
    expect(batches, hasLength(1));
    expect(batches.first.points, hasLength(1));

    final point = batches.first.points.first;
    expect(point.time, 5.0);
    expect(point.triggerElementIds, [1, 2, 100002]);
    expect(point.mutableElementIds, [1, 2, 100002]);
    expect(point.immutableElementIds, isEmpty);
  });

  test('plans pre-erase scene captures at erase boundaries and tracks mutable vs immutable elements', () {
    final course = _buildCourse();
    course.insert(
      TextElement(id: 1, startTime: 0, duration: 1, content: 'a', position: const Offset(0, 0)),
    );
    course.insert(
      CircleElement(id: 100001, startTime: 1, duration: 1, width: 2, center: const Offset(5, 5), radius: 2),
    );
    
    // Erase element 100001 at t=6s. Element 1 survives.
    course.handleErase(100001, 6.0);
    course.insert(EraseElement(id: 400001, startTime: 6, duration: 0, idsToErase: const [100001]));

    course.insert(
      TextElement(id: 2, startTime: 7, duration: 1, content: 'c', position: const Offset(0, 0)),
    );

    final batches = planCaptures(course);
    expect(batches, hasLength(1));
    expect(batches.first.points, hasLength(2)); // Scene 1 (pre-erase) + Scene 2 (final)

    final point1 = batches.first.points[0];
    expect(point1.time, 2.0); // max(1, 2)
    expect(point1.triggerElementIds, [1, 100001]);
    expect(point1.mutableElementIds, [1, 100001]);
    expect(point1.immutableElementIds, isEmpty);

    final point2 = batches.first.points[1];
    expect(point2.time, 8.0); // 7 + 1
    expect(point2.triggerElementIds, [1, 2]); // Element 1 survived, Element 2 is new
    expect(point2.mutableElementIds, [2]);    // Element 2 needs check
    expect(point2.immutableElementIds, [1]);  // Element 1 is already verified!
  });

  test('ignores erase and speech elements as capture triggers', () {
    final course = _buildCourse();
    course.insert(EraseElement(id: 400001, startTime: 1, duration: 0, idsToErase: const []));

    final batches = planCaptures(course);
    expect(batches, isEmpty);
  });
}

