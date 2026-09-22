class WasteReport {
  const WasteReport({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.createdAt,
  });
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime createdAt;

  Map<String, dynamic> toMap() => {
    'id': id, 'title': title, 'description': description,
    'location': location, 'createdAt': createdAt.toIso8601String(),
  };

  factory WasteReport.fromMap(Map<String, dynamic> map) => WasteReport(
    id: map['id'] as String,
    title: map['title'] as String,
    description: map['description'] as String,
    location: map['location'] as String,
    createdAt: DateTime.parse(map['createdAt'] as String),
  );
}
