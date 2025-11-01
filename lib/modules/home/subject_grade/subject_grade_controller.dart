import 'package:carousel_slider/carousel_slider.dart';
import 'package:futurekids/data/models/subject_grade_model.dart';
import 'package:futurekids/data/providers/grade_provider.dart';
import 'package:futurekids/modules/home/home_controller.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';

class SubjectGradeController extends GetxController {
  final homeController = Get.find<HomeController>();
  final carouselController = CarouselSliderController();
  final dynamic subjectId;
  final listSubjectGrade = <SubjectGradeModel>[].obs;
  final currentIndex = 0.obs;

  SubjectGradeController({required this.subjectId});

  void fetchListGradeBySubject() async {
    final provider = GradeProvider();
    final result = await provider
        .getListGradeBySubject(subjectId: subjectId)
        .catchError((err) => Notify.error(err));
    if (result != null) {
      listSubjectGrade.value = result;
    }
  }

  void onGradeClick({required dynamic gradeId}) async {
    homeController.onSubjectClick(classId: gradeId, subjectId: subjectId);
  }

  @override
  void onInit() {
    super.onInit();

    fetchListGradeBySubject();
  }
}
