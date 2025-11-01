import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import '../Utils/color_palette.dart';
import 'package:logger/logger.dart' show Level;

class LoadingDialog {
  late CustomProgressDialog? progressDialog;
  final bool dismissAble;

  void playSound(String path) async {
    final _file = await rootBundle.load(path);
    FlutterSoundPlayer _mPlayer = FlutterSoundPlayer(logLevel: Level.nothing);
    await _mPlayer.openPlayer();
    _mPlayer.startPlayer(
        // fromURI: fromURI,
        fromDataBuffer:
            _file.buffer.asUint8List(_file.offsetInBytes, _file.lengthInBytes),
        whenFinished: () {
          _mPlayer.closePlayer();
        });
  }

  LoadingDialog({this.dismissAble = false}) {
    progressDialog = CustomProgressDialog(Get.context!,
        dismissable: dismissAble,
        loadingWidget: const Center(
          child: CircularProgressIndicator(
            color: kAccentColor,
          ),
        ),
        backgroundColor: const Color(0xFF000000).withOpacity(0.65));
  }

  void show() {
    progressDialog?.show();
  }

  void dismiss() {
    progressDialog?.dismiss();
  }

  void succeed(
      {String message = '',
      Function()? callback,
      String title = 'Xác nhận',
      bool showClose = false}) {
    progressDialog?.setLoadingWidget(Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 344,
            height: 244,
            padding:
                const EdgeInsets.only(top: 32, bottom: 16, left: 32, right: 32),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                    child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: CustomTheme.semiBold(16).copyWith(
                      color: kNeutral2Color,
                    ),
                  ),
                )),
                KButton(
                  onTap: callback,
                  title: title,
                  style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
                  width: double.infinity,
                  backgroundColor: BackgroundColor.accent,
                )
              ],
            ),
          ),
          Positioned(
              top: -80,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/fubo_succeed.gif',
                width: 118.18,
                height: 131.13,
              )),
          Visibility(
              visible: showClose,
              child: Positioned(
                  right: 12,
                  top: 12,
                  child: InkWell(
                    onTap: () => progressDialog?.dismiss(),
                    child: SvgPicture.asset(
                      'assets/icons/close.svg',
                      width: 14,
                      height: 14,
                    ),
                  )))
        ],
      ),
    ));
  }

  void error({String message = '', Function()? callback}) {
    progressDialog?.setLoadingWidget(Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 344,
            height: 244,
            padding:
                const EdgeInsets.only(top: 32, bottom: 16, left: 32, right: 32),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                    child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: CustomTheme.semiBold(16).copyWith(
                      color: kNeutral2Color,
                    ),
                  ),
                )),
                KButton(
                  onTap: callback,
                  title: 'Xác nhận',
                  style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
                  width: double.infinity,
                )
              ],
            ),
          ),
          Positioned(
              top: -80,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/fubo_error.gif',
                width: 118.18,
                height: 131.13,
              )),
        ],
      ),
    ));
  }

  void exit(
      {required Function(bool) callback, required bool isStudyCompleted}) {
    progressDialog?.setLoadingWidget(Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 344,
            height: 244,
            padding:
                const EdgeInsets.only(top: 32, bottom: 16, left: 32, right: 32),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                    child: Center(
                  child: isStudyCompleted
                      ? Text(
                          'Bạn đã hoàn thành trò chơi',
                          style: CustomTheme.semiBold(18)
                              .copyWith(color: kNeutral2Color),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Bạn có chắc chắn muốn thoát?',
                              textAlign: TextAlign.center,
                              style: CustomTheme.semiBold(18).copyWith(
                                color: kNeutral2Color,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Mọi tiến trình sẽ bị mất',
                              textAlign: TextAlign.center,
                              style: CustomTheme.medium(16).copyWith(
                                color: kNeutral2Color,
                              ),
                            )
                          ],
                        ),
                )),
                Row(
                  children: [
                    Expanded(
                        child: KButton(
                      backgroundColor: BackgroundColor.disable,
                      onTap: () => callback(false),
                      title: 'Không',
                      style: CustomTheme.semiBold(16)
                          .copyWith(color: Colors.white),
                      width: double.infinity,
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: KButton(
                      onTap: () => callback(true),
                      title: 'Đồng ý',
                      style: CustomTheme.semiBold(16)
                          .copyWith(color: Colors.white),
                      width: double.infinity,
                    ))
                  ],
                )
              ],
            ),
          ),
          Positioned(
              top: -80,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/fubo_error.gif',
                width: 118.18,
                height: 131.13,
              )),
        ],
      ),
    ));
  }

  void correct() {
    playSound('assets/sounds/dung.mp3');
    progressDialog?.setLoadingWidget(Center(
      child: Image.asset('assets/images/fubo_correct.gif'),
    ));
  }

  void inCorrect() {
    playSound('assets/sounds/sai.mp3');
    progressDialog?.setLoadingWidget(Center(
      child: Image.asset('assets/images/fubo_incorrect.gif'),
    ));
  }

  void custom({required Widget loadingWidget, bool dismissable = false}) {
    progressDialog?.dismiss();

    progressDialog = CustomProgressDialog(Get.context!,
        dismissable: dismissable,
        loadingWidget: loadingWidget,
        backgroundColor: const Color(0xFF000000).withOpacity(0.35));

    progressDialog?.show();
  }
}
