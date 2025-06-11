import 'package:collection/collection.dart';
import 'package:library_manager/data/abstract_book_repository.dart';
import 'package:library_manager/model/book.dart';

class BookRepository implements AbstractBookRepository {
  // Private constructor
  BookRepository._internal();

  // Singleton instance
  static final BookRepository _instance = BookRepository._internal();

  // Factory constructor
  factory BookRepository() => _instance;

  final List<Book> _books = [
    Book(id: '1', title: 'Sách 01'),
    Book(id: '2', title: 'Sách 02'),
    Book(id: '3', title: 'Sách 03'),
    Book(id: '4', title: 'Sách 04'),
  ];

  @override
  List<Book> getBooks() {
    return _books;
  }

  @override
  Book? getBookById(String id) {
    return _books.firstWhereOrNull((book) => book.id == id);
  }

  @override
  void addBook(Book book) => _books.add(book);

  @override
  void updateBook(Book updated) {
    final index = _books.indexWhere((s) => s.id == updated.id);
    if (index != -1) {
      _books[index] = updated;
    }
  }

  @override
  void removeBook(Book book) {
    _books.remove(book);
  }
}
