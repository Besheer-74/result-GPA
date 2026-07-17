import 'package:flutter/material.dart';
import 'package:results/model/semster.dart';
import 'package:results/model/subject.dart';
import 'package:results/view/widgets/subject_details_sheet.dart';
import 'package:results/view/widgets/subject_grid_card.dart';

class SemesterCard extends StatefulWidget {
  final Semester semester;
  final int columns;
  final double aspectRatio;
  final bool initiallyExpanded;
  final ValueChanged<Subject> onSubjectTap;
  final Subject? selectedSubject;

  const SemesterCard({
    super.key,
    required this.semester,
    required this.columns,
    required this.aspectRatio,
    this.initiallyExpanded = false,
    required this.onSubjectTap,
    required this.selectedSubject,
  });

  @override
  State<SemesterCard> createState() => _SemesterCardState();
}

class _SemesterCardState extends State<SemesterCard> {
  late bool expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final semester = widget.semester;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff2B2825),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      semester.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 250),
                    turns: expanded ? 0 : -.25,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            secondChild: const SizedBox.shrink(),
            firstChild: Column(
              children: [
                const Divider(height: 1, color: Colors.white10),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 22,
                  ),
                  child: Row(
                    children: [
                      _miniStat(semester.gpa.toStringAsFixed(2), "GPA"),

                      _miniStat(semester.letterGrade, "Grade"),

                      _miniStat(semester.subjectsCount.toString(), "Subjects"),

                      _miniStat(semester.totalCredits.toString(), "Credits"),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: semester.subjects.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.columns,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: widget.aspectRatio,
                    ),
                    itemBuilder: (_, index) {
                      final subject = semester.subjects[index];

                      return SubjectGridCard(
                        subject: subject,
                        selected: widget.selectedSubject?.code == subject.code,
                        onTap: () {
                          widget.onSubjectTap(subject);
                          _showSubjectDetails(context, subject);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniStat(String value, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _showSubjectDetails(BuildContext context, Subject subject) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => SubjectDetailsSheet(subject: subject),
    );
  }
}