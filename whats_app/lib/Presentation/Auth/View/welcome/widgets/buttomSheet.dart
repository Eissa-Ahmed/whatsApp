import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whats_app/Presentation/Resources/constants.dart';

import '../../../../Resources/colors_manager.dart';
import '../../../../Resources/values_manager.dart';
import '../../../ViewModel/auth_cubit.dart';
import '../../Lang/Widgets/customRadio.dart';

Future<dynamic> buttomSheet(BuildContext context, AuthCubit cubit) {
  return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      context: context,
      builder: (context) {
        return itemButtomSheet(cubit);
      });
}

DraggableScrollableSheet itemButtomSheet(AuthCubit cubit) {
  return DraggableScrollableSheet(
    expand: false,
    initialChildSize: 0.4,
    maxChildSize: 0.8,
    minChildSize: 0.2,
    builder: (context, scrollController) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: MarginManager.m10),
          width: DefualtValue.d30.w,
          height: DefualtValue.d4,
          decoration: BoxDecoration(
            color: ColorsManager.grey,
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(FontAwesomeIcons.xmark),
            ),
            const SizedBox(
              width: DefualtValue.d8,
            ),
            Text(
              language(context).appLang,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: PaddingManager.p16),
            controller: scrollController,
            itemBuilder: (context, i) {
              return itemRadioForLang(
                  cubit, context, cubit.listOfLanguage(context)[i]);
            },
            itemCount: cubit.listOfLanguage(context).length,
          ),
        ),
      ],
    ),
  );
}
