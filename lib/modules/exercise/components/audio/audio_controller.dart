import 'package:logger/logger.dart' show Level;
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:get/get.dart';

class AudioController extends GetxController {
  final FlutterSoundPlayer? _mPlayer =
      FlutterSoundPlayer(logLevel: Level.nothing);
  final isPlaying = false.obs;

  void play(String fromURI) async {
    isPlaying.value = true;
    await _mPlayer?.openPlayer();
    _mPlayer?.startPlayer(
        fromURI: fromURI,
        whenFinished: () {
          isPlaying.value = false;
        });
  }

  @override
  void onClose() {
    _mPlayer?.stopPlayer();
    _mPlayer?.closePlayer();
    super.onClose();
  }
}
