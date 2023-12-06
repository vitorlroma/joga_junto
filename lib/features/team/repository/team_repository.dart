import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:joga_junto/core/constants/firebase_constants.dart';
import 'package:joga_junto/core/failure.dart';
import 'package:joga_junto/core/type_defs.dart';

class TeamRepository {
  final FirebaseFirestore _firestore;
  TeamRepository({
    required FirebaseFirestore firestore
  }): _firestore = firestore;

  CollectionReference get _teams => _firestore.collection(FirebaseConstants.teamsCollection);
}