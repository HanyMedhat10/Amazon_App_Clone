import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const AmazonApp()));
  // runApp(const AmazonApp()));
}

class AmazonApp extends StatefulWidget {
  const AmazonApp({super.key});

  @override
  State<AmazonApp> createState() => _AmazonAppState();
}

class _AmazonAppState extends State<AmazonApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

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
      home:Provider.of<UserProvider>(context).user.token.isNotEmpty 
      ? const HomeScreen() 
      : const AuthScreen(),
    );
  }
}
