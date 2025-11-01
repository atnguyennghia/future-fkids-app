class Question {
  //List<String> answers = [];
  int indexAnswerCorrect = 0;
  String questionName = "";
  List answerItem = [];
  String answerText = "";
  double point = 0;

  Question(
      {
      //required this.answerName,
      required this.point,
      required this.indexAnswerCorrect,
      required this.questionName});

  Question.fromJson(Map<String, dynamic> json) {
    //Map new
    answerItem = json['answer'] as List;

    indexAnswerCorrect = 0;

    //Text của đáp án đúng
    if (json['answer'][0]['type'] == 1) {
      answerText = answerItem[0]['answer'];
    }

    //Text của câu hỏi
    if (json['question'][0]['type'] == 1) {
      questionName = json['question'][0]['question'];
    }

    point = double.parse(json['point'].toString());
    //Image của câu hỏi
    //imageUrl = json['question'][1]['question'];
  }
}
