import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:whats_app/Data/toast.dart';
import 'package:whats_app/Domain/messageModel.dart';
import 'package:whats_app/Presentation/Resources/constants.dart';

import '../Domain/userModel.dart';

class Apis {
  static final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
      .collection('users')
      .where("token", isNotEqualTo: firebaseAuth.currentUser!.uid)
      .snapshots();
  static Stream<QuerySnapshot> messageStream(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("message")
        .doc(uid)
        .collection("chat")
        .orderBy("dateSend")
        .snapshots();
  }

  static Stream<QuerySnapshot> lastMessageStram(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("message")
        .doc(uid)
        .collection("chat")
        .orderBy("dateSend", descending: true)
        // .limit(1)
        .snapshots();
  }

  static Stream<QuerySnapshot> countMesageUnRead(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("message")
        .doc(uid)
        .collection("chat")
        .where("read", isEqualTo: false)
        // .limit(1)
        .snapshots();
  }

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

  Future<void> saveDataUser(String phone) async {
    UserModel userModel = UserModel(
      phone: user == null ? phone : user!.phone,
      image: user == null ? "" : user!.image,
      name: user == null ? phone : user!.name,
      status: user == null ? "No status" : user!.status,
      token: firebaseAuth.currentUser!.uid,
      active: true,
      lastActive: "",
      lastMessage: "",
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

  static Future sendMessage(String uid, MessageModel message) async {
    await firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("message")
        .doc(uid)
        .collection("chat")
        .doc(message.dateSend)
        .set(message.toJson());
    await firestore
        .collection("users")
        .doc(uid)
        .collection("message")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("chat")
        .doc(message.dateSend)
        .set(message.toJson());
  }

  static Future readMessage(String uid, MessageModel message) async {
    if (firebaseAuth.currentUser!.uid == message.sendTo) {
      await firestore
          .collection("users")
          .doc(uid)
          .collection("message")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("chat")
          .doc(message.dateSend)
          .update({
        "read": true,
      });
      await firestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("message")
          .doc(uid)
          .collection("chat")
          .doc(message.dateSend)
          .update({
        "read": true,
      });
    }
  }
}
