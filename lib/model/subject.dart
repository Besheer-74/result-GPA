import 'package:results/controller/grade_calculator.dart';

class Subject {
  final String code;
  final String name;
  final int creditHours;
  final int maxMark;
  final int studentMark;
  final String grade;
  final bool passed;
  final String status;
  final String examRound;

  Subject({
    required this.code,
    required this.name,
    required this.creditHours,
    required this.maxMark,
    required this.studentMark,
    required this.grade,
    required this.passed,
    required this.status,
    required this.examRound,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      code: json['code'],
      name: json['name'],
      creditHours: json['credit_hours'],
      maxMark: json['max_mark'],
      studentMark: json['student_mark'],
      grade: json['grade'],
      passed: json['passed'],
      status: json['status'],
      examRound: json['exam_round'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'credit_hours': creditHours,
      'max_mark': maxMark,
      'student_mark': studentMark,
      'grade': grade,
      'passed': passed,
      'status': status,
      'exam_round': examRound,
    };
  }

  double get percentage => studentMark / maxMark * 100;
  String get letter => GradeCalculator.letterGrade(percentage);
}
