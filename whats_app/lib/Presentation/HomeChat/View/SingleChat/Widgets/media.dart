import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Resources/colors_manager.dart';
import '../../../../Resources/constants.dart';
import '../../../../Resources/values_manager.dart';

Positioned media(BuildContext context) {
  return Positioned(
    bottom: DefualtValue.d60,
    right: DefualtValue.d0,
    left: DefualtValue.d0,
    child: FlipInX(
      animate: true,
      duration: duration(DurationManager.d200),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: PaddingManager.p40, vertical: PaddingManager.p14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DefualtValue.d12),
          color: ColorsManager.coral,
        ),
        child: Wrap(
          children: [
            itemMedia(context, FontAwesomeIcons.image, Colors.amber, "المعرض"),
            itemMedia(context, FontAwesomeIcons.image, Colors.green, "المعرض"),
            itemMedia(context, FontAwesomeIcons.image, Colors.red, "المعرض"),
            itemMedia(context, FontAwesomeIcons.image, Colors.blue, "المعرض"),
            itemMedia(context, FontAwesomeIcons.image, Colors.orange, "المعرض"),
            itemMedia(context, FontAwesomeIcons.image, Colors.cyan, "المعرض"),
          ],
        ),
      ),
    ),
  );
}

Padding itemMedia(
    BuildContext context, IconData icon, MaterialColor color, String text) {
  return Padding(
    padding: const EdgeInsets.all(DefualtValue.d14),
    child: Column(
      children: [
        Container(
          width: DefualtValue.d60,
          height: DefualtValue.d60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color,
                color.withOpacity(0.5),
              ],
            ),
          ),
          child: Icon(
            icon,
            size: DefualtValue.d25,
          ),
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorsManager.grey),
        ),
      ],
    ),
  );
}
