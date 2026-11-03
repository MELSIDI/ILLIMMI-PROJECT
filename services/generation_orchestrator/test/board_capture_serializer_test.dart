import 'package:test/test.dart';
import 'package:generation_orchestrator/hc_types.dart';
import 'package:generation_orchestrator/models/basic_elements/plot_element.dart';
import 'package:generation_orchestrator/models/basic_elements/text_element.dart';
import 'package:generation_orchestrator/models/course.dart';
import 'package:generation_orchestrator/models/draw_elements/arrow_element.dart';
import 'package:generation_orchestrator/models/draw_elements/circle_element.dart';
import 'package:generation_orchestrator/models/draw_elements/repere2d_element.dart';
import 'package:generation_orchestrator/models/id_config.dart';
import 'package:generation_orchestrator/pipeline/board_capture_planner.dart';
import 'package:generation_orchestrator/pipeline/board_capture_serializer.dart';

Course _buildCourse() => Course('Test', IdConfig(duration: 60));

void main() {
  test('serializes a text element with its id, content and position', () {
    final course = _buildCourse();
    course.insert(
      TextElement(
        id: 1,
        startTime: 0,
        duration: 1,
        content: r'$x^2$',
        position: const Offset(10, 20),
      ),
    );

    final point = CapturePoint(time: 1, triggerElementIds: const [1]);
    final json = serializeCapturePoint(course, point);

    expect(json['time'], 1.0);
    expect(json['triggerElementIds'], [1]);
    final elements = json['elements'] as List;
    expect(elements, hasLength(1));
    expect(elements.first, {
      'type': 'text',
      'id': 1,
      'startTime': 0.0,
      'duration': 1.0,
      'endTime': null,
      'content': r'$x^2$',
      'position': {'dx': 10.0, 'dy': 20.0},
    });
  });

  test('serializes an arrow (ArrowElement) with isArrow=true and text references', () {
    final course = _buildCourse();
    course.insert(
      TextElement(id: 1, startTime: 0, duration: 0, content: 'a', position: const Offset(0, 0)),
    );
    course.insert(
      TextElement(id: 2, startTime: 0, duration: 0, content: 'b', position: const Offset(10, 10)),
    );
    course.insert(
      ArrowElement(
        id: 100001,
        startTime: 1,
        duration: 1,
        width: 2,
        fromTextId: 1,
        toTextId: 2,
      ),
    );

    final point = CapturePoint(time: 2, triggerElementIds: const [100001]);
    final json = serializeCapturePoint(course, point);
    final elements = json['elements'] as List;
    final arrowJson = elements.firstWhere((e) => e['id'] == 100001) as Map<String, dynamic>;

    expect(arrowJson['type'], 'line');
    expect(arrowJson['isArrow'], true);
    expect(arrowJson['fromTextId'], 1);
    expect(arrowJson['toTextId'], 2);
    expect(arrowJson['from'], isNull);
    expect(arrowJson['to'], isNull);
  });

  test('serializes a circle with color and fillColor', () {
    final course = _buildCourse();
    course.insert(
      CircleElement(
        id: 100001,
        startTime: 0,
        duration: 1,
        width: 3,
        color: const Color.fromRGBO(255, 0, 0, 1.0),
        center: const Offset(5, 5),
        radius: 2,
        fillColor: const Color.fromRGBO(0, 255, 0, 0.5),
      ),
    );

    final point = CapturePoint(time: 1, triggerElementIds: const [100001]);
    final json = serializeCapturePoint(course, point);
    final circleJson = (json['elements'] as List).first as Map<String, dynamic>;

    expect(circleJson['type'], 'circle');
    expect(circleJson['color'], {'red': 255, 'green': 0, 'blue': 0, 'opacity': 1.0});
    expect(circleJson['fillColor'], {'red': 0, 'green': 255, 'blue': 0, 'opacity': 0.5});
    expect(circleJson['radius'], 2.0);
  });

  test('skips plot elements (webview rendering is out of scope)', () {
    final course = _buildCourse();
    course.insert(
      PlotElement(id: 100001, startTime: 0, duration: 1, position: const Offset(0, 0), code: 'fig=1'),
    );

    final point = CapturePoint(time: 1, triggerElementIds: const [100001]);
    final json = serializeCapturePoint(course, point);

    expect(json['elements'], isEmpty);
  });

  test('serializes repere2d element with grid, gridAlpha, step and showLabels', () {
    final course = _buildCourse();
    course.insert(
      Repere2DElement(
        id: 100002,
        startTime: 2.0,
        duration: 1.5,
        origin: const Offset(132, 56),
        xStart: -4,
        xEnd: 4,
        yStart: -2,
        yEnd: 6,
        scale: 6.5,
        grid: true,
        gridAlpha: 0.75,
        step: 1.0,
        showLabels: true,
      ),
    );

    final point = CapturePoint(time: 3, triggerElementIds: const [100002]);
    final json = serializeCapturePoint(course, point);
    final elements = json['elements'] as List;
    final repereJson = elements.firstWhere((e) => e['id'] == 100002) as Map<String, dynamic>;

    expect(repereJson['type'], 'repere2d');
    expect(repereJson['origin'], {'dx': 132.0, 'dy': 56.0});
    expect(repereJson['scale'], 6.5);
    expect(repereJson['grid'], true);
    expect(repereJson['gridAlpha'], 0.75);
    expect(repereJson['step'], 1.0);
    expect(repereJson['showLabels'], true);
    expect(repereJson['xStart'], -4.0);
    expect(repereJson['xEnd'], 4.0);
  });
}
