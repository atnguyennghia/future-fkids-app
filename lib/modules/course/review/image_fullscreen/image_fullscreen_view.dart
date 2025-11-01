import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'image_fullscreen_controller.dart';

class ImageFullscreenView extends StatelessWidget {
  final String imageUrl;
  final controller = Get.put(ImageFullscreenController());

  ImageFullscreenView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                ]).then((value) => Get.back());
              },
              icon: Image.asset('assets/icons/button_back_ex.png'),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                  radius: 0.94,
                  stops: [0.0, 1.0],
                  colors: [Color(0xFF1F4F4C), Color(0xFF0D2942)]),
            ),
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(imageUrl),
              minScale: PhotoViewComputedScale.contained * 0.5,
              maxScale: PhotoViewComputedScale.covered * 4.0,
              initialScale: PhotoViewComputedScale.contained,
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        onWillPop: () async {
          await SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]).then((value) => Get.back());
          return true;
        });
  }
}
