import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager/features/todos/views/pages/todos_page.dart';
import 'bottom_nav_state.dart';

@lazySingleton
class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState.initial());

  int selectedPageIndex = 0;

  List<Widget> pages = const [
    TodosPage(),
    SizedBox(),
  ];

  List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
      icon: const Icon(CupertinoIcons.home),
      label: 'home'.tr(),
      tooltip: 'home'.tr(),
    ),
    BottomNavigationBarItem(icon: const Icon(Icons.category_outlined), label: 'explore'.tr(), tooltip: 'explore'.tr()),
  ];

  updatePageIndex(int index) {
    emit(const BottomNavState.initial());
    selectedPageIndex = index;
    emit(BottomNavState.bottomNavLoaded(index));
  }
}
