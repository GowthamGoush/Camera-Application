import 'dart:math';

Point generateRandomPoint(int maxWidth, int maxHeight) {
  final rand = Random();

  int x = rand.nextInt(maxWidth);
  int y = rand.nextInt(maxHeight);

  return Point(x, y);
}

List<Point> generateMultipleRandomPoints(int maxWidth, int maxHeight) {
  List<Point> points = [];

  points.add(generateRandomPoint(maxWidth, maxHeight));
  points.add(generateRandomPoint(maxWidth, maxHeight));
  points.add(generateRandomPoint(maxWidth, maxHeight));

  return points;
}