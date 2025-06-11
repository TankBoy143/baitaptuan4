import 'package:library_manager/model/book.dart';

abstract class AbstractBookRepository {
  List<Book> getBooks();
  Book? getBookById(String id);
  void addBook(Book book);
  void updateBook(Book updated);
  void removeBook(Book book);
}