import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/utils.dart';
import 'package:joga_junto/features/auth/repository/auth_repository.dart';
import 'package:joga_junto/models/user_model.dart';


final userProvider = StateProvider<UserModel?>((ref) => null);
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  )
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool>{
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
    }): _authRepository = authRepository, 
      _ref = ref,
      super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange; 

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  void signIn(BuildContext context, String email, String password) async {
    state = true;
    final user = await _authRepository.signInUser(email: email, password: password);
    state = false;
    user.fold((l) => showSnackBar(context, l.message), (userModel) => _ref.read(userProvider.notifier).update((state) => userModel));
  }

  void signUp(
      BuildContext context,
      String profilePic,
      String name,
      String email,
      String password,
      String cpf,
      List<String> address,
    ) async {
      state = true;
    final user = await _authRepository.signUpUser(
      profilePic: profilePic, 
      name: name, 
      email: email, 
      password: password, 
      cpf: cpf, 
      address: address,
      file: Uint8List(0),
      );
      state = false;
    user.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  Stream<UserModel> getUserData(String uid){
    return _authRepository.getUserData(uid);
  }
}