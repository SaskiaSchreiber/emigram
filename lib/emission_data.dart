import "package:collection/collection.dart";

class EmissionData {
  final double x;
  final double y;
  EmissionData({required this.x, required this.y});
}

List<EmissionData> get emissionData {
  final data = <double>[2,4,6,11,3,6,4];
  return data
      .mapIndexed(
      ((index, element)=> EmissionData(x: index.toDouble(), y: element)))
      .toList();
}