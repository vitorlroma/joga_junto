import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/constants/constants.dart';
import 'package:joga_junto/features/auth/controller/auth_controller.dart';
import 'package:joga_junto/theme/pallete.dart';

class SignInGoogle extends ConsumerWidget{
  const SignInGoogle({super.key});
  
  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),  
      child: ElevatedButton.icon(
        onPressed: () => signInWithGoogle(context, ref),
        icon: Flexible(
          child: Image.asset(
            Constants.googleLogoPath,
            width: 35,
            ),
        ),
        label: const Text('Continue with Google',
          style: TextStyle(fontSize: 18),
          ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.greyColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
            )
        ),
      ),
    );
  }
}