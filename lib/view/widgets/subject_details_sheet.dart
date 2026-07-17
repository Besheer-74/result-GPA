import 'package:flutter/material.dart';
import 'package:results/core/color_style.dart';
import 'package:results/model/subject.dart';

class SubjectDetailsSheet extends StatelessWidget {
  final Subject subject;

  const SubjectDetailsSheet({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final scoreRatio = subject.maxMark == 0
        ? 0.0
        : (subject.studentMark / subject.maxMark).clamp(0.0, 1.0);

    return SafeArea(
      child: Padding(
        // Lift the sheet above the keyboard/gesture bar and cap its width on
        // wide screens so it doesn't stretch edge-to-edge on desktop/web.
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
              decoration: const BoxDecoration(
                color: Color(0xff1E1B18),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          subject.code,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _gradeColor(subject.letter).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          subject.letter,
                          style: TextStyle(
                            color: _gradeColor(subject.letter),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Text(
                    subject.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Score progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: scoreRatio,
                      minHeight: 8,
                      backgroundColor: Colors.white10,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _gradeColor(subject.letter),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '${subject.studentMark} / ${subject.maxMark} marks',
                    style: const TextStyle(color: Colors.white54, fontSize: 14),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: _detailStat(
                          'Percentage',
                          '${subject.percentage.toStringAsFixed(2)}%',
                          _gradeColor(subject.letter),
                        ),
                      ),
                      Expanded(
                        child: _detailStat(
                          'Status',
                          subject.passed ? "Pass" : "Fail",
                          Colors.white,
                        ),
                      ),
                      Expanded(
                        child: _detailStat(
                          'Credits',
                          "${subject.creditHours.toString()} hours",
                          Colors.white,
                        ),
                      ),
                      Expanded(
                        child: _detailStat(
                          'Exam round',
                          subject.examRound == "الاول" ? "First" : "Second",
                          Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailStat(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Color _gradeColor(String grade) {
    switch (grade) {
      case "A+":
      case "A":
      case "A-":
        return ColorsStyle.mediumSeaGreenColor;
      case "B+":
      case "B":
        return ColorsStyle.dodgerBlueColor;
      case "C+":
      case "C":
        return ColorsStyle.orangeColor;
      case "D":
        return Colors.amber;
      default:
        return ColorsStyle.tomatoColor;
    }
  }
}
