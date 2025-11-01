part of plan_vs_zombies;

class StartScreenPlanVsZombies extends StatelessWidget {
  final int contentId;
  final int? profileId;
  final Function callback;
  final StartGamePlanVsZombies game = StartGamePlanVsZombies();

  StartScreenPlanVsZombies(
      {Key? key, required this.contentId, required this.callback, this.profileId})
      : super(key: key);

  Future loadData() async {
    await FlameAudio.audioCache.loadAll([
      'background-plan-vs-zombies.mp3',
      'plan-shoot.mp3',
      'sound-bite-zombies.mp3',
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
          IconVolume.ID,
        ],
        overlayBuilderMap: {
          PlayButton.ID: (BuildContext context, StartGamePlanVsZombies game) =>
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
          IconBack.ID: (BuildContext context, StartGamePlanVsZombies game) =>
              IconBack(
                score: 0,
                callBackPostScore: callback,
                isStudyCompleted: false,
              ),
          IconTime.ID: (BuildContext context, StartGamePlanVsZombies game) =>
              const IconTime(),
          FutureKids.ID: (BuildContext context, StartGamePlanVsZombies game) =>
              const FutureKids(),
          IconVolume.ID: (BuildContext context, StartGamePlanVsZombies game) =>
              const IconVolume(),
        },
      ),
    );
  }
}
