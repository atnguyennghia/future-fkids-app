import 'package:futurekids/components/select_class/select_class_view.dart';
import 'package:futurekids/data/models/achievement_model.dart';
import 'package:futurekids/data/models/profile_rank.dart';
import 'package:futurekids/data/providers/achievement_provider.dart';
import 'package:futurekids/data/providers/rank_provider.dart';
import 'package:futurekids/data/providers/regulation_provider.dart';
import 'package:futurekids/modules/rank/rank_detail/widgets/rule_detail.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';
import 'package:isoweek/isoweek.dart';

class RankDetailController extends GetxController {
  dynamic classId = Get.arguments["class_id"];
  final className = (Get.arguments["class_name"] as String).obs;
  final subjectId = Get.arguments["subject_id"];
  final isWeek = true.obs;
  final activeWeek = (Week.current()).obs;
  final activeMonth = (DateTime.now()).obs;
  final achievement = AchievementDetail().obs;

  final profileRankWeek = ProfileRankDetail().obs;
  final profileRankMonth = ProfileRankDetail().obs;

  final listRankWeek = <ProfileRankDetail>[].obs;
  final listRankMonth = <ProfileRankDetail>[].obs;

  final rule = ''.obs;

  int pageWeek = 1;
  int pageMonth = 1;

  bool hasLoadWeek = false;
  bool hasLoadMonth = false;

  void nextScope() {
    if (isWeek.value) {
      activeWeek.value = activeWeek.value.next;
      fetchProfileRank(page: 1);
      return;
    }
    activeMonth.value =
        DateTime(activeMonth.value.year, activeMonth.value.month + 1);
    fetchProfileRank(page: 1);
  }

  void previousScope() {
    if (isWeek.value) {
      activeWeek.value = activeWeek.value.previous;
      fetchProfileRank(page: 1);
      return;
    }
    activeMonth.value =
        DateTime(activeMonth.value.year, activeMonth.value.month - 1);
    fetchProfileRank(page: 1);
  }

  void onRuleClick() {
    final dialog = LoadingDialog();
    dialog.custom(
        loadingWidget: RuleDetail(
          rule: rule,
          callback: () => dialog.dismiss(),
        ),
        dismissable: true);
  }

  void showPopupSelectClass() {
    final dialog = LoadingDialog();
    dialog.custom(
        dismissable: true,
        loadingWidget: SelectClassView(
          callback: (classId, className) {
            dialog.dismiss();
            this.classId = classId;
            this.className.value = className;
            fetchAchievement();

            if (isWeek.value) {
              hasLoadMonth = false;
            } else {
              hasLoadWeek = false;
            }

            fetchProfileRank(page: 1);
          },
        ));
  }

  void fetchProfileRank({required int page}) async {
    final dialog = LoadingDialog();
    dialog.show();

    final provider = RankProvider();
    final result = await provider
        .getProfileRank(
            profileId: AuthService.to.profileModel.value.id,
            classId: classId,
            subjectId: subjectId,
            type: isWeek.value ? 'week' : 'month',
            year: isWeek.value ? activeWeek.value.year : activeMonth.value.year,
            page: page,
            week: isWeek.value ? activeWeek.value.weekNumber : null,
            month: isWeek.value ? null : activeMonth.value.month)
        .catchError((err) {
      dialog.dismiss();
      Notify.error(err);
    });

    if (result != null) {
      dialog.dismiss();
      if (isWeek.value) {
        if (!hasLoadWeek) {
          hasLoadWeek = true;
        }

        if (result.profileRank != null) {
          profileRankWeek.value = result.profileRank!;
        } else {
          profileRankWeek.value = ProfileRankDetail();
        }

        if (page == 1) {
          listRankWeek.clear();
        }
        for (var item in result.listRanks) {
          listRankWeek.add(item);
        }
        pageWeek += 1;
      } else {
        if (!hasLoadMonth) {
          hasLoadMonth = true;
        }

        if (result.profileRank != null) {
          profileRankMonth.value = result.profileRank!;
        } else {
          profileRankMonth.value = ProfileRankDetail();
        }

        if (page == 1) {
          listRankMonth.clear();
        }
        for (var item in result.listRanks) {
          listRankMonth.add(item);
        }
        pageMonth += 1;
      }
    }
  }

  void fetchAchievement() async {
    final provider = AchievementProvider();
    final result = await provider
        .getAchievement(
            profileId: AuthService.to.profileModel.value.id, classId: classId)
        .catchError((err) => Notify.error(err));
    if (result != null) {
      for (var item in result.statistics) {
        if (item.subjectId == subjectId) {
          achievement.value = item;
        }
      }
    }
  }

  void fetchRule() async {
    final provider = RegulationProvider();
    final result = await provider
        .getRegulation(type: 3)
        .catchError((err) => Notify.error(err));
    if (result != null) {
      rule.value = result['content'];
    }
  }

  @override
  void onReady() {
    fetchAchievement();
    fetchProfileRank(page: 1);
    fetchRule();
    super.onReady();
  }
}
