import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key,required this.body,this.appbar,this.bottomNavigationBar, this.bottomSheet});

  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final PreferredSizeWidget? appbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appbar, body: SafeArea(child: body),bottomSheet: bottomSheet, bottomNavigationBar: bottomNavigationBar);
  }
}

