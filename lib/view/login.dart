import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/result_controller.dart';
import '../core/color_style.dart';
import 'result.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _codeController = TextEditingController();
  final _nationalIdController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ResultController>(context);
    final student = controller.student;

    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isLargeScreen = screenSize.width > 1200;

    // Responsive scaling factors
    final double fontSizeScale = isSmallScreen
        ? 1.0
        : (isLargeScreen ? 1.5 : 1.2);
    final double spacingScale = isSmallScreen
        ? 1.0
        : (isLargeScreen ? 1.8 : 1.4);

    return Scaffold(
      backgroundColor: ColorsStyle.corbeauColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isLargeScreen ? 800 : 650),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16 * spacingScale,
                vertical: 8 * spacingScale,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Use constraints to adjust further if needed
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Hey there!",
                          style: TextStyle(
                            fontSize: 48 * fontSizeScale,
                            fontWeight: FontWeight.w700,
                            color: ColorsStyle.slateBlueColor,
                          ),
                        ),
                        SizedBox(height: 12 * spacingScale),
                        Text(
                          "Ready to see what this semester \nhas been hiding from you?",
                          style: TextStyle(
                            fontSize: 18 * fontSizeScale,
                            fontWeight: FontWeight.w500,
                            color: ColorsStyle.slateBlueColor,
                          ),
                        ),
                        SizedBox(height: 32 * spacingScale),
                        TextField(
                          controller: _codeController,
                          style: TextStyle(
                            fontSize: 16 * fontSizeScale,
                            fontWeight: FontWeight.w500,
                            color: ColorsStyle.whiteColor,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text("Code"),
                            labelStyle: TextStyle(
                              fontSize: 16 * fontSizeScale,
                              fontWeight: FontWeight.w500,
                              color: ColorsStyle.whiteColor,
                            ),
                            floatingLabelStyle: TextStyle(
                              fontSize: 16 * fontSizeScale,
                              fontWeight: FontWeight.w500,
                              color: ColorsStyle.whiteColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: ColorsStyle.whiteColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: ColorsStyle.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12 * spacingScale),
                        TextField(
                          controller: _nationalIdController,
                          style: TextStyle(
                            fontSize: 16 * fontSizeScale,
                            fontWeight: FontWeight.w500,
                            color: ColorsStyle.whiteColor,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text("National ID"),
                            labelStyle: TextStyle(
                              fontSize: 16 * fontSizeScale,
                              fontWeight: FontWeight.w500,
                              color: ColorsStyle.whiteColor,
                            ),
                            floatingLabelStyle: TextStyle(
                              fontSize: 16 * fontSizeScale,
                              fontWeight: FontWeight.w500,
                              color: ColorsStyle.whiteColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: ColorsStyle.whiteColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: ColorsStyle.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 48 * spacingScale),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: 56 * spacingScale,
                            child: ElevatedButton(
                              onPressed: controller.isLoading
                                  ? null
                                  : () async {
                                      final result = await controller
                                          .fetchResult(
                                            _codeController.text.trim(),
                                            _nationalIdController.text.trim(),
                                          );
                                      if (!context.mounted) return;

                                      if (result == null) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Network error. Please check your connection and try again.",
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      if (!result.success) {
                                        await showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text(
                                              "Invalid credentials 💀",
                                            ),
                                            content: const Text(
                                              "Please enter valid credentials.",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("OK"),
                                              ),
                                            ],
                                          ),
                                        );
                                        return;
                                      }

                                      if (!result.published) {
                                        await showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text(
                                              "Not yet ${student?.name.split(' ').first ?? ''}😔",
                                            ),
                                            content: const Text(
                                              "Your results haven't been published yet.\nPlease check again later.",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("OK"),
                                              ),
                                            ],
                                          ),
                                        );
                                        return;
                                      }

                                      if (controller.result != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ResultScreen(),
                                          ),
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: controller.isLoading
                                  ? Text(
                                      'Cooking your results... 🍳',
                                      style: TextStyle(
                                        fontSize: 18 * fontSizeScale,
                                        fontWeight: FontWeight.w500,
                                        color: ColorsStyle.whiteColor,
                                      ),
                                    )
                                  : Text(
                                      'Let’s Check 🤙🏼',
                                      style: TextStyle(
                                        fontSize: 18 * fontSizeScale,
                                        fontWeight: FontWeight.w500,
                                        color: ColorsStyle.corbeauColor,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
