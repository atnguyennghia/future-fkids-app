class VocabularyModel {
  dynamic id;
  dynamic word;
  dynamic phonetic;
  dynamic means;
  dynamic audio;
  dynamic image;
  bool isSpeaking = false;
  bool isRecording = false;

  VocabularyModel();

  VocabularyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    word = json['word'];
    phonetic = json['phonetic'];
    means = json['means'];
    audio = json['audio'];
    image = json['image'];
  }
}