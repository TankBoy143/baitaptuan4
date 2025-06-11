import 'package:flutter/cupertino.dart';
import 'package:library_manager/model/student.dart';

class CreateStudentScreen extends StatefulWidget {
  const CreateStudentScreen({super.key});

  @override
  State<CreateStudentScreen> createState() => _CreateStudentScreenState();
}

class _CreateStudentScreenState extends State<CreateStudentScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void _saveStudent() {
    final id = _idController.text.trim();
    final name = _nameController.text.trim();

    if (id.isNotEmpty && name.isNotEmpty) {
      final newStudent = Student(id: id, name: name, borrowedBooks: []);
      Navigator.of(context).pop(newStudent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Thêm sinh viên'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CupertinoTextField(
                controller: _idController,
                placeholder: 'Mã sinh viên',
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _nameController,
                placeholder: 'Tên sinh viên',
              ),
              const SizedBox(height: 32),
              CupertinoButton.filled(
                onPressed: _saveStudent,
                child: const Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
