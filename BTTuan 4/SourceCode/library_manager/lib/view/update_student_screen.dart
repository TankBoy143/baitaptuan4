import 'package:flutter/cupertino.dart';
import 'package:library_manager/model/student.dart';

class UpdateStudentScreen extends StatefulWidget {
  final Student student;

  const UpdateStudentScreen({super.key, required this.student});

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.student.name; // Khởi tạo tên sinh viên
  }

  void _updateStudent() {
    final name = _nameController.text.trim();

    if (name.isNotEmpty) {
      final updatedStudent = Student(
        id: widget.student.id,
        name: name,
        borrowedBooks: widget.student.borrowedBooks,
      );
      Navigator.of(context).pop(updatedStudent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cập nhật sinh viên'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CupertinoTextField(
                controller: _nameController,
                placeholder: 'Tên sinh viên',
              ),
              const SizedBox(height: 32),
              CupertinoButton.filled(
                onPressed: _updateStudent,
                child: const Text('Cập nhật'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}