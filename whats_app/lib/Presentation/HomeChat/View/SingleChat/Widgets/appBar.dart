import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whats_app/Data/apis.dart';
import 'package:whats_app/Domain/userModel.dart';
import 'package:whats_app/Presentation/Resources/constants.dart';

import '../../../../Resources/colors_manager.dart';
import '../../../../Resources/fonts_manager.dart';
import '../../../../Resources/values_manager.dart';
import '../../../ViewModel/home_cubit.dart';

AppBar appBarSingleChat(BuildContext context, UserModel userModel) {
  return AppBar(
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
  );
}

AppBar appBarSelected(
    HomeCubit cubit, BuildContext context, UserModel userModel) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        cubit.toogleSelected();
      },
      icon: const Icon(
        FontAwesomeIcons.x,
        size: DefualtValue.d18,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          FontAwesomeIcons.reply,
          size: DefualtValue.d18,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          FontAwesomeIcons.star,
          size: DefualtValue.d18,
        ),
      ),
      IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: SizedBox(
                    width: DefualtValue.d80.w,
                    height: DefualtValue.d20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          language(context).deleteM,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Text(
                                language(context).cancle,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: ColorsManager.primaryColorLight),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Apis.deleteMessageMe(userModel.token);
                              },
                              child: Text(
                                language(context).deleteMe,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: ColorsManager.primaryColorLight),
                              ),
                            ),
                            const SizedBox(
                              width: DefualtValue.d10,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                language(context).deleteAll,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: ColorsManager.primaryColorLight),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        icon: const Icon(
          FontAwesomeIcons.trash,
          size: DefualtValue.d18,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          FontAwesomeIcons.share,
          size: DefualtValue.d18,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          FontAwesomeIcons.ellipsisVertical,
          size: DefualtValue.d18,
        ),
      ),
    ],
  );
}
