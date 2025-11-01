import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text_provider.dart';

class STTService extends GetxService {
  static STTService get to => Get.find();

  SpeechToTextProvider? speechProvider;

  Future<STTService> init() async {
    return this;
  }

  Future<bool> initialize() async {
    if (speechProvider == null) {
      final speech = SpeechToText();
      speechProvider = SpeechToTextProvider(speech);
    }
    return await speechProvider?.initialize() ?? false;
  }
}
