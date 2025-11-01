part of swimming_pool;

class StartScreenSwimmingPool extends StatelessWidget {
  final int contentId;
  final int? profileId;
  final Function callback;
  final StartGameSwimmingPool game = StartGameSwimmingPool();

  StartScreenSwimmingPool(
      {Key? key, required this.contentId, required this.callback, this.profileId})
      : super(key: key);

  Future loadData() async {
    await FlameAudio.audioCache.loadAll([
      'background-swimming-pool.mp3',
      'swimming-sound.mp3',
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
          IconBack.ID,
          FutureKids.ID,
          FuboStart.ID,
          Logo.ID,
          IconVolume.ID,
        ],
        overlayBuilderMap: {
          PlayButton.ID: (BuildContext context, StartGameSwimmingPool game) =>
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
          IconBack.ID: (BuildContext context, StartGameSwimmingPool game) =>
              IconBack(
                score: 0,
                callBackPostScore: callback,
                isStudyCompleted: false,
              ),
          IconTime.ID: (BuildContext context, StartGameSwimmingPool game) =>
              const IconTime(),
          FutureKids.ID: (BuildContext context, StartGameSwimmingPool game) =>
              const FutureKids(),
          IconVolume.ID: (BuildContext context, StartGameSwimmingPool game) =>
              const IconVolume(),
          FuboStart.ID: (BuildContext context, StartGameSwimmingPool game) =>
              const FuboStart(),
          Logo.ID: (BuildContext context, StartGameSwimmingPool game) => Logo(
                paddingLeft: 556.w,
                paddingTop: 240.h,
                width: 1270.w,
                height: 531.h,
              ),
        },
      ),
    );
  }
}
