import 'package:flutter/cupertino.dart';
import 'package:whats_app/Presentation/Resources/fonts_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontFamily: FontsConstant.fontFamily,
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

//Regular
TextStyle regular(double fontSize, Color color) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

//Medium
TextStyle medium(double fontSize, Color color) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

//SemiBold
TextStyle semiBold(double fontSize, Color color) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

//Bold
TextStyle bold(double fontSize, Color color) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}
