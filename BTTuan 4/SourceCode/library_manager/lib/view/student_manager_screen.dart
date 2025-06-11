import 'package:flutter/cupertino.dart';
import 'package:library_manager/data/abstract_student_repository.dart';
import 'package:library_manager/model/student.dart';
import 'package:library_manager/data/student_repository.dart';
import 'package:library_manager/view/create_student_screen.dart';
import 'package:library_manager/view/update_student_screen.dart';

class StudentManagerScreen extends StatefulWidget {
  const StudentManagerScreen({super.key});

  @override
  State<StudentManagerScreen> createState() => _StudentManagerScreenState();
}

class _StudentManagerScreenState extends State<StudentManagerScreen> {
  final AbstractStudentRepository _studentRepository = StudentRepository();

  void _navigateToCreateStudent(BuildContext context) async {
    final newStudent = await Navigator.of(context).push<Student>(
      CupertinoPageRoute(builder: (_) => const CreateStudentScreen()),
    );

    if (newStudent != null) {
      setState(() {
        _studentRepository.addStudent(newStudent);
      });
    }
  }

  void _navigateToUpdateStudent(BuildContext context, Student student) async {
    final updatedStudent = await Navigator.of(context).push<Student>(
      CupertinoPageRoute(
        builder: (_) => UpdateStudentScreen(student: student),
      ),
    );

    if (updatedStudent != null) {
      setState(() {
        _studentRepository.updateStudent(updatedStudent);
      });
    }
  }

  void _confirmDeleteStudent(BuildContext context, Student student) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Xác nhận'),
        content: Text('Bạn có chắc muốn xóa sinh viên "${student.name}" không?'),
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
                _studentRepository.removeStudent(student);
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
    final students = _studentRepository.getStudents();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Danh sách sinh viên'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.add),
          onPressed: () => _navigateToCreateStudent(context),
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: students.length,
          itemBuilder: (_, index) {
            final student = students[index];
            return Dismissible(
              key: ValueKey(student.id),
              direction: DismissDirection.endToStart,
              confirmDismiss: (_) async {
                _confirmDeleteStudent(context, student);
                return false; // không xóa ngay lập tức
              },
              background: Container(
                color: CupertinoColors.systemRed,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(CupertinoIcons.delete, color: CupertinoColors.white),
              ),
              child: CupertinoListTile(
                title: Text(student.name),
                subtitle: Text(
                  student.borrowedBooks.isNotEmpty
                      ? 'Mượn: ${student.borrowedBooks.map((b) => b.title).join(', ')}'
                      : 'Chưa mượn sách',
                ),
                onTap: () => _navigateToUpdateStudent(context, student), // Điều hướng đến màn hình cập nhật
              ),
            );
          },
        ),
      ),
    );
  }
}
