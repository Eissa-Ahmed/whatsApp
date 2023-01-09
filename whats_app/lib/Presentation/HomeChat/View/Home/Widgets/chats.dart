import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:whats_app/Data/apis.dart';
import 'package:whats_app/Data/toDate.dart';
import 'package:whats_app/Domain/userModel.dart';
import 'package:whats_app/Presentation/Resources/colors_manager.dart';
import 'package:whats_app/Presentation/Resources/constants.dart';
import 'package:whats_app/Presentation/Resources/fonts_manager.dart';
import 'package:whats_app/Presentation/Resources/images_manager.dart';
import 'package:whats_app/Presentation/Resources/routes_manager.dart';
import 'package:whats_app/Presentation/Resources/values_manager.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.message_sharp),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Apis.usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child:
                  Lottie.asset(ImagesManager.loading, width: DefualtValue.d18),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                return itemUserChat(
                    context,
                    UserModel.fromJson(
                        snapshot.data!.docs[i].data() as Map<String, dynamic>));
              });
        },
      ),
    );
  }

  InkWell itemUserChat(BuildContext context, UserModel itemChatModel) {
    return InkWell(
      onTap: () async {
        await Navigator.of(context).pushNamed(
          Pages.singleChat,
          arguments: itemChatModel,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(PaddingManager.p8),
        margin: const EdgeInsets.symmetric(
            horizontal: MarginManager.m10, vertical: MarginManager.m4),
        child: Row(
          children: [
            CircleAvatar(
              radius: DefualtValue.d28,
              backgroundImage: NetworkImage(itemChatModel.image),
            ),
            const SizedBox(
              width: DefualtValue.d10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemChatModel.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: Apis.lastMessageStram(itemChatModel.token),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data!.docs.isNotEmpty) {
                          return Row(
                            children: [
                              Apis.firebaseAuth.currentUser!.uid !=
                                      snapshot.data!.docs[0]["sendTo"]
                                  ? Text(
                                      language(context).you,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: ColorsManager.grey),
                                    )
                                  : Text(
                                      language(context).forYou,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: ColorsManager.grey),
                                    ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: DefualtValue.d2),
                                constraints: BoxConstraints(
                                    maxWidth: DefualtValue.d50.w),
                                child: Text(
                                  snapshot.data!.docs[0]["message"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: ColorsManager.grey),
                                ),
                              ),
                              Apis.firebaseAuth.currentUser!.uid !=
                                      snapshot.data!.docs[0]["sendTo"]
                                  ? Icon(
                                      FontAwesomeIcons.checkDouble,
                                      size: DefualtValue.d10,
                                      color: snapshot.data!.docs[0]["read"]
                                          ? Colors.blue
                                          : ColorsManager.grey,
                                    )
                                  : Container(),
                              const Spacer(),
                              !snapshot.data!.docs[0]["read"] &&
                                      snapshot.data!.docs[0]["sendTo"] ==
                                          Apis.firebaseAuth.currentUser!.uid
                                  ? StreamBuilder<QuerySnapshot>(
                                      stream: Apis.countMesageUnRead(
                                          itemChatModel.token),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return CircleAvatar(
                                            radius: DefualtValue.d10,
                                            backgroundColor:
                                                ColorsManager.primaryColorLight,
                                            child: Text(
                                              "${snapshot.data!.docs.length}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color:
                                                          ColorsManager.white,
                                                      fontSize: FontSizeManager
                                                          .fs_10),
                                            ),
                                          );
                                        }
                                        return Container();
                                      },
                                    )
                                  : Text(
                                      toDate(int.parse(
                                          snapshot.data!.docs[0]["dateSend"])),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: ColorsManager.grey,
                                              fontSize: FontSizeManager.fs_10),
                                    ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            ),
            const SizedBox(
              width: DefualtValue.d2,
            ),
            // itemChatModel.active
            //     ? const CircleAvatar(
            //         radius: DefualtValue.d4,
            //         backgroundColor: Colors.green,
            //       )
            //     : Container(),
          ],
        ),
      ),
    );
  }
}
