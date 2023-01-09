import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

import '../../../ViewModel/home_cubit.dart';

Offstage keyBoardEmoji(HomeCubit cubit, TextEditingController controller) {
  return Offstage(
    offstage: !cubit.showEmoji,
    child: SizedBox(
      height: 250,
      child: EmojiPicker(
        onEmojiSelected: (Category? category, Emoji emoji) {},
        onBackspacePressed: () {
          // Do something when the user taps the backspace button (optional)
        },
        textEditingController: controller,
        config: Config(
          columns: 7,
          emojiSizeMax: 32 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.30
                  : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: Category.RECENT,
          bgColor: const Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          noRecents: const Text(
            'No Recents',
            style: TextStyle(fontSize: 20, color: Colors.black26),
            textAlign: TextAlign.center,
          ), // Needs to be const Widget
          loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL,
        ),
      ),
    ),
  );
}
