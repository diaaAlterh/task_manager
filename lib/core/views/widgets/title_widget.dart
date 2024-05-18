import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title, this.withSeeAll = false, this.onPressed});

  final String title;
  final bool withSeeAll;
  final VoidCallback? onPressed;

  Color color(BuildContext context) => Theme.of(context).colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primaryContainer)),
          if (withSeeAll) ...[
            TextButton.icon(
                onPressed: onPressed,
                style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 2.w)),
                label: Icon(Icons.arrow_forward_ios_sharp, size: 13.sp, color: color(context)),
                icon: Text(
                  'see_all'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500, color: color(context)),
                )),
          ]
        ],
      ),
    );
  }
}
