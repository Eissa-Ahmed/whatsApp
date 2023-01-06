import 'package:flutter/material.dart';
import 'package:whats_app/Presentation/Resources/constants.dart';

import '../../../../Resources/colors_manager.dart';

RichText infoText(BuildContext context) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: language(context).read,
      style: Theme.of(context).textTheme.bodyMedium,
      children: <TextSpan>[
        TextSpan(
          text: language(context).privacy,
          style: const TextStyle(color: ColorsManager.celadonBlue),
        ),
        TextSpan(text: language(context).click),
        TextSpan(
          text: language(context).service,
          style: const TextStyle(color: ColorsManager.celadonBlue),
        ),
      ],
    ),
  );
}
