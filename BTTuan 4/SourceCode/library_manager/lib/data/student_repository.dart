import 'package:collection/collection.dart';
import 'package:library_manager/data/abstract_student_repository.dart';
import 'package:library_manager/model/book.dart';
import 'package:library_manager/model/student.dart';

class StudentRepository implements AbstractStudentRepository {
  // Private constructor
  StudentRepository._internal();

  // Singleton instance
  static final StudentRepository _instance = StudentRepository._internal();

  // Factory constructor
  factory StudentRepository() => _instance;

  final List<Student> _students = [
    Student(
      id: '1',
      name: 'Nguyễn Văn A',
      borrowedBooks: [
        Book(id: '1', title: 'Sách 01'),
        Book(id: '2', title: 'Sách 02'),
      ],
    ),
    Student(
      id: '2',
      name: 'Trần Thị B',
      borrowedBooks: [Book(id: '1', title: 'Sách 01')],
    ),
    Student(id: '3', name: 'Lê Văn C', borrowedBooks: []),
    Student(id: '4', name: 'Phạm Thị D', borrowedBooks: []),
  ];

  @override
  List<Student> getStudents() {
    return _students;
  }

  @override
  Student? getStudentById(String id) {
    return _students.firstWhereOrNull((student) => student.id == id);
  }

  @override
  void addStudent(Student student) => _students.add(student);

  @override
  void updateStudent(Student updated) {
    final index = _students.indexWhere((s) => s.id == updated.id);
    if (index != -1) {
      _students[index] = updated;
    }
  }

  @override
  void removeStudent(Student student) {
    _students.remove(student);
  }
}
