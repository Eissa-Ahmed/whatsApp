import 'package:flutter/material.dart';

import '../../../../Resources/colors_manager.dart';
import '../../../../Resources/constants.dart';
import '../../../ViewModel/auth_cubit.dart';

Wrap infoText(BuildContext context, AuthCubit cubit) {
  return Wrap(
    alignment: WrapAlignment.center,
    crossAxisAlignment: WrapCrossAlignment.center,
    // mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        language(context).verifyYourPhone,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      TextButton(
        onPressed: () async {
          await cubit.getPhoneNumber().then((value) => print(value!.length));
        },
        child: Text(
          language(context).whatisNumber,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorsManager.celadonBlue),
        ),
      )
    ],
  );
}
