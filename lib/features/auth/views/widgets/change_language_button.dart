import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (context.locale.languageCode == 'en') {
          context.setLocale(const Locale('ar'));
        } else {
          context.setLocale(const Locale('en'));
        }
      },
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      child: ListTile(
        leading: Icon(
          Icons.translate,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        title: Text(
          'change_language'.tr(),
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).colorScheme.primaryContainer),
        ),
      ),
    );
  }
}
