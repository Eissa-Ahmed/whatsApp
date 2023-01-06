import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_app/Data/apis.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  init() async {
    await Apis().getDataUser();
    print(Apis.user!.name);
  }

  //Var
  String imgDownloader = "";
  DocumentReference users = FirebaseFirestore.instance
      .collection('users')
      .doc(Apis.firebaseAuth.currentUser!.uid);
  TextEditingController nameController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? imageProfile;
  FocusNode focusNode = FocusNode();
  bool showEmoji = true;

  //Lists

  //Functions
  void colseEmoji() {
    if (!showEmoji) {
      showEmoji = true;
      emit(CloseEmojiState());
    }
  }

  void toogle() {
    if (focusNode.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
      Future.delayed(
          const Duration(milliseconds: 100), () => showEmoji = false);
    } else {
      Future.delayed(
          const Duration(milliseconds: 100), () => showEmoji = false);
    }
    emit(ShowEmojiState());
  }

  Future<void> imageFormGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageProfile = File(image.path);
    }
  }

  Future<void> imageFormCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {}
  }

  Future<void> updateDataUser(
      {String? name, String? status, String? image}) async {
    await Apis().updateDataUser(name, status, image);
    await Apis().getDataUser();
  }

  Future<dynamic> uploadFiles() async {
    await Apis().uploadFiles(imageProfile!, "profile");
  }

  Future<String> downloadFiles(String fileName) async {
    imgDownloader = await Apis().downloadFiles(fileName);
    return imgDownloader;
  }

  Future<void> login(BuildContext context) async {
    if (imageProfile != null) {
      await uploadFiles();
      await downloadFiles("profile");
      if (nameController.text != "" && imgDownloader != "") {
        await updateDataUser(name: nameController.text, image: imgDownloader);
      } else if (nameController.text != "" && imgDownloader == "") {
        await updateDataUser(name: nameController.text);
      } else if (nameController.text == "" && imgDownloader != "") {
        await updateDataUser(image: imgDownloader);
      }
    } else {
      if (nameController.text != "") {
        await updateDataUser(name: nameController.text);
      }
    }
    emit(LoginSuccessState());
  }
}
