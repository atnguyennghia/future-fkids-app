import 'package:futurekids/data/models/rank_model.dart';
import 'package:get/get.dart';

class MyRankController extends GetxController {
  final ranks = Get.arguments['ranks'] as List<RankModel>;
  final currentRank = Get.arguments['current_rank'];
}
