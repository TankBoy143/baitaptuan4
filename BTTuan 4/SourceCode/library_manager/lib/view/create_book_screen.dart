
import 'package:flutter/cupertino.dart';
import 'package:library_manager/model/book.dart';

class CreateBookScreen extends StatefulWidget {
  const CreateBookScreen({super.key});

  @override
  State<CreateBookScreen> createState() => _CreateBookScreenState();
}

class _CreateBookScreenState extends State<CreateBookScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  void _save() {
    final id = _idController.text.trim();
    final title = _titleController.text.trim();

    if (id.isNotEmpty && title.isNotEmpty) {
      final book = Book(id: id, title: title);
      Navigator.of(context).pop(book);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Thêm sách mới'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CupertinoTextField(
                controller: _idController,
                placeholder: 'ID sách',
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _titleController,
                placeholder: 'Tên sách',
              ),
              const SizedBox(height: 32),
              CupertinoButton.filled(
                onPressed: _save,
                child: const Text('Lưu sách'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
