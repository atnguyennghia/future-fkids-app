import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';

class SpeakingResult extends StatelessWidget {
  final int percent;
  const SpeakingResult({Key? key, required this.percent}) : super(key: key);

  Widget getMessage() {
    if (percent <= 30) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/fubo_status_30.png',
            width: 53.55,
            height: 52.63,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Chưa đúng rồi',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFFF22845)),
              ),
              SizedBox(
                height: 4,
              ),
              Text('Hãy thử lại nhé!',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Colors.black))
            ],
          ))
        ],
      );
    }
    if (percent <= 50) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/fubo_status_50.png',
            width: 53.55,
            height: 52.63,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Gần đúng rồi, cố lên nào !',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFFFF9900)),
              ),
              SizedBox(
                height: 4,
              ),
              Text('Bạn đạt được 45% so với kết quả',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Colors.black))
            ],
          ))
        ],
      );
    }
    if (percent <= 70) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/fubo_status_70.png',
            width: 53.55,
            height: 52.63,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Tốt đấy, cố lên nào !',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF86C256)),
              ),
              SizedBox(
                height: 4,
              ),
              Text('Bạn đạt được 60% so với kết quả',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Colors.black))
            ],
          ))
        ],
      );
    }
    if (percent <= 90) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/fubo_status_90.png',
            width: 53.55,
            height: 52.63,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Cố gắng thêm một chút nữa nào !',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF04BC8A)),
              ),
              SizedBox(
                height: 4,
              ),
              Text('Bạn đạt được 75% so với kết quả',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Colors.black))
            ],
          ))
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/fubo_status_100.png',
          width: 53.55,
          height: 52.63,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Quá tuyệt vời !',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xFF04BC8A)),
            ),
            SizedBox(
              height: 4,
            ),
            Text('Chúc mừng bạn đã đạt được kết quả tối đa!',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.black))
          ],
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: BoxBorderGradient(
        padding: const EdgeInsets.all(4),
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withOpacity(0.5),
        child: getMessage(),
      ),
    );
  }
}
