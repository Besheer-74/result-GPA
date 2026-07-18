import 'package:flutter/material.dart';
import 'package:results/core/color_style.dart';
import 'package:results/model/subject.dart';

class SubjectGridCard extends StatelessWidget {
  final Subject subject;
  final bool selected;
  final VoidCallback onTap;

  const SubjectGridCard({
    super.key,
    required this.subject,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: const Color(0xff1E1B18),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? ColorsStyle.slateBlueColor : Colors.white10,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Subject Code
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

                const SizedBox(height: 12),

                /// Subject Name
                Text(
                  subject.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),

                const Spacer(),

                _infoRow(
                  "Grade",
                  subject.letter,
                  valueColor: _gradeColor(subject.letter),
                ),

                const SizedBox(height: 10),

                _infoRow("Score", "${subject.studentMark}"),

                const SizedBox(height: 10),

                _infoRow("Credits", subject.creditHours.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
    String title,
    String value, {
    Color valueColor = Colors.white,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white54, fontSize: 16),
        ),

        const Spacer(),

        Center(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: valueColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
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
