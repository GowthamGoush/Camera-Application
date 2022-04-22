import 'dart:math';
import '../design_constants.dart';

Point generateRandomPoint(int maxWidth, int maxHeight) {
  final rand = Random();

  int x = rand.nextInt(maxWidth);
  int y = rand.nextInt(maxHeight);

  return Point(x, y);
}

List<Point> generateMultipleRandomPoints(int maxWidth, int maxHeight) {
  List<Point> points = [];

  for(int i = 0; i < maxPoints; i++) {
    points.add(generateRandomPoint(maxWidth, maxHeight));
  }

  return points;
}

bool isInsidePolygon(Point point, List vs) {
  var x = point.x, y = point.y;

  var inside = false;
  for (var i = 0, j = vs.length - 1; i < vs.length; j = i++) {
    var xi = vs[i][0], yi = vs[i][1];
    var xj = vs[j][0], yj = vs[j][1];

    var intersect = ((yi > y) != (yj > y))
        && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
    if (intersect) inside = !inside;
  }

  return inside;
}