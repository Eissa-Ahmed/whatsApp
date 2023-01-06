import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:whats_app/Data/toast.dart';
import 'package:whats_app/Presentation/Resources/constants.dart';

import '../Domain/userModel.dart';

class Apis {
  static UserModel? user;
  static String? id;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final storageRef = FirebaseStorage.instance.ref();
  Future<void> otp(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        id = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<UserCredential> signPhone(
      String verificationId, String smsCode, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    return await auth.signInWithCredential(credential).catchError((error) {
      toast(language(context).wrong);
    });
  }

  Future<void> saveDataUser() async {
    UserModel userModel = UserModel(
      image: user == null ? "" : user!.image,
      name: user == null ? "No Name" : user!.name,
      status: user == null ? "No status" : user!.status,
      token: firebaseAuth.currentUser!.uid,
    );
    try {
      await firestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .set(userModel.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future getDataUser() async {
    await firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then(
      (value) {
        if (value.data() != null) {
          user = UserModel.fromJson(value.data()!);
        }
      },
    );
  }

  Future<void> updateDataUser(name, status, image) async {
    await firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .update({
      "name": name ?? user!.name,
      "status": status ?? user!.status,
      "image": image ?? user!.image,
    });
  }

  Future uploadFiles(File file, String name) async {
    await storageRef
        .child(firebaseAuth.currentUser!.uid)
        .child(name)
        .putFile(file);
  }

  Future<String> downloadFiles(String name) async {
    return await storageRef
        .child(firebaseAuth.currentUser!.uid)
        .child(name)
        .getDownloadURL();
  }
}
