import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:whats_app/Data/apis.dart';
import 'package:whats_app/Domain/messageModel.dart';
import 'package:whats_app/Domain/userModel.dart';
import 'package:whats_app/Presentation/HomeChat/View/Info/Widgets/keyBoardEmoji.dart';
import 'package:whats_app/Presentation/HomeChat/ViewModel/home_cubit.dart';
import 'package:whats_app/Presentation/Resources/fonts_manager.dart';
import 'package:whats_app/Presentation/Resources/images_manager.dart';

import '../../../Resources/colors_manager.dart';
import '../../../Resources/constants.dart';
import '../../../Resources/values_manager.dart';

class SingleChat extends StatelessWidget {
  SingleChat({super.key, required this.userModel});
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return WillPopScope(
      onWillPop: () {
        if (cubit.showEmoji) {
          cubit.colseEmoji();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).highlightColor,
          ),
          actions: [
            InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(DefualtValue.d10),
                child: Icon(
                  FontAwesomeIcons.video,
                  size: DefualtValue.d20,
                  color: ColorsManager.white,
                ),
              ),
            ),
            InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(DefualtValue.d10),
                child: Icon(
                  FontAwesomeIcons.phone,
                  size: DefualtValue.d20,
                  color: ColorsManager.white,
                ),
              ),
            ),
            InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(DefualtValue.d10),
                child: Icon(
                  FontAwesomeIcons.ellipsisVertical,
                  size: DefualtValue.d20,
                  color: ColorsManager.white,
                ),
              ),
            ),
          ],
          title: Row(
            children: [
              CircleAvatar(
                radius: DefualtValue.d20,
                backgroundImage: NetworkImage(userModel.image),
              ),
              const SizedBox(
                width: DefualtValue.d10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userModel.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorsManager.white,
                          fontSize: FontSizeManager.fs_16),
                    ),
                    Text(
                      userModel.lastActive,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorsManager.grey,
                            fontSize: FontSizeManager.fs_12,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: () {
            cubit.colseEmoji();
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(DefualtValue.d12),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                opacity: 0.2,
                image: AssetImage(ImagesManager.background),
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: Apis.messageStream(userModel.token),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Something went wrong'),
                              );
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Lottie.asset(ImagesManager.loading,
                                    width: DefualtValue.d30),
                              );
                            }

                            return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, i) {
                                  if (snapshot.data!.docs[i]["sendTo"] !=
                                      userModel.token) {
                                    return messageYou(
                                      context,
                                      MessageModel.fromJson(
                                          snapshot.data!.docs[i].data()
                                              as Map<String, dynamic>),
                                      userModel.token,
                                    );
                                  } else {
                                    return messageMe(
                                      context,
                                      MessageModel.fromJson(
                                          snapshot.data!.docs[i].data()
                                              as Map<String, dynamic>),
                                      userModel.token,
                                    );
                                  }
                                });
                          }),
                    ),
                    // buttom send Message
                    Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(DefualtValue.d28),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: PaddingManager.p4),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(DefualtValue.d28),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      onTap: () {
                                        cubit.toogle(context);
                                      },
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.all(DefualtValue.d10),
                                        child: Icon(
                                          FontAwesomeIcons.faceSmile,
                                          size: DefualtValue.d20,
                                          color: ColorsManager.grey,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        onTap: () => cubit.colseEmoji(),
                                        focusNode: cubit.focusNode,
                                        controller: cubit.messageController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        decoration: InputDecoration(
                                          hintText:
                                              language(context).writeMessage,
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: ColorsManager.grey),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      onTap: () {
                                        cubit.showMediaList();
                                      },
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.all(DefualtValue.d10),
                                        child: Icon(
                                          FontAwesomeIcons.paperclip,
                                          size: DefualtValue.d20,
                                          color: ColorsManager.grey,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      onTap: () {},
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.all(DefualtValue.d10),
                                        child: Icon(
                                          FontAwesomeIcons.camera,
                                          size: DefualtValue.d20,
                                          color: ColorsManager.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: DefualtValue.d12,
                          ),
                          InkWell(
                            onTap: () {
                              if (cubit.messageController.text != "") {
                                cubit.sendMessage(
                                  userModel.token,
                                  MessageModel(
                                    dateRead: "dateRead",
                                    message: cubit.messageController.text,
                                    dateSend: DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    sendTo: userModel.token,
                                    type: "text",
                                    read: false,
                                  ),
                                );
                              }
                            },
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            child: const CircleAvatar(
                              radius: DefualtValue.d25,
                              backgroundColor: ColorsManager.primaryColorLight,
                              child: Icon(
                                FontAwesomeIcons.microphone,
                                color: ColorsManager.white,
                                size: DefualtValue.d18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return keyBoardEmoji(cubit, cubit.messageController);
                      },
                    ),
                  ],
                ),
                cubit.showMedia ? media(context) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align messageMe(BuildContext context, MessageModel message, String uid) {
    Apis.readMessage(uid, message);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: DefualtValue.d4),
        constraints: BoxConstraints(maxWidth: DefualtValue.d70.w),
        padding: const EdgeInsets.all(DefualtValue.d12),
        decoration: const BoxDecoration(
          color: ColorsManager.primaryColorLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.circular(DefualtValue.d25),
            bottomLeft: Radius.circular(DefualtValue.d25),
            bottomRight: Radius.circular(DefualtValue.d25),
          ),
        ),
        child: Column(
          children: [
            Text(
              message.message,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: FontSizeManager.fs_12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "م 5:08",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: FontSizeManager.fs_8,
                      color: ColorsManager.grey),
                ),
                const SizedBox(
                  width: DefualtValue.d4,
                ),
                Icon(
                  FontAwesomeIcons.checkDouble,
                  size: DefualtValue.d10,
                  color: message.read ? Colors.blue : ColorsManager.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Align messageYou(BuildContext context, MessageModel message, String uid) {
    Apis.readMessage(uid, message);
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: DefualtValue.d4),
        constraints: BoxConstraints(maxWidth: DefualtValue.d70.w),
        padding: const EdgeInsets.symmetric(
            horizontal: DefualtValue.d12, vertical: DefualtValue.d8),
        decoration: const BoxDecoration(
          color: ColorsManager.greyLight,
          borderRadius: BorderRadius.only(
            topRight: Radius.zero,
            topLeft: Radius.circular(DefualtValue.d25),
            bottomLeft: Radius.circular(DefualtValue.d25),
            bottomRight: Radius.circular(DefualtValue.d25),
          ),
        ),
        child: Column(
          children: [
            Text(
              message.message,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: FontSizeManager.fs_12, color: ColorsManager.black),
            ),
            Text(
              "م 5:08",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: FontSizeManager.fs_8, color: ColorsManager.grey),
            ),
          ],
        ),
      ),
    );
  }

  Positioned media(BuildContext context) {
    return Positioned(
      bottom: DefualtValue.d60,
      right: DefualtValue.d0,
      left: DefualtValue.d0,
      child: FlipInX(
        animate: true,
        duration: duration(DurationManager.d200),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: PaddingManager.p40, vertical: PaddingManager.p14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DefualtValue.d12),
            color: ColorsManager.coral,
          ),
          child: Wrap(
            children: [
              itemMedia(
                  context, FontAwesomeIcons.image, Colors.amber, "المعرض"),
              itemMedia(
                  context, FontAwesomeIcons.image, Colors.green, "المعرض"),
              itemMedia(context, FontAwesomeIcons.image, Colors.red, "المعرض"),
              itemMedia(context, FontAwesomeIcons.image, Colors.blue, "المعرض"),
              itemMedia(
                  context, FontAwesomeIcons.image, Colors.orange, "المعرض"),
              itemMedia(context, FontAwesomeIcons.image, Colors.cyan, "المعرض"),
            ],
          ),
        ),
      ),
    );
  }

  Padding itemMedia(
      BuildContext context, IconData icon, MaterialColor color, String text) {
    return Padding(
      padding: const EdgeInsets.all(DefualtValue.d14),
      child: Column(
        children: [
          Container(
            width: DefualtValue.d60,
            height: DefualtValue.d60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color,
                  color.withOpacity(0.5),
                ],
              ),
            ),
            child: Icon(
              icon,
              size: DefualtValue.d25,
            ),
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: ColorsManager.grey),
          ),
        ],
      ),
    );
  }
}
