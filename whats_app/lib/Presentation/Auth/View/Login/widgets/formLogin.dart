import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Resources/colors_manager.dart';
import '../../../../Resources/constants.dart';
import '../../../../Resources/values_manager.dart';
import '../../../ViewModel/auth_cubit.dart';
import 'country.dart';

Form formLogin(AuthCubit cubit, BuildContext context) {
  return Form(
    key: cubit.loginForm,
    child: Padding(
      padding: const EdgeInsets.all(PaddingManager.p40),
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            readOnly: true,
            controller: cubit.countryController,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              prefixIcon: Icon(FontAwesomeIcons.caretDown),
            ),
            onTap: () {
              showcountries(context, cubit);
            },
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  cursorColor: ColorsManager.primaryColorLight,
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      return null;
                    } else {
                      return language(context).requird;
                    }
                  },
                  controller: cubit.phoneController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textDirection: TextDirection.ltr,
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: PaddingManager.p8,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: DefualtValue.d8,
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  readOnly: true,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.center,
                  controller: cubit.codeController,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: DefualtValue.d20,
          ),
          Text(
            language(context).fee,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: ColorsManager.grey),
          ),
        ],
      ),
    ),
  );
}
