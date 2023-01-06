import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:whats_app/Presentation/Resources/colors_manager.dart';
import 'package:whats_app/Presentation/Resources/fonts_manager.dart';
import 'package:whats_app/Presentation/Resources/images_manager.dart';
import 'package:whats_app/Presentation/Resources/style_manager.dart';
import 'package:whats_app/Presentation/Resources/values_manager.dart';

import '../../../Resources/constants.dart';
import '../../ViewModel/auth_cubit.dart';
import '../Login/widgets/menu.dart';

class PinCode extends StatelessWidget {
  const PinCode({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: cubit.loading,
          blur: 0.3,
          progressIndicator:
              Lottie.asset(ImagesManager.loading, width: DefualtValue.d20.w),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColorLight,
              elevation: DefualtValue.d0,
              title: Text(
                language(context).checkPhone,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  helpMenu(context);
                },
                icon: const Icon(FontAwesomeIcons.ellipsisVertical),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(PaddingManager.p20),
              child: Column(
                children: [
                  Text(
                    language(context).sendedMessage,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ColorsManager.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${cubit.phoneController.text} 20+",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          cubit.timeSendCode = 0;
                        },
                        child: Text(
                          language(context).editNumber,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: ColorsManager.celadonBlue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: DefualtValue.d16,
                  ),
                  PinCodeTextField(
                    hintCharacter: "_",
                    textInputAction: TextInputAction.send,
                    autoFocus: true,
                    keyboardType: TextInputType.number,
                    errorTextDirection: TextDirection.ltr,
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    textStyle: bold(FontSizeManager.fs_16, ColorsManager.black),
                    pinTheme: PinTheme(
                      activeColor: Colors.transparent,
                      inactiveColor: ColorsManager.grey,
                      selectedFillColor: Colors.blue,
                      disabledColor: ColorsManager.greyLight,
                      inactiveFillColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: ColorsManager.greyLight,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    // errorAnimationController: errorController,
                    // controller: textEditingController,
                    onCompleted: (v) {
                      try {
                        cubit.signinPhone(v, context);
                      } catch (e) {
                        print("===========");
                        print(e.toString());
                        print("===========");
                      }
                    },
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      print("Allowing to paste ");
                      return true;
                    },
                  ),
                  Text(
                    language(context).enterCode,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ColorsManager.greyDark),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cubit.timeSendCode == 0
                          ? TextButton(
                              onPressed: () => cubit.timeSendCode == 0
                                  ? cubit.sendOtp()
                                  : null,
                              child: Text(
                                language(context).noSended,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: cubit.timeSendCode == 0
                                          ? ColorsManager.celadonBlue
                                          : ColorsManager.grey,
                                    ),
                              ),
                            )
                          : Text(
                              "${cubit.timeSendCode} : 00",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                    ],
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
