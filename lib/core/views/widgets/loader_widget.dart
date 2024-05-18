import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key, this.color, this.size = 30.0});

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color: color ?? Theme.of(context).colorScheme.primary,
        size: size,
      ),
    );
  }
}
