import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whats_app/Presentation/Resources/colors_manager.dart';
import 'package:whats_app/Presentation/Resources/fonts_manager.dart';
import 'package:whats_app/Presentation/Resources/style_manager.dart';
import 'package:whats_app/Presentation/Resources/values_manager.dart';

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    // colorScheme: const ColorScheme(
    //   primary: ColorsManager.black,
    //   onPrimary: ColorsManager.primaryColorLight,
    //   brightness: Brightness.dark,
    //   secondary: ColorsManager.primaryColorLight,
    //   onSecondary: ColorsManager.white,
    //   error: Colors.red,
    //   onError: Colors.red,
    //   background: ColorsManager.white,
    //   onBackground: ColorsManager.white,
    //   surface: ColorsManager.primaryColorLight,
    //   onSurface: ColorsManager.primaryColorLight,
    // ),
    //IconThemeData
    iconTheme: const IconThemeData(
      color: ColorsManager.black,
    ),
    primaryIconTheme: const IconThemeData(
      color: ColorsManager.black,
    ),

    //InputDecorationTheme
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorsManager.primaryColorLight,
          width: 2,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorsManager.primaryColorLight,
          width: 2,
        ),
      ),
    ),

    //Colors
    highlightColor: ColorsManager.primaryColorLight,
    primaryColor: ColorsManager.primaryColorLight,
    primaryColorLight: Colors.white,
    primaryColorDark: ColorsManager.primaryColorDark,
    splashColor: ColorsManager.primaryColorLightWithOpacity,
    scaffoldBackgroundColor: ColorsManager.white,

    //AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsManager.primaryColorLight,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorsManager.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),

    //Button Theme
    buttonTheme: const ButtonThemeData(
      splashColor: ColorsManager.primaryColorLightWithOpacity,
      highlightColor: ColorsManager.primaryColorLightWithOpacity,
      focusColor: ColorsManager.primaryColorLightWithOpacity,
    ),

    //FloatingActionButtonThemeData
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.primaryColorLight,
      foregroundColor: ColorsManager.white,
    ),

    //Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(PaddingManager.p12),
        textStyle: medium(FontSizeManager.fs_16, ColorsManager.white),
        backgroundColor: ColorsManager.primaryColorLight,
        foregroundColor: ColorsManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DefualtValue.d4),
        ),
      ),
    ),

    //BottomSheetThemeData
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorsManager.white,
    ),

    //PopupMenuThemeData
    popupMenuTheme: const PopupMenuThemeData(
      color: ColorsManager.white,
    ),

    cardColor: ColorsManager.greyLight,

    //Text Theme
    textTheme: TextTheme(
      displayLarge: bold(FontSizeManager.fs_32, ColorsManager.primaryColorDark),
      bodyMedium: medium(FontSizeManager.fs_18, ColorsManager.primaryColorDark),
      bodySmall: regular(FontSizeManager.fs_14, ColorsManager.primaryColorDark),
      labelSmall: regular(FontSizeManager.fs_14, ColorsManager.grey),
      titleSmall:
          regular(FontSizeManager.fs_14, ColorsManager.primaryColorDark),
      headlineMedium:
          medium(FontSizeManager.fs_18, ColorsManager.primaryColorDark),
      headlineSmall: medium(FontSizeManager.fs_16, ColorsManager.grey),
    ),

    //TextButtonThemeData
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorsManager.primaryColorLight,
        textStyle:
            medium(FontSizeManager.fs_16, ColorsManager.primaryColorLight),
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    // colorScheme: const ColorScheme(
    //   primary: ColorsManager.white,
    //   onPrimary: ColorsManager.white,
    //   brightness: Brightness.dark,
    //   secondary: ColorsManager.primaryColorLight,
    //   onSecondary: ColorsManager.white,
    //   error: Colors.red,
    //   onError: Colors.red,
    //   background: ColorsManager.white,
    //   onBackground: ColorsManager.white,
    //   surface: ColorsManager.primaryColorLight,
    //   onSurface: ColorsManager.primaryColorLight,
    // ),
    //IconThemeData
    iconTheme: const IconThemeData(
      color: ColorsManager.white,
    ),
    primaryIconTheme: const IconThemeData(
      color: ColorsManager.white,
    ),
    cardColor: ColorsManager.coral,

    //InputDecorationTheme
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorsManager.primaryColorLight,
          width: 2,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorsManager.primaryColorLight,
          width: 2,
        ),
      ),
    ),

    //Colors
    highlightColor: ColorsManager.coral,
    primaryColor: ColorsManager.primaryColorDark,
    primaryColorLight: ColorsManager.primaryColorDark,
    primaryColorDark: ColorsManager.white,
    splashColor: ColorsManager.primaryColorDarkWithOpacity,
    scaffoldBackgroundColor: ColorsManager.primaryColorDark,

    //AppBar Theme
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: ColorsManager.coral,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorsManager.primaryColorDark,
        statusBarIconBrightness: Brightness.light,
      ),
    ),

    //Button Theme
    buttonTheme: const ButtonThemeData(
      splashColor: ColorsManager.primaryColorDarkWithOpacity,
      highlightColor: ColorsManager.primaryColorDarkWithOpacity,
    ),

    //FloatingActionButtonThemeData
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.primaryColorLight,
      foregroundColor: ColorsManager.white,
    ),

    //Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(PaddingManager.p12),
        textStyle: medium(FontSizeManager.fs_16, ColorsManager.white),
        backgroundColor: ColorsManager.primaryColorLight,
        foregroundColor: ColorsManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DefualtValue.d4),
        ),
      ),
    ),

    //BottomSheetThemeData
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorsManager.primaryColorDarkWithOpacity,
    ),

    //PopupMenuThemeData
    popupMenuTheme: const PopupMenuThemeData(
      color: ColorsManager.primaryColorDarkWithOpacity,
    ),

    //Text Theme
    textTheme: TextTheme(
      displayLarge: bold(FontSizeManager.fs_32, ColorsManager.white),
      bodyMedium: medium(FontSizeManager.fs_18, ColorsManager.white),
      bodySmall: regular(FontSizeManager.fs_14, ColorsManager.white),
      labelSmall: regular(FontSizeManager.fs_14, ColorsManager.grey),
      titleSmall: regular(FontSizeManager.fs_14, ColorsManager.white),
      headlineMedium: medium(FontSizeManager.fs_18, ColorsManager.white),
      headlineSmall:
          medium(FontSizeManager.fs_16, ColorsManager.primaryColorLight),
    ),

    //TextButtonThemeData
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorsManager.primaryColorLight,
        textStyle:
            medium(FontSizeManager.fs_16, ColorsManager.primaryColorLight),
      ),
    ),
  );
}
