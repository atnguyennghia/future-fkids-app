import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/modules/course/course_controller.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';

class ArticleController extends GetxController {
  final CategoryModel category;
  ArticleController({required this.category});
  final courseController = Get.find<CourseController>();
  final listArticle = <dynamic>[].obs;

  void fetchArticle() async {
    final courseProvider = CourseProvider();
    final result = await courseProvider.getContent(courseId: courseController.course.courseId,
        categoryId: category.categoryId,
        categoryType: 2).catchError((err) => Notify.error(err));
    if (result != null) {
      listArticle.value = result["contents"];
    }
  }

  @override
  void onInit() {
    fetchArticle();
    // TODO: implement onInit
    super.onInit();
  }
}
