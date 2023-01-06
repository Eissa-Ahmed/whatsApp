import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../../../Data/permission.dart';
import '../../../../Resources/colors_manager.dart';
import '../../../../Resources/constants.dart';
import '../../../../Resources/routes_manager.dart';
import '../../../../Resources/values_manager.dart';
import '../../../ViewModel/home_cubit.dart';

dailogLogin(BuildContext context, HomeCubit cubit) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Theme.of(context).primaryColorLight,
          content: SizedBox(
            height: DefualtValue.d40.h,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: ColorsManager.primaryColorLight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          FontAwesomeIcons.folder,
                          size: DefualtValue.d40,
                        ),
                        SizedBox(
                          width: DefualtValue.d14,
                        ),
                        Icon(FontAwesomeIcons.plus),
                        SizedBox(
                          width: DefualtValue.d14,
                        ),
                        Icon(
                          FontAwesomeIcons.addressCard,
                          size: DefualtValue.d40,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(PaddingManager.p14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          language(context).contact,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: DefualtValue.d12,
                        ),
                        Wrap(
                          children: [
                            Text(
                              language(context).allow,
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                loginData(cubit, context);
                              },
                              child: Text(language(context).notNow),
                            ),
                            TextButton(
                              onPressed: () async {
                                await permission(Permission.contacts);
                                await permission(
                                    Permission.accessMediaLocation);
                                await permission(
                                    Permission.manageExternalStorage);
                                loginData(cubit, context);
                              },
                              child: Text(language(context).follow),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

void loginData(HomeCubit cubit, BuildContext context) {
  if (cubit.nameController.text == "" && cubit.imageProfile == null) {
    Navigator.of(context).pushNamedAndRemoveUntil(Pages.home, (route) => false);
  } else {
    Navigator.of(context).pushReplacementNamed(Pages.loading);
    cubit.login(context);
  }
}
