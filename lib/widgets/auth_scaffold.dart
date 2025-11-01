import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/base_scaffold.dart';
import 'package:futurekids/widgets/button_close.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScaffold extends StatelessWidget {
  final Widget? body;
  final bool automaticallyImplyLeading;

  const AuthScaffold(
      {Key? key, this.body, this.automaticallyImplyLeading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        title: const StrokeText(
          text: 'Chào mừng bạn đến với',
        ),
        actions: automaticallyImplyLeading
            ? null
            : [
                ButtonClose(
                  onTap: () => Get.offAllNamed('/home'),
                )
              ],
        centerTitle: true,
        automaticallyImplyLeading: automaticallyImplyLeading,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Image.asset(
                  'assets/images/logo1.png',
                  width: context.responsive(mobile: 120, desktop: 235),
                ),
              ),
              const SizedBox(
                height: 88,
              ),
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 503),
                  child: body,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
