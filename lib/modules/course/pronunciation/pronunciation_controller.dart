// import 'dart:math';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/data/models/vocabulary_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/modules/course/course_controller.dart';
import 'package:futurekids/utils/notify.dart';
// import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';

class PronunciationController extends GetxController {
  CategoryModel category;
  PronunciationController({required this.category});

  final courseController = Get.find<CourseController>();

  final listVocabulary = <VocabularyModel>[].obs;

  void fetchVocabulary() async {
    final courseProvider = CourseProvider();
    final result = await courseProvider
        .getContent(
            courseId: courseController.course.courseId,
            categoryId: category.categoryId,
            categoryType: 7)
        .catchError((err) => Notify.error(err));

    if (result != null) {
      listVocabulary.value = result;
    }
  }

  void onSpeak(int index) async {
    // listVocabulary[index].isSpeaking = true;
    // listVocabulary.refresh();

    // if (listVocabulary[index].audio != null) {
    //   final player = AudioPlayer();
    //   await player.setUrl(listVocabulary[index].audio);
    //   await player.play();
    //   listVocabulary[index].isSpeaking = false;
    //   listVocabulary.refresh();
    //   await player.dispose();
    //   return;
    // }

    // final FlutterTts tts = FlutterTts();
    // final kk = await tts.getVoices as List<dynamic>;
    // final tt =
    //     kk.where((element) => element["locale"].toString() == 'en-GB').toList();
    // tts.setLanguage('en-GB');
    // if (tt.isNotEmpty) {
    //   Map<String, String> map =
    //       Map<String, String>.from(tt[Random().nextInt(tt.length)]);
    //   tts.setVoice(map);
    // }
    // tts.speak('${listVocabulary[index].word}').then((value) async {
    //   await Future.delayed(const Duration(seconds: 1));
    //   listVocabulary[index].isSpeaking = false;
    //   listVocabulary.refresh();
    // });
  }

  void onRecord(int index) async {
    listVocabulary[index].isRecording = true;
    listVocabulary.refresh();

    stt.SpeechToText speech = stt.SpeechToText();
    bool available = await speech.initialize(
        onError: (err) => speech.stop().then((value) {
              listVocabulary[index].isRecording = false;
              listVocabulary.refresh();
            }));
    if (available) {
      // final kk = await speech.locales();
      // for (var tt in kk) {
      //   print(tt.name + ' ' + tt.localeId);
      // }

      // SpeechToTextProvider abc = SpeechToTextProvider(speech);
      // abc.

      speech.listen(
          localeId: 'vi-VN',
          onResult: (result) {
            print(result.recognizedWords);
          });

      await Future.delayed(const Duration(seconds: 5));
      speech.stop().then((value) {
        listVocabulary[index].isRecording = false;
        listVocabulary.refresh();
      });
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  @override
  void onInit() {
    fetchVocabulary();
    super.onInit();
  }
}
