import '../controller/grade_calculator.dart';
import 'subject.dart';

class Semester {
  final String title;
  final List<Subject> subjects;

  const Semester({required this.title, required this.subjects});

  int get subjectsCount => subjects.length;

  int get totalCredits =>
      subjects.fold(0, (sum, subject) => sum + subject.creditHours);

  int get totalMarks =>
      subjects.fold(0, (sum, subject) => sum + subject.studentMark);

  int get totalMaxMarks =>
      subjects.fold(0, (sum, subject) => sum + subject.maxMark);

  double get percentage {
    if (totalMaxMarks == 0) return 0;
    return (totalMarks / totalMaxMarks) * 100;
  }

  double get gpa => GradeCalculator.semesterGpa(this);

  String get letterGrade => GradeCalculator.overallLetter(gpa);
}
