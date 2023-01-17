import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whats_app/Data/apis.dart';
import 'package:whats_app/Data/toDate.dart';
import 'package:whats_app/Domain/messageModel.dart';
import 'package:whats_app/Presentation/HomeChat/ViewModel/home_cubit.dart';

import '../../../../Resources/colors_manager.dart';
import '../../../../Resources/fonts_manager.dart';
import '../../../../Resources/routes_manager.dart';
import '../../../../Resources/values_manager.dart';

class MessageMe extends StatelessWidget {
  MessageMe({super.key, required this.message, required this.uid});

  MessageModel message;
  String uid;

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    Apis.readMessage(uid, message);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is ClosesSelectedState) {
          Apis.changeSelectedBox(message, false, uid);
        }
      },
      builder: (context, state) {
        return InkWell(
          onLongPress: () {
            cubit.toogleSelected();
            Apis.changeSelectedBox(message, true, uid);
          },
          child: Container(
            color: message.selected ? ColorsManager.grey : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                message.type == "image"
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: DefualtValue.d4),
                          constraints:
                              BoxConstraints(maxWidth: DefualtValue.d70.w),
                          width: DefualtValue.d40.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryColorLight,
                            border: Border.all(
                                color: ColorsManager.primaryColorLight,
                                width: DefualtValue.d2),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.circular(DefualtValue.d12),
                              bottomLeft: Radius.circular(DefualtValue.d12),
                              bottomRight: Radius.circular(DefualtValue.d12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.zero,
                                  topRight: Radius.circular(DefualtValue.d12),
                                ),
                                child: InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, Pages.viewImage,
                                      arguments: message),
                                  child: Hero(
                                    tag: message.namePhoto,
                                    child: CachedNetworkImage(
                                      imageUrl: message.message,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              message.dis == ""
                                  ? Container()
                                  : Text(
                                      message.dis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: FontSizeManager.fs_12),
                                    ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(PaddingManager.p8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      toDate(int.parse(message.dateSend)),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: FontSizeManager.fs_8,
                                              color: ColorsManager.grey),
                                    ),
                                    const SizedBox(
                                      width: DefualtValue.d4,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.checkDouble,
                                      size: DefualtValue.d10,
                                      color: message.read
                                          ? Colors.blue
                                          : ColorsManager.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: DefualtValue.d4),
                          constraints:
                              BoxConstraints(maxWidth: DefualtValue.d70.w),
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
                                    toDate(int.parse(message.dateSend)),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: FontSizeManager.fs_8,
                                            color: ColorsManager.grey),
                                  ),
                                  const SizedBox(
                                    width: DefualtValue.d4,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.checkDouble,
                                    size: DefualtValue.d10,
                                    color: message.read
                                        ? Colors.blue
                                        : ColorsManager.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                cubit.selected
                    ? Checkbox(
                        value: message.selected,
                        onChanged: (val) {
                          Apis.changeSelectedBox(message, val!, uid);
                        })
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MessageYou extends StatelessWidget {
  MessageYou({super.key, required this.message, required this.uid});

  MessageModel message;
  String uid;

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    Apis.readMessage(uid, message);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is ClosesSelectedState) {
          Apis.changeSelectedBox(message, false, uid);
        }
      },
      builder: (context, state) {
        return InkWell(
          onLongPress: () {
            cubit.toogleSelected();
            Apis.changeSelectedBox(message, true, uid);
          },
          child: Container(
            color: message.selected ? ColorsManager.grey : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                message.type == "image"
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: DefualtValue.d4),
                          constraints:
                              BoxConstraints(maxWidth: DefualtValue.d70.w),
                          width: DefualtValue.d40.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.greyLight,
                            border: Border.all(
                                color: ColorsManager.greyLight,
                                width: DefualtValue.d2),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.circular(DefualtValue.d12),
                              bottomLeft: Radius.circular(DefualtValue.d12),
                              bottomRight: Radius.circular(DefualtValue.d12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.zero,
                                  topRight: Radius.circular(DefualtValue.d12),
                                ),
                                child: InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, Pages.viewImage,
                                      arguments: message),
                                  child: Hero(
                                    tag: message.namePhoto,
                                    child: CachedNetworkImage(
                                      imageUrl: message.message,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              message.dis == ""
                                  ? Container()
                                  : Text(
                                      message.dis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: FontSizeManager.fs_12),
                                    ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(PaddingManager.p8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      toDate(int.parse(message.dateSend)),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: FontSizeManager.fs_8,
                                              color: ColorsManager.grey),
                                    ),
                                    const SizedBox(
                                      width: DefualtValue.d4,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.checkDouble,
                                      size: DefualtValue.d10,
                                      color: message.read
                                          ? Colors.blue
                                          : ColorsManager.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: DefualtValue.d4),
                          constraints:
                              BoxConstraints(maxWidth: DefualtValue.d70.w),
                          padding: const EdgeInsets.all(DefualtValue.d12),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: FontSizeManager.fs_12,
                                        color: ColorsManager.primaryColorDark),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    toDate(int.parse(message.dateSend)),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: FontSizeManager.fs_8,
                                            color: ColorsManager.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                cubit.selected
                    ? Checkbox(
                        value: message.selected,
                        onChanged: (val) {
                          Apis.changeSelectedBox(message, val!, uid);
                        })
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}


// class MessageYou extends StatelessWidget {
//   MessageYou({super.key, required this.message, required this.uid});
//   MessageModel message;
//   String uid;

//   @override
//   Widget build(BuildContext context) {
//     Apis.readMessage(uid, message);
//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {
//         if (state is ClosesSelectedState) {
//           Apis.changeSelectedBox(message, false, uid);
//         }
//       },
//       builder: (context, state) {
//         return message.type == "image"
//             ? Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(vertical: DefualtValue.d4),
//                   constraints: BoxConstraints(maxWidth: DefualtValue.d70.w),
//                   width: DefualtValue.d40.w,
//                   decoration: BoxDecoration(
//                     color: ColorsManager.greyLight,
//                     border: Border.all(
//                         color: ColorsManager.greyLight, width: DefualtValue.d2),
//                     borderRadius: const BorderRadius.only(
//                       topRight: Radius.zero,
//                       bottomRight: Radius.circular(DefualtValue.d12),
//                       bottomLeft: Radius.circular(DefualtValue.d12),
//                       topLeft: Radius.circular(DefualtValue.d12),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.only(
//                           topRight: Radius.zero,
//                           topLeft: Radius.circular(DefualtValue.d12),
//                         ),
//                         child: InkWell(
//                           onTap: () => Navigator.pushNamed(
//                               context, Pages.viewImage,
//                               arguments: message),
//                           child: Hero(
//                             tag: message.namePhoto,
//                             child: CachedNetworkImage(
//                               imageUrl: message.message,
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) => Center(
//                                 child: CircularProgressIndicator(
//                                     value: downloadProgress.progress),
//                               ),
//                               errorWidget: (context, url, error) =>
//                                   const Icon(Icons.error),
//                             ),
//                           ),
//                         ),
//                       ),
//                       message.dis == ""
//                           ? Container()
//                           : Text(
//                               message.dis,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodySmall!
//                                   .copyWith(
//                                       fontSize: FontSizeManager.fs_12,
//                                       color: ColorsManager.black),
//                             ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: PaddingManager.p8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               toDate(int.parse(message.dateSend)),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodySmall!
//                                   .copyWith(
//                                       fontSize: FontSizeManager.fs_8,
//                                       color: ColorsManager.grey),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             : Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(vertical: DefualtValue.d4),
//                   constraints: BoxConstraints(maxWidth: DefualtValue.d70.w),
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: DefualtValue.d12, vertical: DefualtValue.d8),
//                   decoration: const BoxDecoration(
//                     color: ColorsManager.greyLight,
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.zero,
//                       topLeft: Radius.circular(DefualtValue.d25),
//                       bottomLeft: Radius.circular(DefualtValue.d25),
//                       bottomRight: Radius.circular(DefualtValue.d25),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         message.message,
//                         style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             fontSize: FontSizeManager.fs_12,
//                             color: ColorsManager.black),
//                       ),
//                       Text(
//                         toDate(int.parse(message.dateSend)),
//                         style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             fontSize: FontSizeManager.fs_8,
//                             color: ColorsManager.grey),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//       },
//     );
//   }
// }
