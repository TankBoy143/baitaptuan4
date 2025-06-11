import 'package:flutter/cupertino.dart';
import 'package:library_manager/model/book.dart';

class UpdateBookScreen extends StatefulWidget {
  final Book book;

  const UpdateBookScreen({super.key, required this.book});

  @override
  State<UpdateBookScreen> createState() => _UpdateBookScreenState();
}

class _UpdateBookScreenState extends State<UpdateBookScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.book.title; // Khởi tạo tiêu đề sách
  }

  void _updateBook() {
    final title = _titleController.text.trim();

    if (title.isNotEmpty) {
      final updatedBook = Book(
        id: widget.book.id,
        title: title,
      );
      Navigator.of(context).pop(updatedBook);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cập nhật sách'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CupertinoTextField(
                controller: _titleController,
                placeholder: 'Tiêu đề sách',
              ),
              const SizedBox(height: 32),
              CupertinoButton.filled(
                onPressed: _updateBook,
                child: const Text('Cập nhật'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}