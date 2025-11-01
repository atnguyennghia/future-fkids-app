import 'package:futurekids/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class AnswerExplain extends StatelessWidget {
  final bool isCorrect;
  final int? correctAnswer;
  final dynamic explain;
  final Widget? content;

  const AnswerExplain({
    Key? key,
    required this.isCorrect,
    this.correctAnswer,
    this.explain,
    this.content,
  }) : super(key: key);

  String getCharacter(int? number) {
    switch (number) {
      case 0:
        return 'A';
      case 1:
        return 'B';
      case 2:
        return 'C';
      case 3:
        return 'D';
      case 4:
        return 'E';
      case 5:
        return 'F';
      case 6:
        return 'G';
      case 7:
        return 'H';
      case 8:
        return 'I';
      case 9:
        return 'J';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 16),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: isCorrect
                        ? const Color(0xff22f02a)
                        : const Color(0xffec1c24),
                    width: 3),
                color: Colors.white),
            child: content ??
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    correctAnswer != null
                        ? Text(
                            'Đáp án đúng là ${getCharacter(correctAnswer)}',
                            style: CustomTheme.semiBold(16),
                          )
                        : const SizedBox(),
                    Text(
                      'Giải thích:',
                      style: CustomTheme.semiBold(16),
                    ),
                    HtmlWidget(explain ?? '',
                        textStyle: CustomTheme.semiBold(16),
                        customWidgetBuilder: (element) {
                      if (element.localName == 'img') {
                        return Container(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              element.attributes['src']!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      }

                      return null;
                    })
                  ],
                ),
          ),
          Positioned(
              top: -16,
              child: Container(
                width: 206,
                height: 38,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(isCorrect
                        ? 'assets/backgrounds/explain_correct_title.png'
                        : 'assets/backgrounds/explain_incorrect_title.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Đáp án',
                    style: CustomTheme.semiBold(18),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
