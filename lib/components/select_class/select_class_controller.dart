import 'package:futurekids/data/models/grade_model.dart';
import 'package:futurekids/data/providers/grade_provider.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';

class SelectClassController extends GetxController {
  final listClass = <GradeModel>[].obs;

  final listAvatar = [
    'assets/avatars/fubo_game_0.png',
    'assets/avatars/fubo_game_4.png',
    'assets/avatars/fubo_exercise_2.png',
    'assets/avatars/fubo_exercise_1.png',
    'assets/avatars/fubo_exercise_0.png',
    'assets/avatars/fubo_exercise_4.png'
  ];

  void fetchListClass() async {
    final provider = GradeProvider();
    final result =
        await provider.getListGrade().catchError((err) => Notify.error(err));
    if (result != null) {
      listClass.value = result;
    }
  }

  @override
  void onInit() {
    fetchListClass();
    super.onInit();
  }
}
