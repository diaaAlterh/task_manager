import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({super.key, required this.child, this.icon, required this.onPressed});

  final VoidCallback? onPressed;
  final IconData? icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 3.w),
            foregroundColor: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Theme.of(context).colorScheme.primary,width: 0.5))),
        onPressed: onPressed,
        icon: icon != null
            ? Icon(
                icon,
                color: Theme.of(context).colorScheme.primaryContainer,
              )
            : const SizedBox.shrink(),
        label: child);
  }
}
