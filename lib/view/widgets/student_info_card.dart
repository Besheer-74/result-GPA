import 'package:flutter/material.dart';
import 'package:results/core/color_style.dart';
import 'package:results/model/student.dart';

class StudentInfoCard extends StatelessWidget {
  final Student student;
  const StudentInfoCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    // FIX: guard against empty/blank names to avoid a RangeError on `[0]`.
    final trimmedName = student.name.trim();
    final initials = trimmedName.isNotEmpty
        ? trimmedName.split(' ').first[0].toUpperCase()
        : '?';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: cardDecoration(),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: ColorsStyle.slateBlueColor.withOpacity(0.15),
            child: Text(
              initials,
              style: const TextStyle(
                color: ColorsStyle.slateBlueColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorsStyle.lightGrayColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'ID ${student.code} · ${student.department}',
                  style: TextStyle(
                    fontSize: 13,
                    color: ColorsStyle.lightGrayColor.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Academic year ${student.academicYear}',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorsStyle.lightGrayColor.withOpacity(0.45),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration cardDecoration({Color? borderColor}) {
    return BoxDecoration(
      color: ColorsStyle.corbeauColor.withOpacity(0.15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: borderColor ?? ColorsStyle.lightGrayColor.withOpacity(0.6),
        width: borderColor != null ? 1.5 : 1,
      ),
    );
  }
}
