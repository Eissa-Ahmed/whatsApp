import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whats_app/Presentation/Resources/colors_manager.dart';
import 'package:whats_app/Presentation/Resources/constants.dart';
import 'package:whats_app/Presentation/Resources/images_manager.dart';
import 'package:whats_app/Presentation/Resources/values_manager.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PaddingManager.p12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: const NetworkImage(ImagesManager.group),
            width: DefualtValue.d70.w,
          ),
          const SizedBox(
            height: DefualtValue.d20,
          ),
          Text(
            language(context).socity,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: DefualtValue.d8,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                language(context).socitydis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: ColorsManager.grey),
              ),
            ],
          ),
          const SizedBox(
            height: DefualtValue.d20,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(DefualtValue.d70.w, DefualtValue.d50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DefualtValue.d50),
              ),
            ),
            child: Text(
              language(context).createSocity,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
