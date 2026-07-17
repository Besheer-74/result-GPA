import '../model/result.dart';
import '../model/semster.dart';

class GradeCalculator {
  static double semesterGpa(Semester semester) {
    if (semester.subjects.isEmpty) return 0;

    double totalStudentMarks = 0;
    double totalMaxMarks = 0;

    for (var subject in semester.subjects) {
      totalStudentMarks += subject.studentMark;
      totalMaxMarks += subject.maxMark;
    }
    if (totalMaxMarks == 0) return 0;

    double gpa = (totalStudentMarks / totalMaxMarks) * 4;

    return gpa;
  }

  static double overallGpa(Result result) {
    double totalStudentMarks = 0;
    double totalMaxMarks = 0;

    final allSubjects = [
      ...result.semester1.subjects,
      ...result.semester2.subjects,
    ];

    for (var subject in allSubjects) {
      totalStudentMarks += subject.studentMark;
      totalMaxMarks += subject.maxMark;
    }
    if (totalMaxMarks == 0) return 0;

    double gpa = (totalStudentMarks / totalMaxMarks) * 4;

    return gpa;
  }

  static String letterGrade(double percentage) {
    if (percentage >= 95) return "A+";
    if (percentage >= 90) return "A";
    if (percentage >= 85) return "A-";
    if (percentage >= 80) return "B+";
    if (percentage >= 75) return "B";
    if (percentage >= 71) return "C+";
    if (percentage >= 65) return "C";
    if (percentage >= 60) return "D";
    return "F";
  }

  static String overallLetter(double gpa) {
    // Input validation
    if (gpa > 4.0 || gpa < 0.0) return "Invalid GPA";

    // Standard cascading scale
    if (gpa >= 3.85) return "A+";
    if (gpa >= 3.70) return "A";
    if (gpa >= 3.50) return "A-";
    if (gpa >= 3.30) return "B+";
    if (gpa >= 3.00) return "B";
    if (gpa >= 2.70) return "B-";
    if (gpa >= 2.30) return "C+";
    if (gpa >= 2.00) return "C";
    if (gpa >= 1.70) return "C-";
    if (gpa >= 1.30) return "D+";
    if (gpa >= 1.00) return "D";

    return "F";
  }
}
