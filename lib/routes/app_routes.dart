import 'package:futurekids/middlewares/auth_middleware.dart';
import 'package:futurekids/modules/achievement/achievement_page.dart';
import 'package:futurekids/modules/achievement/detail/detail_page.dart';
import 'package:futurekids/modules/achievement/my_rank/my_rank_page.dart';
import 'package:futurekids/modules/auth/forgot_password/forgot_password_page.dart';
import 'package:futurekids/modules/auth/login/login_page.dart';
import 'package:futurekids/modules/auth/otp/otp_page.dart';
import 'package:futurekids/modules/auth/register/register_page.dart';
import 'package:futurekids/modules/auth/reset_password/reset_password_page.dart';
import 'package:futurekids/modules/course/course_page.dart';
import 'package:futurekids/modules/course/summary/summary_page.dart';
import 'package:futurekids/modules/exercise/exercise_page.dart';
import 'package:futurekids/modules/exercise/result/result_page.dart';
import 'package:futurekids/modules/game/game_page.dart';
import 'package:futurekids/modules/home/home_page.dart';
import 'package:futurekids/modules/lesson/lesson_page.dart';
import 'package:futurekids/modules/personal/about/about_page.dart';
import 'package:futurekids/modules/personal/account_info/account_info_page.dart';
import 'package:futurekids/modules/personal/card/card_page.dart';
import 'package:futurekids/modules/personal/card/iap/ipa_page.dart';
import 'package:futurekids/modules/personal/change_password/change_password_page.dart';
import 'package:futurekids/modules/personal/contact/contact_page.dart';
import 'package:futurekids/modules/personal/guide/guide_page.dart';
import 'package:futurekids/modules/personal/personal_page.dart';
import 'package:futurekids/modules/personal/rule/rule_page.dart';
import 'package:futurekids/modules/personal/setting/setting_page.dart';
import 'package:futurekids/modules/profile/create_profile/create_profile_page.dart';
import 'package:futurekids/modules/profile/edit_profile/edit_profile_page.dart';
import 'package:futurekids/modules/profile/profile_page.dart';
import 'package:futurekids/modules/profile/select_avatar/select_avatar_page.dart';
import 'package:futurekids/modules/rank/rank_detail/rank_detail_page.dart';
import 'package:futurekids/modules/rank/rank_page.dart';
import 'package:futurekids/modules/regulation/regulation_page.dart';
import 'package:futurekids/modules/tutorial/tutorial-home/tutorial_home_page.dart';
import 'package:futurekids/modules/tutorial/tutorial-profile/tutorial_profile_page.dart';
import 'package:futurekids/modules/unit/unit_page.dart';
import 'package:get/get.dart';

import '../modules/personal/user_delete/user_delete_page.dart';

class AppRoutes {
  ///root page
  static const String main = "/";

  static const String test = "/test";

  ///achievement
  static const String achievement = "/achievement";
  static const String achievementDetail = "/detail";
  static const String achievementMyRank = "/my-rank";

  ///rank
  static const String rank = "/rank";
  static const String rankDetail = "/detail";

  ///Personal
  static const String personal = "/personal";
  static const String accountInfo = "/account-info";

  static const String card = "/card";

  static const String iap = "/iap";
  static const String iapDetails = "/details";

  static const String changePassword = "/change-password";
  static const String setting = "/setting";
  static const String guide = "/guide";
  static const String contact = "/contact";
  static const String rule = "/rule";
  static const String about = "/about";
  static const String userDelete = "/user-delete";

  ///login page
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String forgotPassword = "/auth/forgot-password";
  static const String otp = "/auth/otp";
  static const String resetPassword = "/auth/reset-password";

  ///profile
  static const String profile = "/profile";
  static const String selectAvatar = "/select-avatar";
  static const String createProfile = "/create-profile";
  static const String editProfile = "/edit-profile";

  ///course
  static const String unit = "/unit";
  static const String lesson = "/lesson";
  static const String course = "/course";
  static const String summary = "/summary";

  ///exercise
  static const String exercise = "/exercise";
  static const String exerciseResult = "/result";
  static const String exerciseMatching = "/matching";

  ///game
  static const String game = "/game";

  ///regulation
  static const String regulation = "/regulation/:type";

  ///tutorial
  static const String tutorialProfile = "/tutorial-profile";
  static const String tutorialHome = "/tutorial-home";

  ///pages map
  static final List<GetPage> getPages = [
    GetPage(
        name: main, page: () => HomePage(), transitionDuration: Duration.zero),
    GetPage(
        name: achievement,
        page: () => AchievementPage(),
        transitionDuration: Duration.zero,
        children: [
          GetPage(name: achievementDetail, page: () => DetailPage()),
          GetPage(name: achievementMyRank, page: () => MyRankPage()),
        ],
        middlewares: [
          AuthMiddleware()
        ]),
    GetPage(
        name: rank,
        page: () => RankPage(),
        transitionDuration: Duration.zero,
        children: [
          GetPage(name: rankDetail, page: () => RankDetailPage()),
        ],
        middlewares: [
          AuthMiddleware()
        ]),

    ///Personal
    GetPage(
        name: personal,
        page: () => PersonalPage(),
        transitionDuration: Duration.zero,
        middlewares: [
          AuthMiddleware()
        ],
        children: [
          GetPage(name: accountInfo, page: () => AccountInfoPage()),

          ///IAP
          GetPage(
            name: card,
            page: () => CardPage(),
            children: [
              GetPage(
                name: iap,
                page: () => IAPPage(),
              ),
            ],
          ),

          GetPage(name: changePassword, page: () => ChangePasswordPage()),
          GetPage(name: setting, page: () => SettingPage()),
          GetPage(name: guide, page: () => GuidePage()),
          GetPage(name: contact, page: () => ContactPage()),
          GetPage(name: rule, page: () => RulePage()),
          GetPage(name: about, page: () => AboutPage()),
          GetPage(
            name: userDelete,
            page: () => UserDeletePage(),
          ),
        ]),

    ///Auth
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: register, page: () => RegisterPage()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordPage()),
    GetPage(name: otp, page: () => OtpPage()),
    GetPage(name: resetPassword, page: () => ResetPasswordPage()),
    GetPage(name: profile, page: () => ProfilePage(), middlewares: [
      AuthMiddleware()
    ], children: [
      GetPage(name: selectAvatar, page: () => SelectAvatarPage()),
      GetPage(name: createProfile, page: () => CreateProfilePage()),
      GetPage(name: editProfile, page: () => EditProfilePage()),
    ]),

    ///Course
    GetPage(name: unit, page: () => UnitPage()),
    GetPage(name: lesson, page: () => LessonPage()),
    GetPage(name: course, page: () => CoursePage()),
    GetPage(name: summary, page: () => SummaryPage()),
    GetPage(name: exercise, page: () => ExercisePage(), children: [
      GetPage(name: exerciseResult, page: () => ResultPage()),
    ]),
    GetPage(name: game, page: () => GamePage()),
    GetPage(name: regulation, page: () => RegulationPage()),

    ///Tutorial
    GetPage(name: tutorialProfile, page: () => TutorialProfilePage()),
    GetPage(name: tutorialHome, page: () => TutorialHomePage()),
  ];
}
