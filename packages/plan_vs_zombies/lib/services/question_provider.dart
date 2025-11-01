import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plan_vs_zombies/models/question.dart';

class QuestionProvider {
  static String? language;
  static int? hightestScore;
  static double scoreTotal = 0;
  static String? contentId;

  static Future<List<Question>> fetchQuestion(String? contentId, String? profileId) async {
    String url = '';
    if(contentId.toString() != 'null' && profileId.toString() != 'null'){
      url = 'https://api-core.futurekids.vn/api/contents/games/list?content_id=$contentId&profile_id=$profileId';
    } else {
      url = 'https://api-core.futurekids.vn/api/contents/games/list?content_id=$contentId';
    }

    final response = await http.get(Uri.parse(url));

    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Question> questionList = [];
      var json = jsonDecode(response.body);

      language = json['data']['language'];
      //language = 'en';
      hightestScore = int.parse(json['data']['highest_score'].toString());
      scoreTotal = double.parse(json['data']['total_point'].toString());

      for (var item in json['data']['contents']) {
        questionList.add(Question.fromJson(item));
      }
      return questionList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load question');
    }
  }

  static var listQuestion = [];

  static List<String> listLanguage = ["vi", "en"];
}
