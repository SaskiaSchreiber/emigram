import "package:collection/collection.dart";

class MockData {
  final double x;
  final double y;
  MockData({required this.x, required this.y});
}

List<MockData> get mockData  {
  final data = <double>[100,120,98,99,111,113,119,45,117,119,101,112];
  return data
      .mapIndexed(
      ((index, element)=> MockData(x: index.toDouble(), y: element)))
      .toList();
}
