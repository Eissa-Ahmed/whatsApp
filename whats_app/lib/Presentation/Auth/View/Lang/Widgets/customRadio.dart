import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../Domain/language_model.dart';
import '../../../../Resources/constants.dart';
import '../../../ViewModel/auth_cubit.dart';

RadioListTile<String> itemRadioForLang(
    AuthCubit cubit, BuildContext context, LanguageModel languageModel) {
  return RadioListTile(
    value: languageModel.code,
    groupValue: cubit.groupValue,
    onChanged: (val) {
      cubit.groupValue = languageModel.code;
      cubit.changeLanguage(languageModel.code).then((value) {
        // Navigator.of(context).pushReplacementNamed(Pages.welcome);
      });
    },
    title: Text(
      languageModel.country,
      style: Theme.of(context).textTheme.bodySmall,
    ),
    subtitle: Text(
      Platform.localeName.split("_").first == languageModel.code
          ? language(context).currentLang
          : languageModel.desCountry,
      style: Theme.of(context).textTheme.labelSmall,
    ),
  );
}
