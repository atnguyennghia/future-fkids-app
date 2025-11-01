import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextTimer extends StatefulWidget {
  int index, durationSeconds;
  Function? callBackDuration, callBackStopTimer, callBackDisplayTime;
  String? seconds, minutes;
  bool? showTime;

  TextTimer({
    Key? key,
    required this.index,
    required this.durationSeconds,
    required this.callBackDuration,
    this.callBackDisplayTime,
    required this.showTime,
    this.seconds,
    this.minutes,
    this.callBackStopTimer,
  }) : super(key: key);

  @override
  State<TextTimer> createState() => _TextTimer();
}

class _TextTimer extends State<TextTimer> {
  Duration duration = const Duration();
  Timer? timer;
  bool? showTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.callBackStopTimer = stopTimer;
    widget.callBackDisplayTime = displayTime;
    showTime = widget.showTime;

    if (widget.index == 0) {
      startTimer();
    } else {
      startTimer(false);
    }
    //addTime();
  }

  void reset() {
    setState(() => duration = const Duration());
  }

  void displayTime(bool value) {
    setState(() {
      showTime = value;
    });
  }

  void stopTimer([bool resets = true]) {
    widget.minutes = twoDigits(duration.inMinutes.remainder(60));
    widget.seconds = twoDigits(duration.inSeconds.remainder(60));

    if (resets) {
      reset();
    }
    setState(() {
      timer?.cancel();
    });
  }

  void addTime() {
    const addSecond = 1;
    setState(() {
      final seconds = widget.durationSeconds + duration.inSeconds + addSecond;
      duration = Duration(seconds: seconds);
    });

    //reset số giây sau khi đã cộng dồn
    widget.durationSeconds = 0;
    widget.callBackDuration!(duration.inSeconds);
  }

  void startTimer([bool resets = true]) {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) => addTime());
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return showTime!
        ? Padding(
            padding: EdgeInsets.only(left: 481.w + 25.w, top: 57.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '$minutes:$seconds',
                style: TextStyle(
                  fontSize: 53.sp,
                  fontFamily: 'packages/plan_vs_zombies/Mali',
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                  shadows: const [
                    Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 2.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
