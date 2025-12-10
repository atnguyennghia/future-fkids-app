import 'package:cached_network_image/cached_network_image.dart';
import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/modules/course/review/audio-playback/audio_playback_view.dart';
import 'package:futurekids/modules/course/review/image_fullscreen/image_fullscreen_view.dart';
import 'package:futurekids/modules/exercise/components/video/video_view.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import 'review_controller.dart';

class ReviewView extends StatelessWidget {
  late final ReviewController controller;

  ReviewView({Key? key, required CategoryModel category}) : super(key: key) {
    controller = Get.put(ReviewController(category: category),
        tag: category.categoryId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() => controller.listReview.isEmpty
          ? Center(
              child: Text(
                'Không có nội dung',
                style: CustomTheme.semiBold(20),
              ),
            )
          : ListView(
              primary: false,
              padding: EdgeInsets.only(
                  top: context.responsive(mobile: 40, desktop: 56),
                  left: 16,
                  right: 16),
              children: [
                Align(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 585),
                    child: _boxImage(context),
                  ),
                ),
                Align(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 914),
                    child: HtmlWidget(
                      controller.listReview.first["content"] ?? '',
                      textStyle: CustomTheme.semiBold(16),
                    ),
                  ),
                ),
                controller.courseController.lesson.cardLevel == 2
                    ? Column(
                        children: [
                          _boxUpload(),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 914),
                            child: _boxComment(),
                          )
                        ],
                      )
                    : const SizedBox(),
              ],
            )),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
              minimum: const EdgeInsets.all(16),
              child: Obx(() => controller.listReview.isEmpty
                  ? const SizedBox()
                  : KButton(
                      onTap: () => controller.submitData(),
                      title: 'Kết thúc bài học',
                      style: CustomTheme.semiBold(16)
                          .copyWith(color: Colors.white),
                      width: 300,
                    )))
        ],
      ),
    );
  }

  Widget _boxImage(BuildContext context) {
    final rawImageUrl = controller.listReview.first["image"]?.toString() ?? '';
    final imageUrl = rawImageUrl.trim();
    
    debugPrint('Image URL (raw): $rawImageUrl');
    debugPrint('Image URL (trimmed): $imageUrl');
    
    if (imageUrl.isEmpty) {
      return const SizedBox();
    }
    
    // Validate URL format
    if (!imageUrl.startsWith('http://') && !imageUrl.startsWith('https://')) {
      debugPrint('Invalid URL format: $imageUrl');
      return const SizedBox();
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
          ]).then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImageFullscreenView(
                      imageUrl: imageUrl))));
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              gradient: const RadialGradient(
                  radius: 0.94,
                  stops: [0.0, 1.0],
                  colors: [Color(0xFF1F4F4C), Color(0xFF0D2942)]),
              borderRadius: BorderRadius.circular(6),
              border:
                  Border.all(width: 2, color: const Color(0xFFFEEFE7))),
          child: AspectRatio(
            aspectRatio: 320 / 164,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                headers: {
                  'User-Agent': 'Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36',
                  'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    debugPrint('Image loaded successfully: $imageUrl');
                    return child;
                  }
                  final progress = loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null;
                  if (progress != null) {
                    debugPrint('Image loading: ${(progress * 100).toStringAsFixed(1)}% - $imageUrl');
                  }
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: progress,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Image.network error: $error');
                  debugPrint('Error type: ${error.runtimeType}');
                  debugPrint('Stack trace: $stackTrace');
                  debugPrint('Failed URL: $imageUrl');
                  // Try CachedNetworkImage as fallback
                  return CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) {
                      debugPrint('CachedNetworkImage also failed: $error');
                      return Container(
                        color: Colors.grey[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error, color: Colors.red),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Không thể tải hình ảnh',
                                style: CustomTheme.medium(12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _boxUpload() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      constraints: const BoxConstraints(maxWidth: 585),
      child: Obx(() => controller.linkVideoOfUser.value.isNotEmpty
          ? AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoView(
                  videoUrl: controller.linkVideoOfUser.value,
                  tag: 'review_${controller.category.categoryId}_user'),
            )
          : InkWell(
              onTap: () => controller.pickUpVideo(),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                height: 169,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: const Color(0xFF049FF9), width: 3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/upload.png',
                      width: 28,
                      height: 30,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        'Tải video',
                        style: CustomTheme.semiBold(20)
                            .copyWith(color: const Color(0xFF049FF9)),
                      ),
                    )
                  ],
                ),
              ),
            )),
    );
  }

  Widget _boxComment() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Nhận xét của giáo viên',
            style: CustomTheme.semiBold(18),
          ),
        ),
        Row(
          children: [
            Container(
              width: 194,
              height: 0.8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.4),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Visibility(
                visible: controller.listComment.isNotEmpty,
                child: BoxBorderGradient(
                  width: 40,
                  height: 40,
                  boxShape: BoxShape.circle,
                  borderSize: 1,
                  child: CircleAvatar(
                    backgroundImage: controller.avatar.value.isEmpty
                        ? null
                        : NetworkImage(controller.avatar.value),
                  ),
                ))),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Obx(() => ListView.separated(
                    primary: false,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final _model = controller.listComment[index];

                      ///comment text
                      if (_model['type'] == '1') {
                        return _commmentText(model: _model);
                      }

                      ///comment audio
                      if (_model['type'] == '2') {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            constraints:
                                const BoxConstraints(maxWidth: kWidthMobile),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: AudioPlaybackView(
                                url: _model['comment'],
                                tag:
                                    '${controller.category.categoryId}_#$index'),
                          ),
                        );
                      }

                      ///comment image
                      if (_model['type'] == '3') {
                        return AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: Image.network(_model['comment']),
                          ),
                        );
                      }

                      ///comment video
                      if (_model['type'] == '4') {
                        return VideoView(
                          videoUrl: _model['comment'],
                          tag:
                              'review_${controller.category.categoryId}_#$index',
                        );
                      }

                      return const SizedBox();
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: controller.listComment.length)))
          ],
        ),
      ],
    );
  }

  Widget _commmentText({required dynamic model}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['name']}',
                style: CustomTheme.semiBold(16),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '${model['comment']}',
                style: CustomTheme.medium(16),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        )
      ],
    );
  }
}
