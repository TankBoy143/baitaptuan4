
import 'package:library_manager/model/student.dart';

abstract class AbstractStudentRepository {
  List<Student> getStudents();
  Student? getStudentById(String id);
  void addStudent(Student student);
  void updateStudent(Student updated);
  void removeStudent(Student student);
}