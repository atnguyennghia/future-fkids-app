import 'dart:async';

import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/modules/exercise/ex_other/ex_other_controller.dart';
import 'package:futurekids/modules/unit/unit_controller.dart';
import 'package:futurekids/services/stt_service.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:futurekids/utils/number_to_words_english.dart';
import 'package:futurekids/utils/number_to_words_vietnamese.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:speech_to_text/speech_recognition_event.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:logger/logger.dart' show Level;

class SpeakingController extends GetxController {
  final FlutterSoundRecorder? _mRecorder =
      FlutterSoundRecorder(logLevel: Level.nothing);
  final scrollController = ItemScrollController();
  final unitController = Get.find<UnitController>();
  final exOtherController = Get.find<ExOtherController>();
  final QuestionModel model;
  final isSpeaking = false.obs;
  final isCompleted = false.obs;

  StreamSubscription<SpeechRecognitionEvent>? _subscription;

  String audioQuestionPath = '';

  final mPath = 'sound';

  List<String> listRecognize = [];
  List<String> listAnswer = [];
  List<String> listDisplay = [];
  int percentComplete = 0;
  double totalPoint = 0.0;
  int point = 0;

  SpeakingController({required this.model}) {
    model.answer.first.answer = model.answer.first.answer.toString().trim();

    /// Xu ly hien thi cau hoi type = 3
    if (model.answer.first.answer.toString().startsWith('{') &&
        model.answer.first.answer.toString().endsWith('}')) {
      listAnswer = model.answer.first.answer
          .toString()
          .replaceFirst('{', '')
          .replaceFirst('}', '')
          .split(' ');
    } else {
      listAnswer = model.answer.first.answer.toString().split(' ');
    }

    ///Xu ly hien thi cau hoi type = 2
    for (int i = 0; i < listAnswer.length; i++) {
      if (listAnswer[i].startsWith('{') && listAnswer[i].endsWith('}')) {
        listAnswer[i] = listAnswer[i].replaceAll('{', '').replaceAll('}', '');
        listDisplay.add('...');
      } else {
        listDisplay.add(listAnswer[i]);
      }
    }

    totalPoint = model.point;

    ///tach audio question
    for (int i = 0; i < model.question.length; i++) {
      if (model.question[i].type == '2') {
        audioQuestionPath = model.question[i].question;
        model.question.removeAt(i);
        i--;
      }
    }
  }

  int getTypeAnswerDisplay() {
    if (model.answer.first.answer.toString().startsWith('{') &&
        model.answer.first.answer.toString().endsWith('}')) {
      return 3;
    }
    if (model.answer.first.answer.toString().contains('{') &&
        model.answer.first.answer.toString().contains('}')) {
      return 2;
    }
    return 1;
  }

  void record() async {
    await _mRecorder?.openRecorder();
    await _mRecorder?.startRecorder(toFile: mPath);
  }

  void onSpeaking() async {
    if (STTService.to.speechProvider?.isListening ?? false) {
      STTService.to.speechProvider?.stop();
    } else {
      point = 0;
      percentComplete = 0;

      bool available = await STTService.to.initialize();

      if (available) {
        if (!GetPlatform.isAndroid) record();

        String recognizeWords = '';

        listRecognize = [];

        STTService.to.speechProvider?.listen(
          listenFor: const Duration(seconds: 15),
          localeId:
              unitController.book.value.subjectId == 3 ? 'en-GB' : 'vi-VN',
        );

        await _subscription?.cancel();

        _subscription = STTService.to.speechProvider?.stream.listen(
          (event) async {
            if (event.eventType ==
                SpeechRecognitionEventType.partialRecognitionEvent) {
              recognizeWords =
                  STTService.to.speechProvider!.lastResult!.recognizedWords;
              _checkValid(recognizeWords);
            } else if (event.eventType ==
                SpeechRecognitionEventType.doneEvent) {
              await _mRecorder?.stopRecorder();
            }

            isSpeaking.value = event.isListening ?? false;
            isCompleted.value = !isSpeaking.value;
          },
        );
      } else {
        Notify.error("The user has denied the use of speech recognition.");
      }
    }
  }

  void _checkValid(String recognizeWords) async {
    ///thay thế ký tự dặc biệt nếu là Toán/Tiếng Việt
    if (unitController.book.value.subjectId != 3) {
      recognizeWords = recognizeWords.replaceAll('/', ' phần ');
      recognizeWords = recognizeWords.replaceAll(',', ' phẩy ');
    }

    ///Chuyển đổi số thành chữ
    listRecognize = recognizeWords.split(' ');
    recognizeWords = '';
    for (var item in listRecognize) {
      if (item.isNum) {
        unitController.book.value.subjectId == 3
            ? recognizeWords += ' ' +
                NumberToWordsEnglish.convert(NumberFormat().parse(item).toInt())
            : recognizeWords += ' ' +
                NumberToWordsVietnamese.convert(
                    NumberFormat.decimalPattern('vi').parse(item).toInt());
      } else {
        recognizeWords += ' ' + item;
      }
    }

    listRecognize = recognizeWords.trim().split(' ');

    ///tính toán tỷ lệ chính xác
    double totalPercent = 0.0;
    double wordPercent = 100 / listAnswer.length;
    for (int i = 0; i < listAnswer.length; i++) {
      try {
        final listCharAnswer = listAnswer[i].split('');
        final listCharRecognize = listRecognize[i].split('');
        for (int j = 0; j < listCharAnswer.length; j++) {
          try {
            if (listCharAnswer[j].toLowerCase() ==
                listCharRecognize[j].toLowerCase()) {
              totalPercent += wordPercent / listCharAnswer.length;
            }
          } catch (_) {}
        }
      } catch (_) {}
    }
    percentComplete = totalPercent.round();

    point = (totalPoint * percentComplete / 100).round();

    if (percentComplete == 100) {
      STTService.to.speechProvider?.stop();
      await _mRecorder?.stopRecorder();
    }
  }

  void onNext() async {
    await _subscription?.cancel();

    ///Cập nhật điểm và câu trả lời đúng
    exOtherController.numberOfCorrect += 1;
    exOtherController.point += point;

    exOtherController.onNext();
  }

  @override
  void onClose() async {
    await _mRecorder?.closeRecorder();
    await _subscription?.cancel();
    super.onClose();
  }
}
