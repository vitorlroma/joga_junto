import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/home_screen.dart';
import 'package:joga_junto/features/auth/screens/login_screen.dart';
import 'package:joga_junto/features/auth/screens/signup_screen.dart';
import 'package:joga_junto/firebase_options.dart';
import 'package:joga_junto/theme/pallete.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack,);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: Pallete.darkModeAppTheme,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
      },
    );
  }
}

