import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whats_app/Domain/messageModel.dart';
import 'package:whats_app/Presentation/Resources/values_manager.dart';

class ViewImage extends StatelessWidget {
  ViewImage({super.key, required this.message});

  MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Center(
              child: Hero(
                tag: message.namePhoto,
                child: CachedNetworkImage(
                  imageUrl: message.message,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              top: DefualtValue.d14,
              left: DefualtValue.d10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(FontAwesomeIcons.angleLeft),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
