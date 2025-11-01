import 'package:futurekids/data/models/question_model.dart';
import 'package:get/get.dart';

class QuestionBookController extends GetxController {
  final listQuestionContent = <QuestionContentModel>[].obs;
  bool hasImage = false;

  QuestionBookController({required List<QuestionContentModel> listContent}) {
    listQuestionContent.value = listContent;
    for (var item in listContent) {
      if (item.question.toString().contains('<img')) {
        hasImage = true;
      }
    }
  }
}
