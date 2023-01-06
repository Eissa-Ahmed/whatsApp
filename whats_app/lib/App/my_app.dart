import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:whats_app/Presentation/Auth/ViewModel/auth_cubit.dart';
import 'package:whats_app/Presentation/HomeChat/ViewModel/home_cubit.dart';

import '../Data/shared_preferences.dart';
import '../Presentation/Auth/View/Lang/lang_screen.dart';
import '../Presentation/HomeChat/View/Home/home_screen.dart';
import '../Presentation/Resources/routes_manager.dart';
import '../Presentation/Resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit()..init()),
            BlocProvider(create: (context) => HomeCubit()..init()),
          ],
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              AuthCubit cubit = AuthCubit.get(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: cubit.getLocale(),
                theme: lightTheme(),
                darkTheme: darkTheme(),
                themeMode: cubit.getTheme() ?? ThemeMode.system,
                onGenerateRoute: onGenerateRoute,
                home: CachHelper.sharedPreferences.get("login") == true
                    ? const HomeScreen()
                    : const LangScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
