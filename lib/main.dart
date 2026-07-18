import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/result_controller.dart';
import 'view/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ResultController())],
      child: MaterialApp(
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.ltr, // Forces RTL globally
            child: child!,
          );
        },

        debugShowCheckedModeBanner: false,
        title: 'Results',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: LoginScreen(),
      ),
    );
  }
}
