import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whats_app/Presentation/HomeChat/View/Info/Widgets/chooseImage.dart';
import 'package:whats_app/Presentation/HomeChat/View/Info/Widgets/inputName.dart';
import 'package:whats_app/Presentation/HomeChat/View/Info/Widgets/keyBoardEmoji.dart';
import 'package:whats_app/Presentation/HomeChat/ViewModel/home_cubit.dart';
import 'package:whats_app/Presentation/Resources/colors_manager.dart';

import '../../../Auth/View/Login/widgets/menu.dart';
import '../../../Resources/constants.dart';
import '../../../Resources/values_manager.dart';
import 'Widgets/dailogLogin.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            elevation: DefualtValue.d0,
            title: Text(
              language(context).selfInfo,
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
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(PaddingManager.p20),
                  child: Column(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            language(context).pleaseEnterName,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: ColorsManager.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: DefualtValue.d20,
                      ),
                      chooseImage(cubit),
                      const SizedBox(
                        height: DefualtValue.d20,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              cubit.toogle();
                            },
                            icon: const Icon(
                              FontAwesomeIcons.faceSmile,
                              size: DefualtValue.d25,
                            ),
                          ),
                          inputName(cubit),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          await dailogLogin(context, cubit);
                        },
                        child: Text(language(context).next),
                      ),
                    ],
                  ),
                ),
              ),
              keyBoardEmoji(cubit, cubit.nameController),
            ],
          ),
        );
      },
    );
  }
}
