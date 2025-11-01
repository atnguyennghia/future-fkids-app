import 'package:futurekids/utils/extension.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final String background;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<Widget>? persistentFooterButtons;

  const BaseScaffold(
      {Key? key,
      this.background = 'main',
      this.appBar,
      this.body,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.persistentFooterButtons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: context.responsive(
                  mobile: AssetImage('assets/backgrounds/$background.png'),
                  desktop:
                      AssetImage('assets/backgrounds/$background-desktop.png')),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter)),
      child: Scaffold(
        appBar: appBar,
        body: body,
        persistentFooterButtons: persistentFooterButtons,
        bottomNavigationBar: bottomNavigationBar,
        backgroundColor: Colors.transparent,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}
