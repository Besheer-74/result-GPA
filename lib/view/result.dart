import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controller/result_controller.dart';
import '../core/color_style.dart';
import '../model/subject.dart';
import 'widgets/overall_result_card.dart';
import 'widgets/semester_card.dart';
import 'widgets/student_info_card.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // FIX: moved out of build() so selection actually persists across rebuilds.
  Subject? _selectedSubject;

  /// Simple responsive breakpoints.
  /// < 430   : small phone
  /// 430-760 : phone
  /// 760-1100: tablet
  /// > 1100  : desktop/web
  int _columnsForWidth(double width) {
    const minCardWidth = 180.0;

    return (width / minCardWidth).floor().clamp(1, 4);
  }

  double _aspectRatioForColumns(int columns) {
    switch (columns) {
      case 1:
        return 2.0; // wide card
      case 2:
        return 0.75;
      case 3:
        return 0.85;
      default:
        return 0.95;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ResultController>(context);

    final student = controller.student;
    final result = controller.result;

    return Scaffold(
      backgroundColor: ColorsStyle.blackBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final columns = _columnsForWidth(constraints.maxWidth);
            final horizontalPadding = constraints.maxWidth < 600 ? 16.0 : 24.0;
            final verticalSpacing = constraints.maxWidth < 430 ? 16.0 : 20.0;

            return Align(
              // FIX: was `Center`, which also centers vertically and leaves
              // a big empty gap at the top when content is shorter than the
              // screen. `Align(topCenter)` keeps horizontal centering only.
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  // FIX: caps content width on wide desktop/web so cards
                  // don't stretch edge-to-edge and become hard to scan.
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StudentInfoCard(student: student!),
                        SizedBox(height: verticalSpacing),
                        OverallResultCard(result: result!),
                        SizedBox(height: verticalSpacing),
                        SemesterCard(
                          semester: result.semester2,
                          columns: columns,
                          aspectRatio: _aspectRatioForColumns(columns),
                          initiallyExpanded: true,
                          selectedSubject: _selectedSubject,
                          onSubjectTap: (subject) {
                            setState(() {
                              _selectedSubject = subject;
                            });
                          },
                        ),
                        SizedBox(height: verticalSpacing),
                        SemesterCard(
                          semester: result.semester1,
                          columns: columns,
                          aspectRatio: _aspectRatioForColumns(columns),
                          initiallyExpanded: false,
                          selectedSubject: _selectedSubject,
                          onSubjectTap: (subject) {
                            setState(() {
                              _selectedSubject = subject;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        Center(child: _buildPoweredByOro()),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPoweredByOro() {
    return SizedBox(
      height: 25,
      width: 115,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset('assets/images/oro_logo.svg', width: 41, height: 16),
        ],
      ),
    );
  }
}
