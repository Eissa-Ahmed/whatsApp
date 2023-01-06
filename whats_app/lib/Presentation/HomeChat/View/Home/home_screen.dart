import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whats_app/Presentation/HomeChat/View/Home/Widgets/chats.dart';
import 'package:whats_app/Presentation/Resources/constants.dart';
import 'package:whats_app/Presentation/Resources/fonts_manager.dart';
import 'package:whats_app/Presentation/Resources/values_manager.dart';

import '../../../Resources/colors_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      animationDuration: duration(DurationManager.d100),
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).highlightColor,
          ),
          title: Text(
            language(context).whats,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: ColorsManager.grey),
          ),
          actions: [
            InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(DefualtValue.d8),
                child: Icon(
                  FontAwesomeIcons.camera,
                  size: DefualtValue.d20,
                  color: ColorsManager.grey,
                ),
              ),
            ),
            InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(DefualtValue.d8),
                child: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: DefualtValue.d20,
                  color: ColorsManager.grey,
                ),
              ),
            ),
            InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(DefualtValue.d8),
                child: Icon(
                  FontAwesomeIcons.ellipsisVertical,
                  size: DefualtValue.d20,
                  color: ColorsManager.grey,
                ),
              ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: ColorsManager.primaryColorLight,
            labelColor: Theme.of(context).textTheme.headlineSmall!.color,
            unselectedLabelColor: ColorsManager.greyLight,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            isScrollable: true,
            labelStyle: Theme.of(context).textTheme.headlineSmall,
            unselectedLabelStyle:
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: FontSizeManager.fs_16,
                    ),
            tabs: [
              const SizedBox(
                width: 25,
                child: Tab(
                  icon: Icon(
                    FontAwesomeIcons.users,
                    size: DefualtValue.d20,
                  ),
                  iconMargin: EdgeInsets.zero,
                ),
              ),
              SizedBox(
                width: DefualtValue.d20.w,
                child: Tab(
                  child: Text(language(context).chats),
                ),
              ),
              SizedBox(
                width: DefualtValue.d20.w,
                child: Tab(
                  child: Text(language(context).story),
                ),
              ),
              SizedBox(
                width: DefualtValue.d20.w,
                child: Tab(
                  child: Text(language(context).calls),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.group),
            ChatsScreen(),
            Icon(Icons.circle),
            Icon(Icons.call),
          ],
        ),
      ),
    );
  }
}
