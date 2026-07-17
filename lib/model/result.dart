import 'semster.dart';
import 'student.dart';
import 'subject.dart';

class Result {
  final bool success;
  final bool published;
  final String message;

  final Student? student;

  final Semester semester1;
  final Semester semester2;

  Result({
    required this.success,
    required this.published,
    required this.message,
    required this.student,
    required this.semester1,
    required this.semester2,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      success: json['success'],
      published: json['published'],
      message: json['message'],

      student: json['student'] == null
          ? null
          : Student.fromJson(json['student']),

      semester1: Semester(
        title: "Semester 1 (Fall)",
        subjects: (json['semester_1'] as List)
            .map((e) => Subject.fromJson(e))
            .toList(),
      ),

      semester2: Semester(
        title: "Semester 2 (Spring)",
        subjects: (json['semester_2']as List)
            .map((e) => Subject.fromJson(e))
            .toList(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'published': published,
      'message': message,
      'student': student?.toJson(),
      'semester_1': semester1.subjects.map((e) => e.toJson()).toList(),
      'semester_2': semester2.subjects.map((e) => e.toJson()).toList(),
    };
  }
}
