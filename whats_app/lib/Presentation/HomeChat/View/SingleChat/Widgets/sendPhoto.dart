import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:whats_app/Domain/userModel.dart';
import 'package:whats_app/Presentation/Resources/images_manager.dart';
import 'package:whats_app/Presentation/Resources/values_manager.dart';

import '../../../../Resources/colors_manager.dart';
import '../../../../Resources/constants.dart';
import '../../../ViewModel/home_cubit.dart';

class SendPhoto extends StatelessWidget {
  SendPhoto({super.key, required this.user});
  UserModel user;

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: cubit.loading,
          blur: 0.3,
          progressIndicator:
              Lottie.asset(ImagesManager.loading, width: DefualtValue.d50),
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(cubit.imageFromDevice!),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: DefualtValue.d20,
                    right: DefualtValue.d0,
                    left: DefualtValue.d0,
                    child: Padding(
                      padding: const EdgeInsets.all(DefualtValue.d12),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              cubit.imageFromDevice = null;
                            },
                            icon: const Icon(
                              FontAwesomeIcons.x,
                              size: DefualtValue.d16,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.crop,
                              size: DefualtValue.d16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.faceSmile,
                              size: DefualtValue.d16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.textWidth,
                              size: DefualtValue.d16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.pen,
                              size: DefualtValue.d16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: DefualtValue.d60,
                    right: DefualtValue.d0,
                    left: DefualtValue.d0,
                    child: Container(
                      margin: const EdgeInsets.all(MarginManager.m14),
                      padding: const EdgeInsets.symmetric(
                          horizontal: PaddingManager.p10,
                          vertical: PaddingManager.p2),
                      decoration: BoxDecoration(
                        color: ColorsManager.celadonBlue,
                        borderRadius: BorderRadius.circular(DefualtValue.d25),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              cubit.imageFromDevice = null;
                            },
                            icon: const Icon(
                              FontAwesomeIcons.image,
                              size: DefualtValue.d16,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: cubit.dismessageController,
                              keyboardType: TextInputType.multiline,
                              style: Theme.of(context).textTheme.bodySmall,
                              decoration: InputDecoration(
                                hintText: language(context).addDis,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: ColorsManager.grey),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: DefualtValue.d0,
                    right: DefualtValue.d0,
                    left: DefualtValue.d0,
                    child: Padding(
                      padding: const EdgeInsets.all(PaddingManager.p14),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(PaddingManager.p10),
                            decoration: BoxDecoration(
                              color: ColorsManager.celadonBlue.withOpacity(0.8),
                              borderRadius:
                                  BorderRadius.circular(DefualtValue.d25),
                            ),
                            child: Text(
                              user.name,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              await cubit.sendMessagePhoto(user).then((value) {
                                Navigator.pop(context);
                                cubit.imageFromDevice = null;
                              });
                            },
                            child: const CircleAvatar(
                              radius: DefualtValue.d25,
                              backgroundColor: ColorsManager.primaryColorLight,
                              child: Icon(
                                FontAwesomeIcons.solidPaperPlane,
                                color: ColorsManager.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
