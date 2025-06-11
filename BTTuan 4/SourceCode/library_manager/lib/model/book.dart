class Book {
  final String id;
  final String title;

  Book({
    required this.id,
    required this.title,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Book &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
