import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/common_style.dart';
import 'package:joga_junto/core/common/loader.dart';
import 'package:joga_junto/core/constants/constants.dart';
import 'package:joga_junto/features/auth/controller/auth_controller.dart';
import 'package:joga_junto/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void signInWithEmailAndPassword(BuildContext context){
    ref.read(authControllerProvider.notifier).signIn(context, _email.text, _password.text);
  }

  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  void navigateToSignUpScreen(BuildContext context) {
    Routemaster.of(context).push('/sign-up');
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(backgroundColor: Pallete.orangeColor,),
      body: isLoading
        ? const Loader() 
        : SingleChildScrollView(
        child: Padding(
        padding: CommonStyle.bodyPading,
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
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: CommonStyle.formFieldPadding,
                      child: TextFormField(
                        controller: _email,
                        decoration: CommonStyle.textFieldStyle(
                          labelText:'E-mail', 
                          hintText: 'Insira o e-mail'
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
                      padding: CommonStyle.buttonPadding,
                      child: TextFormField(
                        controller: _password,
                        obscureText: true,
                        decoration: CommonStyle.textFieldStyle(
                          labelText:'Senha', 
                          hintText: 'Insira sua senha'
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
                      padding: CommonStyle.buttonPadding,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            signInWithEmailAndPassword(context);
                          }
                        },
                        style: CommonStyle.buttonStyle(),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ),
              Padding(
                padding: CommonStyle.buttonPadding,  
                child: ElevatedButton.icon(
                  onPressed: () => signInWithGoogle(context, ref),
                  style: CommonStyle.buttonStyle(),
                  icon: CircleAvatar(
                    child: Image.asset(
                      Constants.googleLogoPath,
                      width: 35,
                    ),
                  ),
                  label: const Text('Continue with Google',
                    style: TextStyle(fontSize: 18),
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: () {
                    navigateToSignUpScreen(context);
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
    );
  }
}