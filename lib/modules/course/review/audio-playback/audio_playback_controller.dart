import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart' show Level;

class AudioPlaybackController extends GetxController {
  final String url;

  final FlutterSoundPlayer? _mPlayer =
      FlutterSoundPlayer(logLevel: Level.nothing);

  final position = const Duration(seconds: 0).obs;
  final isPlaying = false.obs;
  final duration = const Duration(seconds: 0).obs;

  StreamSubscription? _mPlayerSubscription;

  AudioPlaybackController({required this.url});

  void getPlaybackFn() {
    if (_mPlayer!.isPlaying) {
      _mPlayer?.pausePlayer();
      isPlaying.value = false;
    }

    if (_mPlayer!.isPaused) {
      _mPlayer?.resumePlayer();
      isPlaying.value = true;
    }

    if (_mPlayer!.isStopped) {
      _mPlayer?.startPlayer(
        fromURI: url,
        whenFinished: () {
          isPlaying.value = false;
        },
      );
      isPlaying.value = true;
    }
  }

  void seek() {
    _mPlayer?.seekToPlayer(position.value);
  }

  @override
  void onInit() async {
    await _mPlayer?.openPlayer();
    _mPlayer?.setSubscriptionDuration(const Duration(seconds: 1));
    final _tmp = await _mPlayer?.startPlayer(
      fromURI: url,
      whenFinished: () {
        isPlaying.value = false;
      },
    );

    if (_tmp != null) {
      duration.value = _tmp;
      _mPlayer?.pausePlayer();
    }

    _mPlayerSubscription = _mPlayer?.onProgress?.listen((event) {
      position.value = event.position;
    });

    super.onInit();
  }

  @override
  void onClose() {
    _mPlayer?.stopPlayer();
    _mPlayer?.closePlayer();
    if (_mPlayerSubscription != null) {
      _mPlayerSubscription!.cancel();
      _mPlayerSubscription = null;
    }
    super.onClose();
  }
}
