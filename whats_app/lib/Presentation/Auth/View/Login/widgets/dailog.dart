import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../Resources/constants.dart';
import '../../../../Resources/routes_manager.dart';
import '../../../../Resources/values_manager.dart';
import '../../../ViewModel/auth_cubit.dart';

Future<dynamic> customDailog(BuildContext context, AuthCubit cubit) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(PaddingManager.p4),
          content: Container(
            width: DefualtValue.d80.w,
            padding: const EdgeInsets.all(PaddingManager.p12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  language(context).enterdPhone,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: DefualtValue.d10,
                ),
                Text(
                  "${cubit.phoneController.text} 20+",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: DefualtValue.d10,
                ),
                Text(
                  language(context).rightPhone,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: DefualtValue.d10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(language(context).edit),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Pages.pinCode);
                        cubit.sendOtp();
                        cubit.timeSendCode = 30;
                        cubit.incrementTimeSendCode();
                      },
                      child: Text(language(context).ok),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
