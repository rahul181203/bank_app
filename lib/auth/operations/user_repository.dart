import 'dart:developer';

import 'package:bank_app/auth/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(() => SnackBar(
              content: const Text(
                "Success, Your account has been created",
                style: TextStyle(color: Colors.green),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green.withOpacity(0.1),
            ))
        .catchError((error, stackTrace) {
      SnackBar(
        content: const Text(
          "Error something went wrong",
          style: TextStyle(color: Colors.red),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
      );
      log(error.toString());
    });
  }
}
