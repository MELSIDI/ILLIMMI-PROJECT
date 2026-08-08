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
  test('groups elements finishing at the same instant into one capture point', () {
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
    final times = batches.first.points.map((p) => p.time).toList();
    expect(times, [1.0, 5.0]);

    final sharedPoint = batches.first.points.firstWhere((p) => p.time == 5.0);
    expect(sharedPoint.triggerElementIds, [2, 100002]);
  });

  test('splits batches at erase boundaries', () {
    final course = _buildCourse();
    course.insert(
      TextElement(id: 1, startTime: 0, duration: 1, content: 'a', position: const Offset(0, 0)),
    );
    course.insert(
      CircleElement(id: 100001, startTime: 1, duration: 1, width: 2, center: const Offset(5, 5), radius: 2),
    );
    course.handleErase(1, 6.0);
    course.insert(EraseElement(id: 400001, startTime: 6, duration: 0, idsToErase: const [1]));
    course.insert(
      TextElement(id: 2, startTime: 7, duration: 1, content: 'c', position: const Offset(0, 0)),
    );

    final batches = planCaptures(course);
    expect(batches, hasLength(2));
    expect(batches[0].points.map((p) => p.time), [1.0, 2.0]);
    expect(batches[1].points.map((p) => p.time), [8.0]);
  });

  test('caps a scene at maxCapturePointsPerBatch, splitting chronologically', () {
    final course = _buildCourse();
    for (var i = 0; i < 20; i++) {
      course.insert(
        TextElement(
          id: i + 1,
          startTime: i.toDouble(),
          duration: 0,
          content: 'e$i',
          position: const Offset(0, 0),
        ),
      );
    }

    final batches = planCaptures(course);
    expect(batches, hasLength(2));
    expect(batches[0].points, hasLength(maxCapturePointsPerBatch));
    expect(batches[1].points, hasLength(20 - maxCapturePointsPerBatch));
  });

  test('ignores erase and speech elements as capture triggers', () {
    final course = _buildCourse();
    course.insert(EraseElement(id: 400001, startTime: 1, duration: 0, idsToErase: const []));

    final batches = planCaptures(course);
    expect(batches, isEmpty);
  });
}
