import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/utils.dart';
import 'package:joga_junto/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) => AuthController(authRepository: ref.read(authRepositoryProvider)));

class AuthController {
  final AuthRepository _authRepository;
  AuthController({
    required AuthRepository authRepository
    }): _authRepository = authRepository;

  void signInWithGoogle(BuildContext context) async {
    final user = await _authRepository.signInWithGoogle();
    user.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  void signIn(BuildContext context, String email, String password) async {
    final user = await _authRepository.signInUser(email: email, password: password);
    user.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  void signUp({
      required BuildContext context,
      required String profilePic,
      required String name,
      required String email,
      required String password,
      required String cpf,
      required List<String> address,
      required String cityState,
      required String statistics,
      required int karma
    }) async {
    final user = await _authRepository.signUpUser(
      profilePic: profilePic, 
      name: name, 
      email: email, 
      password: password, 
      cpf: cpf, 
      address: address, 
      cityState: cityState, 
      statistics: statistics, 
      karma: karma, 
      file: Uint8List(0),
      );
    user.fold((l) => showSnackBar(context, l.message), (r) => null);
  }
}