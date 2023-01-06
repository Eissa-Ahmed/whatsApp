import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:whats_app/Presentation/Resources/colors_manager.dart';
import 'package:whats_app/Presentation/Resources/constants.dart';
import 'package:whats_app/Presentation/Resources/images_manager.dart';
import 'package:whats_app/Presentation/Resources/values_manager.dart';

import '../../../Resources/routes_manager.dart';
import '../../ViewModel/home_cubit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Pages.home, (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    language(context).gary,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    language(context).wait,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ColorsManager.grey),
                  ),
                  const Spacer(),
                  Image(
                    image: const AssetImage(ImagesManager.circle),
                    width: DefualtValue.d80.w,
                  ),
                  const Spacer(),
                  const CircularProgressIndicator(
                    color: ColorsManager.primaryColorLight,
                  ),
                  const SizedBox(
                    height: DefualtValue.d20,
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
