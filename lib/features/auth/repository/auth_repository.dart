import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:joga_junto/core/constants/constants.dart';
import 'package:joga_junto/core/constants/firebase_constants.dart';
import 'package:joga_junto/core/failure.dart';
import 'package:joga_junto/core/provider/firebase_provider.dart';
import 'package:joga_junto/core/type_defs.dart';
import 'package:joga_junto/models/user_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider), 
    auth: ref.read(authProvider), 
    googleSignIn: ref.read(googleSignInProvider)
  )
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore, 
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn
    }): _auth = auth, _firestore = firestore, _googleSignIn = googleSignIn;

    CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);

    Stream<User?> get authStateChange => _auth.authStateChanges();

    FutureEither<UserModel> signInWithGoogle() async{
      try{
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        UserCredential userCredential = await _auth.signInWithCredential(credential);
        
        UserModel userModel;

        if(userCredential.additionalUserInfo!.isNewUser){
          userModel = UserModel(
            uid: userCredential.user!.uid,
            profilePic: userCredential.user!.photoURL??Constants.avatarDefault,
            name: userCredential.user!.displayName??'No name',
            email: userCredential.user!.email??'',
            password: credential.accessToken??'',
            cpf: '',
            address: [],
            cityState: '',
            statistics: '',
            karma: 0,
          );
          await _users.doc(userCredential.user!.uid).set(userModel.toMap());
        } else {
          userModel = await getUserData(userCredential.user!.uid).first;
        }
        return right(userModel);
      } on FirebaseException catch(e){
        throw e.message!;
      } catch (e){
        return left(Failure(e.toString()));
      }
    }

    FutureEither<UserModel> signInUser({
      required String email,
      required String password,
    }) async {
      try{
        late UserModel userModel;

        if (email.isNotEmpty || password.isNotEmpty) {
          final userCredential = await _auth.signInWithEmailAndPassword(
            email: email, 
            password: password
          );
          userModel = await getUserData(userCredential.user!.uid).first;
        }
        return right(userModel);
      } on FirebaseException catch(e){
        throw e.message!;
      } catch (e){
        return left(Failure(e.toString()));
      }
    }

    FutureEither<UserModel> signUpUser({
      required String profilePic,
      required String name,
      required String email,
      required String password,
      required String cpf,
      required List<String> address,
      required Uint8List file,
    }) async {
      try {
        late UserModel userModel;
        
        if (email.isNotEmpty ||
            password.isNotEmpty ||
            name.isNotEmpty ||
            cpf.isEmpty ||
            address.isEmpty
            ) {
          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          userModel = UserModel(
            uid: userCredential.user!.uid, 
            profilePic: profilePic,
            name: name,
            email: userCredential.user!.email??'',
            password: password,
            cpf: cpf,
            address: [],
            cityState: '',
            statistics: '',
            karma: 0,
          );
          await _users.doc(userCredential.user!.uid).set(userModel.toMap());
        }
        return right(userModel);
      } on FirebaseException catch(e){
        throw e.message!;
      } catch (e){
        return left(Failure(e.toString()));
      }
    }

    Stream<UserModel> getUserData(String uid){
      return _users.doc(uid).snapshots().map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
    }

    Future<void> signOut() async {
    await _auth.signOut();
  }
}
