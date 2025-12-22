import 'dart:convert';
import 'package:futurekids/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:get/get.dart';
import 'package:plan_vs_zombies/plan_vs_zombies.dart';
import 'package:archery/archery.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:swimming_pool/swimming_pool.dart';
import 'package:webview_flutter/webview_flutter.dart' as wv;
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter/webview_flutter.dart'
    show
        PlatformWebViewControllerCreationParams,
        WebViewController,
        WebViewPlatform;
import 'game_controller.dart';

class GamePage extends StatelessWidget {
  final controller = Get.put(GameController());

  GamePage({Key? key}) : super(key: key);

  void callBackPostScoreAndDisplayExitDialog(
      double score, bool isDisplayDialog, bool isStudyCompleted) {
    if (isDisplayDialog) {
      controller.exitGame(isStudyCompleted);
    } else {
      controller.submitData(score);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFlameGame = controller.game.urlGame.toString().contains('archery') ||
        controller.game.urlGame.toString().contains('plan-vs-zombies') ||
        controller.game.urlGame.toString().contains('swimming-pool');

    return WillPopScope(
        child: Scaffold(
            body: isFlameGame
                ? FutureBuilder(
                    future: controller.ensureGameOrientation(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return showGameAI();
                    },
                  )
                : showWebView()),
        onWillPop: () async {
          if (kIsWeb) {
            return false;
          }
          controller.exitGame(false);
          return true;
        });
  }

  Widget showGameAI() {
    if (controller.game.urlGame.toString().contains('archery')) {
      return StartScreenArchery(
          contentId: controller.game.id,
          profileId: AuthService.to.profileModel.value.provinceId,
          callback: callBackPostScoreAndDisplayExitDialog);
    } else if (controller.game.urlGame.toString().contains('plan-vs-zombies')) {
      return StartScreenPlanVsZombies(
          contentId: controller.game.id,
          profileId: AuthService.to.profileModel.value.provinceId,
          callback: callBackPostScoreAndDisplayExitDialog);
    } else if (controller.game.urlGame.toString().contains('swimming-pool')) {
      return StartScreenSwimmingPool(
          contentId: controller.game.id,
          profileId: AuthService.to.profileModel.value.provinceId,
          callback: callBackPostScoreAndDisplayExitDialog);
    }
    return Container();
  }

  Widget showWebView() {
    final url =
        "${controller.game.urlGame}?contentId=${controller.game.id}${AuthService.to.hasLogin ? '&profileId=' + AuthService.to.profileModel.value.provinceId.toString() : ''}";
    return kIsWeb
        ? Stack(
            children: [
              WebView(
                url,
                aspectRatio: Get.width / Get.height,
                autoResize: true,
                mediaPlaybackAlwaysAllow: true,
                userAgent: 'fkids',
                js: false,
              ),
              PointerInterceptor(
                  child: Obx(() => SizedBox(
                        width: controller.hideWebView.value ? Get.width : 1,
                        height: controller.hideWebView.value ? Get.height : 1,
                      )))
            ],
          )
        : Builder(builder: (context) {
            late final PlatformWebViewControllerCreationParams params;
            if (WebViewPlatform.instance is WebKitWebViewPlatform) {
              params = WebKitWebViewControllerCreationParams(
                allowsInlineMediaPlayback: true,
                mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
              );
            } else {
              params = const PlatformWebViewControllerCreationParams();
            }

            final webCtrl =
                WebViewController.fromPlatformCreationParams(params)
                  ..setJavaScriptMode(JavascriptMode.unrestricted)
                  ..setNavigationDelegate(
                    wv.NavigationDelegate(
                      onProgress: (value) =>
                          controller.loadingProcess.value = value.toDouble(),
                    ),
                  )
                  ..addJavaScriptChannel(
                    'FKids',
                    onMessageReceived: (message) {
                      final obj = jsonDecode(message.message);
                      if (obj['exit']) {
                        controller.exitGame(obj['isStudyCompleted']);
                      } else {
                        var score =
                            double.tryParse(obj['score'].toString()) ?? 0.0;

                        if (score > 0) {
                          controller.submitData(score);
                        }
                      }
                    },
                  )
                  ..loadRequest(Uri.parse(url));

            // Allow autoplay on Android WebView
            if (webCtrl.platform is AndroidWebViewController) {
              (webCtrl.platform as AndroidWebViewController)
                  .setMediaPlaybackRequiresUserGesture(false);
            }
            // iOS: already set via WebKit params above (allowsInlineMediaPlayback + no user action)

            controller.webViewController = webCtrl;
            return wv.WebViewWidget(controller: webCtrl);
          });
  }
}

class JavascriptMode {
  static wv.JavaScriptMode unrestricted = wv.JavaScriptMode.unrestricted;
}
