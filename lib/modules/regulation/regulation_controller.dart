import 'package:futurekids/data/providers/regulation_provider.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';

class RegulationController extends GetxController {
  final type = Get.parameters['type'] == 'rule' ? 1 : 2;
  final regulation = {}.obs;

  void fetchRegulation() async {
    final provider = RegulationProvider();
    final result = await provider
        .getRegulation(type: type)
        .catchError((err) => Notify.error(err));
    if (result != null) {
      regulation.value = result;
    }
  }

  @override
  void onInit() {
    fetchRegulation();
    super.onInit();
  }
}
