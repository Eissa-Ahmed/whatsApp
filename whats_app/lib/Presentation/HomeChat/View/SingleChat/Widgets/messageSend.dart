import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whats_app/Data/apis.dart';
import 'package:whats_app/Domain/messageModel.dart';

import '../../../../Resources/colors_manager.dart';
import '../../../../Resources/fonts_manager.dart';
import '../../../../Resources/values_manager.dart';

class MessageMe extends StatelessWidget {
  MessageMe({super.key, required this.message, required this.uid});

  MessageModel message;
  String uid;

  @override
  Widget build(BuildContext context) {
    print("Essa");
    Apis.readMessage(uid, message);
    return message.type == "image"
        ? Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: DefualtValue.d4),
              constraints: BoxConstraints(maxWidth: DefualtValue.d70.w),
              width: DefualtValue.d40.w,
              decoration: BoxDecoration(
                color: ColorsManager.primaryColorLight,
                border: Border.all(color: ColorsManager.primaryColorLight),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(DefualtValue.d25),
                  bottomLeft: Radius.circular(DefualtValue.d25),
                  bottomRight: Radius.circular(DefualtValue.d25),
                ),
              ),
              child: Column(
                children: [
                  Image(
                    width: DefualtValue.d40.w,
                    height: DefualtValue.d40.w,
                    image: NetworkImage(message.message),
                  ),
                  Text(
                    message.dis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: FontSizeManager.fs_12),
                  )
                ],
              ),
            ),
          )
        : Align(
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
}

class MessageYou extends StatelessWidget {
  MessageYou({super.key, required this.message, required this.uid});
  MessageModel message;
  String uid;

  @override
  Widget build(BuildContext context) {
    print("Essa");

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
}
