import 'package:flutter/material.dart';

import '../../../../Resources/constants.dart';

Future<int?> helpMenu(BuildContext context) {
  return showMenu(
    context: context,
    position: RelativeRect.fill,
    items: [
      PopupMenuItem<int>(
          value: 0,
          child: Text(
            language(context).help,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: () {}),
    ],
  );
}
