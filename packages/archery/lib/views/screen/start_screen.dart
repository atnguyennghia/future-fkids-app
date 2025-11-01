part of archery;

class StartScreenArchery extends StatelessWidget {
  final int contentId;
  final int? profileId;
  final Function callback;
  final StartGameArchery game = StartGameArchery();

  StartScreenArchery(
      {Key? key, required this.contentId, required this.callback, this.profileId})
      : super(key: key);

  Future loadData() async {
    await FlameAudio.audioCache.loadAll([
      'background-archery.mp3',
      'arrow-shooting.mp3',
      'tra-loi-dung.mp3',
      'tra-loi-sai.mp3'
    ]);

    QuestionProvider.listQuestion =
        await QuestionProvider.fetchQuestion('$contentId', '$profileId');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.init(context, designSize: const Size(1920, 1080));

    return Scaffold(
      body: GameWidget(
        game: game,
        initialActiveOverlays: const [
          PlayButton.ID,
          IconTime.ID,
          FutureKids.ID,
          LogoFirst.ID,
          IconVolume.ID,
          IconBack.ID,
        ],
        overlayBuilderMap: {
          PlayButton.ID: (BuildContext context, StartGameArchery game) =>
              FutureBuilder(
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //Đã load được dữ liệu trên server
                  if (snapshot.connectionState == ConnectionState.done) {
                    return PlayButton(
                      callBackPostScore: callback,
                    );
                  }
                  return Container();
                },
                future: loadData(),
              ),
          IconTime.ID: (BuildContext context, StartGameArchery game) =>
              const IconTime(),
          FutureKids.ID: (BuildContext context, StartGameArchery game) =>
              const FutureKids(),
          LogoFirst.ID: (BuildContext context, StartGameArchery game) =>
              const LogoFirst(),
          IconVolume.ID: (BuildContext context, StartGameArchery game) =>
              const IconVolume(),
          IconBack.ID: (BuildContext context, StartGameArchery game) =>
              IconBack(
                callBackPostScore: callback,
                score: 0,
                isStudyCompleted: false,
              )
        },
      ),
    );
  }
}
