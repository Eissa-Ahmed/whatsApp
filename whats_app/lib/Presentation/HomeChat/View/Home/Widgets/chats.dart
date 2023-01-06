import 'package:flutter/material.dart';
import 'package:whats_app/Domain/itemChatModel.dart';
import 'package:whats_app/Presentation/Resources/colors_manager.dart';
import 'package:whats_app/Presentation/Resources/fonts_manager.dart';
import 'package:whats_app/Presentation/Resources/routes_manager.dart';
import 'package:whats_app/Presentation/Resources/values_manager.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.message_sharp),
      ),
      body: Column(
        children: [
          itemUserChat(
            context,
            ItemChatModel(
              date: "2023/22/4",
              image:
                  "https://firebasestorage.googleapis.com/v0/b/whats-app-713e4.appspot.com/o/BIJkKk20kWTTWQD5TulyGfrb0783%2Fprofile?alt=media&token=9cb797e2-23e1-4743-a2b3-b82cb02b6e65",
              isActive: false,
              lastMessage:
                  "Hello Essa , How Are You Hello Essa , How Are You Hello Essa , How Are You",
              name: "Essa Ahmed",
            ),
          ),
          itemUserChat(
            context,
            ItemChatModel(
              date: "2023/12/4",
              image:
                  "https://firebasestorage.googleapis.com/v0/b/whats-app-713e4.appspot.com/o/profile.png?alt=media&token=b25029c5-93ad-4c7a-b835-f40a91cb5cd2",
              isActive: true,
              lastMessage:
                  "Hello Mohamed , How Are You Hello Mohamed , How Are You Hello Mohamed , How Are You",
              name: "Mohamed Ahmed",
            ),
          ),
        ],
      ),
    );
  }

  InkWell itemUserChat(BuildContext context, ItemChatModel itemChatModel) {
    return InkWell(
      onTap: () async {
        await Navigator.of(context).pushNamed(
          Pages.singleChat,
          arguments: itemChatModel,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(PaddingManager.p8),
        margin: const EdgeInsets.symmetric(
            horizontal: MarginManager.m10, vertical: MarginManager.m4),
        child: Row(
          children: [
            CircleAvatar(
              radius: DefualtValue.d28,
              backgroundImage: NetworkImage(itemChatModel.image),
            ),
            const SizedBox(
              width: DefualtValue.d10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemChatModel.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    itemChatModel.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ColorsManager.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: DefualtValue.d25,
            ),
            itemChatModel.isActive
                ? const CircleAvatar(
                    radius: DefualtValue.d4,
                    backgroundColor: Colors.green,
                  )
                : Text(
                    itemChatModel.date,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorsManager.grey,
                          fontSize: FontSizeManager.fs_10,
                        ),
                  ),
          ],
        ),
      ),
    );
  }
}
