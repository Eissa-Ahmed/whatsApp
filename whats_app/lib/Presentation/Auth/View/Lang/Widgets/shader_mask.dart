import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../Resources/images_manager.dart';
import '../../../../Resources/values_manager.dart';

ShaderMask shaderMask(BuildContext context) {
  return ShaderMask(
    blendMode: BlendMode.srcATop,
    shaderCallback: (Rect bounds) => LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Theme.of(context).primaryColorLight,
        Theme.of(context).primaryColorLight,
        Theme.of(context).primaryColorLight.withOpacity(0.9),
        Theme.of(context).primaryColorLight.withOpacity(0.6),
        Theme.of(context).primaryColorLight.withOpacity(0.3),
        Colors.transparent,
        Colors.transparent,
      ],
    ).createShader(bounds),
    child: Opacity(
      opacity: 0.8,
      child: Image.asset(
        ImagesManager.circle,
        width: DefualtValue.d70.w,
      ),
    ),
  );
}
