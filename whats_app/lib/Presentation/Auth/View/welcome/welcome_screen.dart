import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whats_app/Presentation/Auth/View/welcome/widgets/buttomLang.dart';
import 'package:whats_app/Presentation/Auth/View/welcome/widgets/infoText.dart';
import 'package:whats_app/Presentation/Auth/ViewModel/auth_cubit.dart';
import 'package:whats_app/Presentation/Resources/constants.dart';
import 'package:whats_app/Presentation/Resources/images_manager.dart';
import 'package:whats_app/Presentation/Resources/routes_manager.dart';
import 'package:whats_app/Presentation/Resources/values_manager.dart';

import '../../../Resources/colors_manager.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: PaddingManager.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              Image(
                image: const AssetImage(ImagesManager.circle),
                width: DefualtValue.d70.w,
              ),
              const SizedBox(
                height: DefualtValue.d18,
              ),
              Text(
                language(context).welcomeWhats,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(
                height: DefualtValue.d14,
              ),
              infoText(context),
              const SizedBox(
                height: DefualtValue.d10,
              ),
              const SizedBox(
                height: DefualtValue.d14,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(DefualtValue.d100.w, DefualtValue.d2.h),
                  backgroundColor: ColorsManager.primaryColorLightWithOpacity,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Pages.login);
                },
                child: Text(language(context).buttomAgree),
              ),
              const SizedBox(
                height: DefualtValue.d30,
              ),
              const Spacer(
                flex: 1,
              ),
              showLanguage(context, cubit),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
