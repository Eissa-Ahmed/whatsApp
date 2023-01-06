import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../Data/shared_preferences.dart';
import '../../../../Resources/colors_manager.dart';
import '../../../../Resources/constants.dart';
import '../../../../Resources/values_manager.dart';
import '../../../ViewModel/auth_cubit.dart';
import 'buttomSheet.dart';

ElevatedButton showLanguage(BuildContext context, AuthCubit cubit) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size(DefualtValue.d50.w, DefualtValue.d2.h),
      shape: const StadiumBorder(),
      backgroundColor: ColorsManager.primaryColorDarkWithOpacity,
    ),
    onPressed: () {
      buttomSheet(context, cubit);
    },
    child: rowButtom(context),
  );
}

Row rowButtom(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(
        FontAwesomeIcons.globe,
        color: ColorsManager.primaryColorLightWithOpacity,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: DefualtValue.d8),
        child: Text(
          CachHelper.sharedPreferences.get("language").toString() == "ar"
              ? language(context).arbic
              : language(context).english,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: ColorsManager.primaryColorLightWithOpacity),
        ),
      ),
      const Icon(
        FontAwesomeIcons.angleDown,
        color: ColorsManager.primaryColorLightWithOpacity,
      ),
    ],
  );
}
