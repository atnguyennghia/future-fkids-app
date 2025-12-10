import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'image_fullscreen_controller.dart';

class ImageFullscreenView extends StatefulWidget {
  final String imageUrl;
  final controller = Get.put(ImageFullscreenController());

  ImageFullscreenView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<ImageFullscreenView> createState() => _ImageFullscreenViewState();
}

class _ImageFullscreenViewState extends State<ImageFullscreenView> {
  ImageProvider? _imageProvider;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    debugPrint('ImageFullscreenView - Loading image: ${widget.imageUrl}');
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      // Try NetworkImage first with headers
      final networkImage = NetworkImage(
        widget.imageUrl,
        headers: {
          'User-Agent': 'Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36',
          'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
        },
      );
      
      // Resolve the image to check if it loads
      await networkImage.resolve(ImageConfiguration.empty);
      
      if (mounted) {
        setState(() {
          _imageProvider = networkImage;
          _isLoading = false;
        });
        debugPrint('ImageFullscreenView - NetworkImage loaded successfully');
      }
    } catch (e) {
      debugPrint('ImageFullscreenView - NetworkImage failed: $e');
      // Fallback to CachedNetworkImageProvider
      try {
        final cachedProvider = CachedNetworkImageProvider(widget.imageUrl);
        await cachedProvider.resolve(ImageConfiguration.empty);
        if (mounted) {
          setState(() {
            _imageProvider = cachedProvider;
            _isLoading = false;
          });
          debugPrint('ImageFullscreenView - CachedNetworkImageProvider loaded successfully');
        }
      } catch (e2) {
        debugPrint('ImageFullscreenView - CachedNetworkImageProvider also failed: $e2');
        if (mounted) {
          setState(() {
            _error = e2.toString();
            _isLoading = false;
          });
        }
      }
    }
  }

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
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : _error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error, color: Colors.white, size: 48),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                'Không thể tải hình ảnh',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )
                    : _imageProvider != null
                        ? PhotoView(
                            imageProvider: _imageProvider!,
                            minScale: PhotoViewComputedScale.contained * 0.5,
                            maxScale: PhotoViewComputedScale.covered * 4.0,
                            initialScale: PhotoViewComputedScale.contained,
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            loadingBuilder: (context, event) {
                              if (event == null) {
                                return const SizedBox();
                              }
                              final progress = event.cumulativeBytesLoaded / event.expectedTotalBytes!;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: progress,
                                  color: Colors.white,
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
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
