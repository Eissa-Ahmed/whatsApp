import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../Resources/colors_manager.dart';
import '../../../../Resources/values_manager.dart';
import '../../../ViewModel/home_cubit.dart';

FutureBuilder<DocumentSnapshot<Object?>> chooseImage(HomeCubit cubit) {
  return FutureBuilder<DocumentSnapshot>(
    future: cubit.users.get(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            cubit.imageProfile != null
                ? CircleAvatar(
                    radius: DefualtValue.d50,
                    backgroundImage: FileImage(cubit.imageProfile!),
                  )
                : data["image"] == ""
                    ? CircleAvatar(
                        radius: DefualtValue.d50,
                        child: IconButton(
                          alignment: Alignment.center,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            cubit.imageFormGallery();
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: DefualtValue.d50,
                            color: ColorsManager.greyDark,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: DefualtValue.d50,
                        backgroundImage: NetworkImage(data["image"]),
                      ),
            data["image"] == "" && cubit.imageProfile == null
                ? Container()
                : Positioned(
                    bottom: DefualtValue.d6,
                    left: DefualtValue.d8,
                    child: CircleAvatar(
                      backgroundColor: ColorsManager.celadonBlue,
                      radius: DefualtValue.d14,
                      child: IconButton(
                        alignment: Alignment.center,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          cubit.imageFormGallery();
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          size: DefualtValue.d14,
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                  ),
          ],
        );
      } else {
        return Container();
      }
    },
  );
}
