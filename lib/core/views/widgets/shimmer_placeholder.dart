import 'package:flutter/material.dart';
import 'package:task_manager/core/views/widgets/shimmer.dart';

/// Shimmer loader like 'Facebook loading'
class CustomShimmer extends StatelessWidget {
  CustomShimmer.normal({
    super.key,
    this.height,
    this.width,
  }) : _borderRadius = BorderRadius.circular(0);

  CustomShimmer.circular({
    super.key,
    this.height,
    this.width,
  }) : _borderRadius = BorderRadius.circular(20);

  CustomShimmer.circular2({
    super.key,
    this.height,
    this.width,
  }) : _borderRadius = BorderRadius.circular(100);

  CustomShimmer.squarer({
    super.key,
    this.height,
    this.width,
  }) : _borderRadius = BorderRadius.circular(12);

  final double? height;
  final double? width;
  final BorderRadius _borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300] ?? const Color(0xFF757575),
      highlightColor: Colors.grey[100] ?? const Color(0xFF757575),
      enabled: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          color: Colors.white,
        ),
        height: height,
        width: width,
      ),
    );
  }

  static Widget todosListShimmer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(
          15,
          (index) => Shimmer.fromColors(
            baseColor: Colors.grey[300] ?? const Color(0xFF757575),
            highlightColor: Colors.grey[100] ?? const Color(0xFF757575),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                width: MediaQuery.of(context).size.width,
                height: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
