import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_app/Data/apis.dart';
import 'package:whats_app/Domain/userModel.dart';
import 'package:whats_app/Presentation/Resources/routes_manager.dart';
import 'package:path/path.dart';

import '../../../Domain/messageModel.dart';
import '../../Resources/colors_manager.dart';
import '../../Resources/values_manager.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  init() async {
    await Apis().getDataUser();
    print(Apis.user!.name);
  }

  //Var
  bool loading = false;
  File? imageFromDevice;
  String imgDownloader = "";
  DocumentReference users = FirebaseFirestore.instance
      .collection('users')
      .doc(Apis.firebaseAuth.currentUser!.uid);
  TextEditingController nameController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController dismessageController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? imageProfile;
  FocusNode focusNode = FocusNode();
  bool showEmoji = false;
  bool showMedia = false;
  Icon icon = const Icon(
    FontAwesomeIcons.microphone,
    color: ColorsManager.white,
    size: DefualtValue.d18,
  );

  //Lists

  //Functions

  void toggleSendIcon() {
    if (messageController.text != "") {
      icon = const Icon(
        FontAwesomeIcons.solidPaperPlane,
        color: ColorsManager.white,
        size: DefualtValue.d18,
      );
    } else {
      icon = const Icon(
        FontAwesomeIcons.microphone,
        color: ColorsManager.white,
        size: DefualtValue.d18,
      );
    }
    emit(ToggleButtomSendState());
  }

  void showMediaList() {
    showMedia = !showMedia;
    emit(ShowMediaListState());
  }

  void colseEmoji() {
    if (showEmoji == true) {
      showEmoji = false;
      emit(CloseEmojiState());
    }
  }

  void toogle(BuildContext context) {
    if (focusNode.hasFocus) {
      FocusScope.of(context).unfocus();
      Future.delayed(const Duration(milliseconds: 100), () {
        showEmoji = true;
        emit(ShowEmojiState());
      });
    } else {
      if (showEmoji == false) {
        Future.delayed(const Duration(milliseconds: 100), () {
          showEmoji = true;
          emit(ShowEmojiState());
        });
      }
    }
  }

  Future<void> imageFormGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageProfile = File(image.path);
    }
  }

  Future<void> imageFormCamera(
      BuildContext context, UserModel userModel) async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      imageFromDevice = File(image.path);
      Navigator.pushNamed(context, Pages.sendPhotoo, arguments: userModel);
    }
  }

  Future<void> updateDataUser(
      {String? name, String? status, String? image}) async {
    await Apis().updateDataUser(name, status, image);
    await Apis().getDataUser();
  }

  Future<dynamic> uploadFiles() async {
    await Apis.uploadFiles(imageProfile!, "profile");
  }

  Future<String> downloadFiles(String fileName) async {
    imgDownloader = await Apis.downloadFiles(fileName);
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

  Future sendMessage(String uid, MessageModel message) async {
    await Apis.sendMessage(uid, message).then((value) {
      messageController.text = "";
    });
  }

  Future sendMessagePhoto(UserModel user) async {
    loading = true;
    emit(SendMessagePhotoLoading());
    await Apis.uploadFiles(imageFromDevice!, basename(imageFromDevice!.path));
    String imageDownloader =
        await Apis.downloadFiles(basename(imageFromDevice!.path));
    await Apis.sendMessage(
      user.token,
      MessageModel(
        namePhoto: basename(imageFromDevice!.path),
        dis: dismessageController.text,
        dateRead: "",
        message: imageDownloader,
        dateSend: DateTime.now().millisecondsSinceEpoch.toString(),
        sendTo: user.token,
        type: "image",
        read: false,
      ),
    );
    loading = false;
  }
}
