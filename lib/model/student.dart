class Student {
  final String name;
  final String code;
  final String nationalId;
  final String department;
  final String academicYear;

  Student({
    required this.name,
    required this.code,
    required this.nationalId,
    required this.department,
    required this.academicYear,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      code: json['code'],
      nationalId: json['national_id'],
      department: json['department'],
      academicYear: json['academic_year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'national_id': nationalId,
      'department': department,
      'academic_year': academicYear,
    };
  }
}