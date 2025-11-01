@JS()
library callable_function;

import 'package:futurekids/modules/game/game_controller.dart';
import 'package:get/get.dart';
import 'package:js/js.dart';

/// Allows assigning a function to be callable from `window.functionName()`
@JS('exitGame')
external set _exitGame(
    void Function(dynamic exit, dynamic score, dynamic isStudyCompleted) f);

void _exitGameDart(dynamic exit, dynamic score, dynamic isStudyCompleted) {
  final _controller = Get.find<GameController>();

  if (exit) {
    _controller.exitGame(isStudyCompleted);
  } else {
    score = double.tryParse(score) ?? 0.0;

    if (score > 0) {
      _controller.submitData(score);
    }
  }
}

void callableFunction() {
  _exitGame = allowInterop(_exitGameDart);
}
