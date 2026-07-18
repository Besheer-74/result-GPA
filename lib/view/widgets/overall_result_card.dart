import 'package:flutter/material.dart';
import 'package:results/controller/grade_calculator.dart';
import 'package:results/core/color_style.dart';
import 'package:results/model/result.dart';

class OverallResultCard extends StatelessWidget {
  final Result result;
  const OverallResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 360;
        final spacing = 12.0;
        final itemWidth = isCompact
            ? (constraints.maxWidth - spacing) / 2
            : (constraints.maxWidth - (spacing * 2)) / 3;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 16 : 20,
            vertical: isCompact ? 14 : 16,
          ),
          decoration: BoxDecoration(
            color: ColorsStyle.darkBlueColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Overall result',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.65),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                spacing: spacing,
                children: [
                  Expanded(
                    child: _statBlock(
                      '${GradeCalculator.overallGpa(result).toStringAsFixed(2)}',
                      'GPA',
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: _statBlock(
                      GradeCalculator.overallLetter(
                        GradeCalculator.overallGpa(result),
                      ),
                      'Grade',
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: _statBlock(
                      '${result.semester1.totalCredits + result.semester2.totalCredits}',
                      'Credits',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statBlock(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorsStyle.neoMintColor,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.55),
            ),
          ),
        ),
      ],
    );
  }

  Color gradeColor(String grade) {
    final g = grade.toUpperCase();
    if (g.startsWith('A')) return ColorsStyle.mediumSeaGreenColor;
    if (g.startsWith('B')) return ColorsStyle.dodgerBlueColor;
    if (g.startsWith('C')) return ColorsStyle.orangeColor;
    if (g.startsWith('D')) return ColorsStyle.tomatoColor;
    return ColorsStyle.cadillacCoupeColor; // F / fail
  }

  Color statusColor(String status) {
    final s = status.toLowerCase();
    if (s.contains('pass')) return ColorsStyle.mediumSeaGreenColor;
    if (s.contains('fail')) return ColorsStyle.cadillacCoupeColor;
    return ColorsStyle.orangeColor;
  }
}
