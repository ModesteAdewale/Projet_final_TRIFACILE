class RecyclingPoint {
  const RecyclingPoint({
    required this.id,
    required this.name,
    required this.address,
    required this.acceptedWaste,
    this.description = '',
  });
  final String id;
  final String name;
  final String address;
  final List<String> acceptedWaste;
  final String description;
}
