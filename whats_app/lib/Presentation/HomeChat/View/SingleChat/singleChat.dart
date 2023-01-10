import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:whats_app/Data/apis.dart';
import 'package:whats_app/Domain/messageModel.dart';
import 'package:whats_app/Domain/userModel.dart';
import 'package:whats_app/Presentation/HomeChat/View/Info/Widgets/keyBoardEmoji.dart';
import 'package:whats_app/Presentation/HomeChat/View/SingleChat/Widgets/messageSend.dart';
import 'package:whats_app/Presentation/HomeChat/ViewModel/home_cubit.dart';
import 'package:whats_app/Presentation/Resources/fonts_manager.dart';
import 'package:whats_app/Presentation/Resources/images_manager.dart';

import '../../../Resources/colors_manager.dart';
import '../../../Resources/constants.dart';
import '../../../Resources/values_manager.dart';
import 'Widgets/media.dart';

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
                                    return MessageYou(
                                        message: MessageModel.fromJson(
                                            snapshot.data!.docs[i].data()
                                                as Map<String, dynamic>),
                                        uid: userModel.token);
                                  } else {
                                    return MessageMe(
                                        message: MessageModel.fromJson(
                                            snapshot.data!.docs[i].data()
                                                as Map<String, dynamic>),
                                        uid: userModel.token);
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
                                        onChanged: (val) {
                                          cubit.toggleSendIcon();
                                        },
                                        keyboardType: TextInputType.multiline,
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
                                    BlocBuilder<HomeCubit, HomeState>(
                                      builder: (context, state) {
                                        return InkWell(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          onTap: () {
                                            cubit.showMediaList();
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(
                                                DefualtValue.d10),
                                            child: Icon(
                                              FontAwesomeIcons.paperclip,
                                              size: DefualtValue.d20,
                                              color: ColorsManager.grey,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    InkWell(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      onTap: () {
                                        cubit.imageFormCamera(
                                            context, userModel);
                                      },
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
                                    namePhoto: "",
                                    dis: "",
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
                            child: CircleAvatar(
                              radius: DefualtValue.d25,
                              backgroundColor: ColorsManager.primaryColorLight,
                              child: BlocBuilder<HomeCubit, HomeState>(
                                builder: (context, state) {
                                  return cubit.icon;
                                },
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
}
