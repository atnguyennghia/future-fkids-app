import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';

class ScoreStar extends StatelessWidget {
  final int totalPoint;
  final int point;
  final double? width;
  final double? height;
  final bool showScore;

  const ScoreStar(
      {Key? key,
      required this.totalPoint,
      required this.point,
      this.width = 42,
      this.height = 42,
      this.showScore = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/backgrounds/star_border.png'),
                  fit: BoxFit.fill)),
          child: ClipPath(
            clipper: PercentClipper(percentPoint: point / totalPoint),
            child: Image.asset('assets/backgrounds/star_color.png'),
          ),
        ),
        Positioned.fill(
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/backgrounds/star_mask.png',
                ),
              ),
            )),
        Positioned(
            bottom: height! / 3.2,
            child: showScore
                ? StrokeText(
                    text: '$point',
                    fontSize: height! / 4.2,
                    borderColor: const Color(0xFF074675),
                    color: Colors.white,
                  )
                : const SizedBox())
      ],
    );
  }
}

class PercentClipper extends CustomClipper<Path> {
  double percentPoint;

  PercentClipper({required this.percentPoint});
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0.0, size.height * (1 - percentPoint));
    path.lineTo(size.width, size.height * (1 - percentPoint));
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(PercentClipper oldClipper) => false;
}
