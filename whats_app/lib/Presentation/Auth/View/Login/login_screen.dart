import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whats_app/Presentation/Auth/View/Login/widgets/dailog.dart';
import 'package:whats_app/Presentation/Auth/View/Login/widgets/formLogin.dart';
import 'package:whats_app/Presentation/Auth/View/Login/widgets/menu.dart';
import 'package:whats_app/Presentation/Auth/ViewModel/auth_cubit.dart';
import 'package:whats_app/Presentation/Resources/values_manager.dart';

import '../../../Resources/colors_manager.dart';
import '../../../Resources/constants.dart';
import '../welcome/widgets/infoText.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: DefualtValue.d0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              language(context).enterPhone,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: IconButton(
              onPressed: () {
                helpMenu(context);
              },
              icon: const Icon(FontAwesomeIcons.ellipsisVertical),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(PaddingManager.p10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                infoText(context),
                formLogin(cubit, context),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.primaryColorLight,
                    padding: const EdgeInsets.symmetric(
                        horizontal: PaddingManager.p20,
                        vertical: PaddingManager.p12),
                  ),
                  onPressed: () {
                    if (cubit.loginForm.currentState!.validate()) {
                      customDailog(context, cubit);
                    }
                  },
                  child: Text(language(context).next),
                ),
                const SizedBox(
                  height: DefualtValue.d14,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
