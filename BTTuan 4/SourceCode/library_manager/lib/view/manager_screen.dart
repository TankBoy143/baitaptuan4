import 'package:flutter/cupertino.dart';
import 'package:library_manager/data/abstract_book_repository.dart';
import 'package:library_manager/data/abstract_student_repository.dart';
import 'package:library_manager/data/book_repository.dart';
import 'package:library_manager/data/student_repository.dart';
import 'package:library_manager/model/student.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({super.key});

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  final AbstractBookRepository _bookRepository = BookRepository();
  final AbstractStudentRepository _studentRepository = StudentRepository();

  Student? _selectedStudent;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Center(
                child: Text(
                  'Hệ Thống\nQuản lý Thư viện',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Sinh viên',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedStudent?.name ?? 'Chọn sinh viên',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text(
                      'Thay đổi',
                      style: TextStyle(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      _showStudentPicker(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Danh sách sách',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            if (_selectedStudent == null)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Vui lòng chọn sinh viên'),
              )
            else if (_selectedStudent!.borrowedBooks.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Bạn chưa mượn quyền sách nào'),
                    const SizedBox(height: 4),
                    const Text(
                      'Nhấn \'Thêm\' để bắt đầu hành trình đọc sách!',
                      style: TextStyle(color: CupertinoColors.secondaryLabel),
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._selectedStudent!.borrowedBooks.map(
                      (book) => Row(
                        children: [
                          const Icon(
                            CupertinoIcons.check_mark_circled_solid,
                            color: CupertinoColors.activeGreen,
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(book.title)),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Icon(
                              CupertinoIcons.delete,
                              color: CupertinoColors.destructiveRed,
                              size: 24,
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedStudent!.borrowedBooks.remove(book);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed:
                      _selectedStudent == null
                          ? null
                          : () => _showBookPicker(context),
                  child: const Text('Thêm'),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showStudentPicker(BuildContext context) {
    final students = _studentRepository.getStudents();
    int selectedIndex =
        _selectedStudent == null
            ? 0
            : students.indexWhere((s) => s.id == _selectedStudent!.id);

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Hủy'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    'Chọn sinh viên',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  CupertinoButton(
                    child: const Text('Xong'),
                    onPressed: () {
                      setState(() {
                        _selectedStudent = students[selectedIndex];
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedIndex,
                  ),
                  onSelectedItemChanged: (int index) {
                    selectedIndex = index;
                  },
                  children:
                      students
                          .map((student) => Center(child: Text(student.name)))
                          .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBookPicker(BuildContext context) {
    final books =
        _bookRepository
            .getBooks()
            .where(
              (book) =>
                  _selectedStudent == null ||
                  !_selectedStudent!.borrowedBooks.contains(book),
            )
            .toList();

    if (books.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder:
            (_) => CupertinoAlertDialog(
              title: Text('No books available'),
              content: Text('All books have been borrowed by this student.'),
              actions: [
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
      return;
    }

    int selectedIndex = 0;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Select Book',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  CupertinoButton(
                    child: const Text('Add'),
                    onPressed: () {
                      setState(() {
                        _selectedStudent!.borrowedBooks.add(
                          books[selectedIndex],
                        );
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    selectedIndex = index;
                  },
                  children:
                      books
                          .map((book) => Center(child: Text(book.title)))
                          .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
