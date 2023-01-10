import 'package:flutter/material.dart';
import 'package:whats_app/Presentation/Auth/View/Lang/lang_screen.dart';
import 'package:whats_app/Presentation/Auth/View/Login/login_screen.dart';
import 'package:whats_app/Presentation/Auth/View/PinCode/pinCode_screen.dart';
import 'package:whats_app/Presentation/HomeChat/View/Info/info_screen.dart';
import 'package:whats_app/Presentation/HomeChat/View/Info/loading_screen.dart';
import 'package:whats_app/Presentation/HomeChat/View/SingleChat/Widgets/sendPhoto.dart';
import 'package:whats_app/Presentation/HomeChat/View/SingleChat/singleChat.dart';
import 'package:whats_app/Presentation/Resources/strings_manager.dart';

import '../../Domain/userModel.dart';
import '../Auth/View/welcome/welcome_screen.dart';
import '../HomeChat/View/Home/home_screen.dart';

class Pages {
  static const String lang = "/";
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String pinCode = "/pinCode";
  static const String info = "/info";
  static const String home = "/home";
  static const String loading = "/loading";
  static const String singleChat = "/singleChat";
  static const String sendPhotoo = "/sendPhotoo";
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Pages.singleChat:
      UserModel args = settings.arguments as UserModel;
      return MaterialPageRoute(
          builder: (_) => SingleChat(
                userModel: args,
              ));
    case Pages.lang:
      return MaterialPageRoute(builder: (_) => const LangScreen());
    case Pages.welcome:
      return MaterialPageRoute(builder: (_) => const WelcomeScreen());
    case Pages.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case Pages.pinCode:
      return MaterialPageRoute(builder: (_) => const PinCode());
    case Pages.info:
      return MaterialPageRoute(builder: (_) => const InfoScreen());
    case Pages.home:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case Pages.loading:
      return MaterialPageRoute(builder: (_) => const LoadingScreen());
    case Pages.sendPhotoo:
      UserModel args = settings.arguments as UserModel;
      return MaterialPageRoute(
          builder: (_) => SendPhoto(
                user: args,
              ));
    default:
      return MaterialPageRoute(
        builder: (_) => const EmptyPage(),
      );
  }
}

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          StringsManager.wrongMessage,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
