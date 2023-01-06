import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whats_app/Data/shared_preferences.dart';
import 'package:whats_app/Presentation/Resources/constants.dart';
import 'package:whats_app/Presentation/Resources/routes_manager.dart';
import 'package:whats_app/Presentation/Resources/values_manager.dart';

import '../../ViewModel/auth_cubit.dart';
import 'Widgets/customRadio.dart';
import 'Widgets/shader_mask.dart';

class LangScreen extends StatelessWidget {
  const LangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (CachHelper.sharedPreferences.get("language") == null) {
            CachHelper.saveLocalData(
                "language", Platform.localeName.split("_").first);
          }
          Navigator.of(context).pushReplacementNamed(Pages.welcome);
        },
        child: const Icon(FontAwesomeIcons.arrowRight),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(PaddingManager.p16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    shaderMask(context),
                    Positioned(
                      bottom: DefualtValue.d40,
                      left: DefualtValue.d0,
                      right: DefualtValue.d0,
                      child: Column(
                        children: [
                          Text(
                            language(context).welcome,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            language(context).choose,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    return itemRadioForLang(
                        cubit, context, cubit.listOfLanguage(context)[i]);
                  },
                  itemCount: cubit.listOfLanguage(context).length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
