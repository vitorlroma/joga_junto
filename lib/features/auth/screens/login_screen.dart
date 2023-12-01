import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/signin_google_button.dart';
import 'package:joga_junto/features/auth/controller/auth_controller.dart';
import 'package:joga_junto/features/auth/screens/signup_screen.dart';
import 'package:joga_junto/theme/pallete.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  // ignore: prefer_final_fields
  bool _saving = false;

  void signInWithEmailAndPassword(BuildContext context){
    ref.read(authControllerProvider).signIn(context, _email.text, _password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Pallete.orangeColor,),
      body: LoadingOverlay(
        isLoading: _saving,
        child: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  const Text(
                    'JogaJunto',
                    style: TextStyle(
                      color: Pallete.orangeColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                    child: TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                        labelText: 'E-mail',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o e-mail corretamente!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                    child: TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                        labelText: 'Senha',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informa sua senha!';
                        } else if (value.length < 6) {
                          return 'Sua senha deve ter no mínimo 6 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signInWithEmailAndPassword(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.orangeColor,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SignInGoogle(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, SignUpScreen.id);
                      },
                      child: const Text('Não tem conta? Cadastre-se aqui!',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}