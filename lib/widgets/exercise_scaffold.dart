import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/widgets/base_scaffold.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseScaffold extends StatelessWidget {
  final Widget body;
  final String? exerciseName;
  final Widget? bottomNavigationBar;

  const ExerciseScaffold(
      {Key? key,
      required this.body,
      this.exerciseName,
      this.bottomNavigationBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: BaseScaffold(
          background: 'exercise',
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                final _dialog = LoadingDialog();
                _dialog.exit(
                    isStudyCompleted: false,
                    callback: (confirm) {
                      if (confirm) {
                        _dialog.dismiss();
                        Get.back();
                      } else {
                        _dialog.dismiss();
                      }
                    });
                _dialog.show();
              },
              icon: Image.asset('assets/icons/button_back_ex.png'),
            ),
            titleSpacing: 0.0,
            title: Text(
              '$exerciseName',
              style: CustomTheme.semiBold(18),
            ),
            centerTitle: true,
            backgroundColor: kAccentColor.withOpacity(0.4),
            elevation: 0.0,
            automaticallyImplyLeading: false,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(2),
              child: BoxBorderGradient(
                gradientType: GradientType.type1,
                borderSize: 1,
              ),
            ),
          ),
          bottomNavigationBar: bottomNavigationBar,
          body: body,
        ),
        onWillPop: () async {
          final _dialog = LoadingDialog();
          _dialog.exit(
              isStudyCompleted: false,
              callback: (confirm) {
                if (confirm) {
                  _dialog.dismiss();
                  Get.back();
                } else {
                  _dialog.dismiss();
                }
              });
          _dialog.show();
          return true;
        });
  }
}
