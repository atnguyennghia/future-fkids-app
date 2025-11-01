class QuestionModel {
  dynamic contentId;
  dynamic title;
  List<QuestionContentModel> question = [];
  List<AnswerModel> answer = [];
  List<QuestionModel> childs = [];
  dynamic type;
  double point = 0.0;
  dynamic questionType;
  dynamic answerType;
  int? correctAnswer;
  dynamic explainAnswer;
  int? selectedAnswerIndex;
  int status = 0;

  dynamic selectedAnswer;
  bool? isCorrectSelected;

  QuestionModel();

  QuestionModel.fromJson(Map<String, dynamic> json) {
    contentId = json['content_id'];
    title = json['title'];

    if (json['question'] != null) {
      question = json['question']
          .map<QuestionContentModel>((e) => QuestionContentModel.fromJson(e))
          .toList();
    }

    if (json['answer'] != null) {
      int i = 0;
      for (var item in json['answer']) {
        if (item["is_correct"] == 1) {
          correctAnswer = i;
          // explainAnswer = item["explain"];
        }
        answer.add(AnswerModel.fromJson(item));
        i++;
      }
    }

    explainAnswer = json["text_explain"];

    type = json['type'].toString();
    point = double.tryParse(json['point'].toString()) ?? 0.0;
    questionType = json['question_type'].toString();
    answerType = json['answer_type'].toString();

    if (json['childs'] != null) {
      childs = json['childs']
          .map<QuestionModel>((e) => QuestionModel.fromJson(e))
          .toList();
    }
  }
}

class QuestionContentModel {
  dynamic type;
  dynamic question;

  QuestionContentModel();

  QuestionContentModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    question = json['question'];
  }
}

class AnswerModel {
  dynamic type;
  dynamic answer;
  dynamic isCorrect;
  dynamic explain;
  dynamic unit;
  dynamic before;

  AnswerModel();

  AnswerModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    answer = json['answer'].toString();
    isCorrect = json['is_correct'];
    explain = json['explain'];
    unit = json['unit'];
    before = json['before'];
  }
}
