import 'package:flutter/material.dart';
import 'package:joga_junto/core/common/signin_google_button.dart';
import 'package:joga_junto/theme/pallete.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:joga_junto/core/common/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.id);
        return false;
      },
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: _saving,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [const Text('Cadastro',
                        style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            width: 2.5,
                            color: Pallete.orangeColor,
                          ),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'E-mail'
                          ),
                          onChanged: (value) {
                            _email = value;
                          },
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            width: 2.5,
                            color: Pallete.orangeColor,
                          ),
                        ),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Senha'
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            _password = value;
                          },
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SignInGoogle(),
                    ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}