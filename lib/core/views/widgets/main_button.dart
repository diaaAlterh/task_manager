import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/light_theme.dart';

import 'loader_widget.dart';

class MainButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;

  const MainButton({super.key, required this.title, required this.onPressed, this.isLoading=false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightTheme().primaryColor,
              foregroundColor: Colors.white
        ),
        onPressed: onPressed,
        child: isLoading?const LoaderWidget(color: Colors.white,):Text(
          title,
        ),
      ),
    );
  }
}
