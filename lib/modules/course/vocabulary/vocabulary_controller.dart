// import 'dart:math';
import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/data/models/vocabulary_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/modules/course/course_controller.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';

class VocabularyController extends GetxController {
  CategoryModel category;
  VocabularyController({required this.category});

  final courseController = Get.find<CourseController>();

  final listVocabulary = <VocabularyModel>[].obs;

  void fetchVocabulary() async {
    final courseProvider = CourseProvider();
    final result = await courseProvider
        .getContent(
            courseId: courseController.course.courseId,
            categoryId: category.categoryId,
            categoryType: 6)
        .catchError((err) => Notify.error(err));

    if (result != null) {
      listVocabulary.value = result;
    }
  }

  // void onSpeak(int index) async {
  //   listVocabulary[index].isSpeaking = true;
  //   listVocabulary.refresh();

  //   if (listVocabulary[index].audio != null) {
  //     final player = AudioPlayer();
  //     await player.setUrl(listVocabulary[index].audio);
  //     await player.play();
  //     listVocabulary[index].isSpeaking = false;
  //     listVocabulary.refresh();
  //     await player.dispose();
  //     return;
  //   }

  //   final FlutterTts tts = FlutterTts();
  //   final kk = await tts.getVoices as List<dynamic>;
  //   final tt =
  //       kk.where((element) => element["locale"].toString() == 'en-GB').toList();
  //   tts.setLanguage('en-GB');
  //   if (tt.isNotEmpty) {
  //     Map<String, String> map =
  //         Map<String, String>.from(tt[Random().nextInt(tt.length)]);
  //     tts.setVoice(map);
  //   }
  //   tts.speak('${listVocabulary[index].word}').then((value) async {
  //     await Future.delayed(const Duration(seconds: 1));
  //     listVocabulary[index].isSpeaking = false;
  //     listVocabulary.refresh();
  //   });
  // }

  @override
  void onInit() async {
    fetchVocabulary();
    super.onInit();
  }
}
