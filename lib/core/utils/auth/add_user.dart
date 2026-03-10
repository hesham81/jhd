import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jhd/core/services/snack_bar_services.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:jhd/main.dart';

class UsersCollections {
  static final _firestore = FirebaseFirestore.instance.collection("users");
  static final _firebaseAuth = FirebaseAuth.instance;

  Future<Either<String, User>> assignUser(
    SignInRequest data,
  ) async {
    try {
      final UserCredential user =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: data.username,
        password: data.password,
      );
      return (user.user == null)
          ? const Left("Error While Adding User")
          : Right(user.user!);
    } on FirebaseException catch (error) {
      return Left(
        error.toString(),
      );
    }
  }

  CollectionReference<AddUserRequestDataModel> _colRef() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) =>
            AddUserRequestDataModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toMap(value),
      );

  Future<Either<String, bool>> addUser(
    AddUserRequestDataModel user,
  ) async {
    try {
      EasyLoading.show();
      var response = await assignUser(
        SignInRequest(
          user.email,
          user.password,
        ),
      );
      final String data = response.fold(
        (l) => l.toString(),
        (r) => r.uid,
      );
      user.uid = data;
      await _colRef().add(user);
      BotToastServices.showSuccessMessage(
        'User Added Succefully',
      );
      navigationKey.currentState!.pop();
      return const Right(true);
    } catch (error) {
      BotToastServices.showErrorMessage(
        'Error While Adding ${user.name}',
      );
      return Left(
        error.toString(),
      );
    }
  }
}
