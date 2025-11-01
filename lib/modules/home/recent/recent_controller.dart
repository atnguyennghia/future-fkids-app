import 'package:futurekids/data/models/book_model.dart';
import 'package:futurekids/data/providers/user_provider.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';

class RecentController extends GetxController {
  final listStudying = <BookModel>[].obs;

  void fetchStudying() async {
    final userProvider = UserProvider();
    final result = await userProvider
        .getListStudying(profileId: AuthService.to.profileModel.value.id)
        .catchError((err) => Notify.error(err));

    if (result != null) {
      listStudying.value = result;
    } else {
      listStudying.value = [];
    }
  }

  @override
  void onInit() {
    fetchStudying();
    super.onInit();
  }
}
