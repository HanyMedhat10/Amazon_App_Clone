import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

import 'router.dart';

void main() {
  runApp(const AmazonApp());
}

class AmazonApp extends StatelessWidget {
  const AmazonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Amazon App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
          surface: GlobalVariables.secondaryColor,
          // onSurface: GlobalVariables.secondaryColor,/* Color of texts */
          // onPrimary: GlobalVariables.secondaryColor,/* Color of texts in appear */
        ),
      ),
      onGenerateRoute: (settings) => generateRouter(settings),
      home: const AuthScreen(),
    );
  }
}
