import 'package:flutter/cupertino.dart';
import 'package:library_manager/data/abstract_book_repository.dart';
import 'package:library_manager/model/book.dart';
import 'package:library_manager/data/book_repository.dart';
import 'package:library_manager/view/create_book_screen.dart';
import 'package:library_manager/view/update_book_screen.dart';

class BookManagerScreen extends StatefulWidget {
  const BookManagerScreen({super.key});

  @override
  State<BookManagerScreen> createState() => _BookManagerScreenState();
}

class _BookManagerScreenState extends State<BookManagerScreen> {
  final AbstractBookRepository _bookRepository = BookRepository();

  void _navigateToCreateBook(BuildContext context) async {
    final newBook = await Navigator.of(context).push<Book>(
      CupertinoPageRoute(builder: (_) => CreateBookScreen()),
    );

    if (newBook != null) {
      setState(() {
        _bookRepository.addBook(newBook);
      });
    }
  }

  void _navigateToUpdateBook(BuildContext context, Book book) async {
    final updatedBook = await Navigator.of(context).push<Book>(
      CupertinoPageRoute(
        builder: (_) => UpdateBookScreen(book: book),
      ),
    );

    if (updatedBook != null) {
      setState(() {
        _bookRepository.updateBook(updatedBook);
      });
    }
  }

  void _confirmDeleteBook(BuildContext context, Book book) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Xác nhận'),
        content: Text('Bạn có chắc muốn xóa sách "${book.title}" không?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Hủy'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Xóa'),
            onPressed: () {
              setState(() {
                _bookRepository.removeBook(book);
              });
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final books = _bookRepository.getBooks();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Quản lý sách'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.add),
          onPressed: () => _navigateToCreateBook(context),
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (_, index) {
            final book = books[index];
            return Dismissible(
              key: ValueKey(book.id),
              direction: DismissDirection.endToStart,
              confirmDismiss: (_) async {
                _confirmDeleteBook(context, book);
                return false; // Không xóa ngay, chờ xác nhận
              },
              background: Container(
                color: CupertinoColors.systemRed,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(CupertinoIcons.delete, color: CupertinoColors.white),
              ),
              child: CupertinoListTile(
                title: Text(book.title),
                subtitle: Text('ID: ${book.id}'),
                onTap: () => _navigateToUpdateBook(context, book), // Điều hướng đến màn hình cập nhật
              ),
            );
          },
        ),
      ),
    );
  }
}
