import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jhd/core/constant/shared_preference_key.dart';
import 'package:jhd/core/services/local_storage/shared_preference.dart';
import 'package:jhd/core/services/snack_bar_services.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/sign_in/data/models/sign_in_data_model.dart';
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

  Future<Either<String, List<AddUserRequestDataModel>>> getAllUsers() async {
    try {
      var response = await _colRef().get().then(
            (value) => value.docs
                .map(
                  (e) => e.data(),
                )
                .toList(),
          );
      return Right(response);
    } catch (error) {
      return Left(
        error.toString(),
      );
    }
  }

  // Future<Either<String, bool>> getRole(
  //   String userId,
  // ) async {
  //   try {
  //     final snapshot = await _colRef().where('uid', isEqualTo: userId).get();

  //     String role = snapshot.docs.first['role'] as String;

  //     SharedPreferenceServices.setString(
  //       SharedPreferenceKey.role,
  //       role,
  //     );
  //     return const Right(true);
  //   } catch (error) {
  //     return Left(
  //       error.toString(),
  //     );
  //   }
  // }

  CollectionReference<AddUserRequestDataModel> _colRef() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) =>
            AddUserRequestDataModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toMap(),
      );

  Future<Either<String, bool>> deleteUserById(
    String uid,
  ) async {
    try {
      final snapshot = await _colRef().where("uid", isEqualTo: uid).get();

      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
      navigationKey.currentState!.pop();
      BotToastServices.showSuccessMessage('User Deleted Succefully');
      return const Right(
        true,
      );
    } catch (error) {
      BotToastServices.showErrorMessage('Error While Delte The User');
      return Left(
        error.toString(),
      );
    }
  }

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
      // SharedPreferenceServices.setString(
      //   SharedPreferenceKey.role,
      //   user.role,
      // );
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

  Future<String?> getRoleByUserId(
    String uid,
  ) async {
    try {
      var response = await getAllUsers();
      List<AddUserRequestDataModel> users = [];
      response.fold(
        (l) => print(l),
        (r) => users = r,
      );
      for (var user in users) {
        if (user.uid == uid) {
          return user.role;
        }
      }
    } catch (error) {
      return null;
    }
    return null;
  }
}
