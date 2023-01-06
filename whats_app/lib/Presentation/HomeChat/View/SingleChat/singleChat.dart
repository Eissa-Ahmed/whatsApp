import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whats_app/Domain/itemChatModel.dart';
import 'package:whats_app/Presentation/Resources/constants.dart';
import 'package:whats_app/Presentation/Resources/fonts_manager.dart';
import 'package:whats_app/Presentation/Resources/images_manager.dart';

import '../../../Resources/colors_manager.dart';
import '../../../Resources/values_manager.dart';

class SingleChat extends StatelessWidget {
  SingleChat({super.key, required this.itemChatModel});
  ItemChatModel itemChatModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(DefualtValue.d12),
        // height: DefualtValue.d100,
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DefualtValue.d28),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: PaddingManager.p4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(DefualtValue.d28),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(DefualtValue.d10),
                          child: Icon(
                            FontAwesomeIcons.faceSmile,
                            size: DefualtValue.d20,
                            color: ColorsManager.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: language(context).writeMessage,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: ColorsManager.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(DefualtValue.d10),
                          child: Icon(
                            FontAwesomeIcons.paperclip,
                            size: DefualtValue.d20,
                            color: ColorsManager.grey,
                          ),
                        ),
                      ),
                      InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(DefualtValue.d10),
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
              width: DefualtValue.d16,
            ),
            InkWell(
              onLongPress: () {
                print("Essa");
              },
              overlayColor: MaterialStateProperty.all(Colors.transparent),
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
              backgroundImage: NetworkImage(itemChatModel.image),
            ),
            const SizedBox(
              width: DefualtValue.d10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemChatModel.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorsManager.white,
                        fontSize: FontSizeManager.fs_16),
                  ),
                  Text(
                    itemChatModel.date,
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            opacity: 0.2,
            image: AssetImage(ImagesManager.background),
          ),
        ),
        child: Column(
          children: const [],
        ),
      ),
    );
  }
}
