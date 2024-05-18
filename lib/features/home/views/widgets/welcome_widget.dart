import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager/core/views/widgets/switch_theme_widget.dart';

import '../../../../core/utils/constants.dart';

class WelcomeWidget extends StatelessWidget implements PreferredSizeWidget {
  const WelcomeWidget({super.key});

  final String tempName = 'Maids.cc';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.w, top: 1.4.h, right: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${'welcome'.tr()} $tempName ${Constants.hiEmoji}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.secondary)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('intro_text'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer)),
                    ],
                  ),
                ),
                const SwitchThemeWidget()
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 84);
}
