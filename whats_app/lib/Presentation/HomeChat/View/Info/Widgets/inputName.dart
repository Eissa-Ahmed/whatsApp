import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../Resources/colors_manager.dart';
import '../../../../Resources/values_manager.dart';
import '../../../ViewModel/home_cubit.dart';

Expanded inputName(HomeCubit cubit) {
  return Expanded(
    child: FutureBuilder<DocumentSnapshot>(
      future: cubit.users.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return TextFormField(
            onTap: () => cubit.colseEmoji(),
            focusNode: cubit.focusNode,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
            cursorColor: ColorsManager.primaryColorLight,
            textDirection: TextDirection.ltr,
            autofocus: true,
            keyboardType: TextInputType.name,
            controller: cubit.nameController,
            decoration: InputDecoration(
              hintText: "${data["name"]} ",
              contentPadding: const EdgeInsets.all(PaddingManager.p12),
            ),
          );
        } else {
          return Container();
        }
      },
    ),
  );
}
