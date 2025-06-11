import 'package:library_manager/model/book.dart';

class Student {
  final String id;
  final String name;
  final List<Book> borrowedBooks;

  Student({required this.id, required this.name, required this.borrowedBooks});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Student &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
