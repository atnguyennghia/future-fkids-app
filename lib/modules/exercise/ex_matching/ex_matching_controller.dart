import 'package:futurekids/modules/exercise/components/audio/audio_view.dart';
import 'package:futurekids/modules/exercise/exercise_controller.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../data/models/question_model.dart';
import '../../../utils/loading_dialog.dart';
import 'widgets/dialog_answer.dart';

class ExMatchingController extends GetxController {
  final exController = Get.find<ExerciseController>();
  final isCompleted = false.obs; //Chưa trả lời hết tất cả câu hỏi
  final isAnswered = false.obs; //Chưa bấm kiểm tra câu trả lời

  final listQuestions = <QuestionModel>[].obs;
  final listAnswers = <QuestionModel>[].obs;
  final title = ''.obs;

  final scrollController = ItemScrollController();

  double point = 0.0;
  int numberOfCorrect = 0;

  void checkCompleted() {
    point = 0.0;
    numberOfCorrect = 0;

    for (var item in exController.listQuestion) {
      if (item.isCorrectSelected ?? false) {
        numberOfCorrect += 1;
        point += item.point;
      }
    }

    isCompleted.value = listAnswers.isEmpty;
  }

  void submitData() {
    if (isAnswered.value) {
      exController.submitData(point: point, numberOfCorrect: numberOfCorrect);
      return;
    }
  }

  void checkCorrect() {
    if (isCompleted.value) {
      isAnswered.value = true;

      scrollController.jumpTo(index: 2);
    }
  }

  void onSelectAnswer(int questionIndex, LoadingDialog dialog, int index) {
    final temp = listQuestions[questionIndex].selectedAnswer;

    listQuestions[questionIndex].selectedAnswer = listAnswers[index];
    listQuestions[questionIndex].isCorrectSelected =
        listQuestions[questionIndex].answer.first.answer ==
            listAnswers[index].answer.first.answer;

    listQuestions.refresh();
    listAnswers.removeAt(index);

    if (temp != null) {
      listAnswers.insert(index, temp);
    }

    dialog.dismiss();
    checkCompleted();
  }

  void onRemoveAnswer({required int questionIndex}) {
    final temp = listQuestions[questionIndex].selectedAnswer;
    if (temp != null) {
      listQuestions[questionIndex].selectedAnswer = null;
      listQuestions[questionIndex].isCorrectSelected = false;
      isCompleted.value = false;
      listAnswers.add(temp);
      listQuestions.refresh();
    }
  }

  ///Câu trả lời là chữ
  void onSelectAnswer1({required int questionIndex}) {
    if (isAnswered.value) {
      return;
    }
    final dialog = LoadingDialog();
    dialog.custom(
        loadingWidget: DialogAnswer(
            close: () => dialog.dismiss(),
            content: Container(
              constraints: const BoxConstraints(maxWidth: kWidthMobile),
              child: ListView.separated(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 32, bottom: 16),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Stack(
                        children: [
                          BoxBorderGradient(
                            borderRadius: BorderRadius.circular(24),
                            gradientType: GradientType.accentGradient,
                            borderSize: 3,
                            child: InkWell(
                              onTap: () =>
                                  onSelectAnswer(questionIndex, dialog, index),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(21)),
                                constraints:
                                    const BoxConstraints(minHeight: 55),
                                padding: const EdgeInsets.only(
                                    left: 60, top: 16, bottom: 16, right: 16),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${listAnswers[index].answer.first.answer}',
                                    style: CustomTheme.semiBold(16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Image.asset(
                                'assets/icons/character_$index.png',
                                width: 32),
                          ),
                        ],
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                  itemCount: listAnswers.length),
            )));
  }

  ///Câu trả lời là ảnh/audio
  void onSelectAnswer2({required int questionIndex}) {
    if (isAnswered.value) {
      return;
    }
    final dialog = LoadingDialog();
    dialog.custom(
        loadingWidget: DialogAnswer(
            close: () => dialog.dismiss(),
            content: Container(
              constraints: const BoxConstraints(maxWidth: kWidthMobile),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: listAnswers.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemBuilder: (context, index) => Center(
                        child: InkWell(
                          onTap: () =>
                              onSelectAnswer(questionIndex, dialog, index),
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: listQuestions[questionIndex].answerType ==
                                    "2"
                                ? Image.network(
                                    listAnswers[index].answer.first.answer,
                                    width: 120,
                                  )
                                : AudioView(
                                    fromURI:
                                        listAnswers[index].answer.first.answer,
                                    tag:
                                        'answer_${listQuestions[questionIndex].contentId}_$index',
                                  ),
                          ),
                        ),
                      )),
            )));
  }

  @override
  void onInit() {
    listQuestions.value = exController.listQuestion;
    super.onInit();
  }

  @override
  void onReady() {
    listAnswers.value = List.from(exController.listQuestion);
    listAnswers.shuffle();
    title.value = listQuestions.first.title ?? 'Hãy chọn đáp án đúng';
    super.onReady();
  }
}
