import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager/features/auth/views/pages/profile_page.dart';
import 'package:task_manager/features/todos/views/pages/todos_page.dart';
import 'bottom_nav_state.dart';

@lazySingleton
class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState.initial());

  int selectedPageIndex = 0;

  List<Widget> pages = const [
    TodosPage(),
    ProfilePage(),
  ];

  List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
      icon: const Icon(CupertinoIcons.home),
      label: 'home'.tr(),
      tooltip: 'home'.tr(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.person),
      label: 'profile'.tr(),
      tooltip: 'profile'.tr(),
    ),
  ];

  updatePageIndex(int index) {
    emit(const BottomNavState.initial());
    selectedPageIndex = index;
    emit(BottomNavState.bottomNavLoaded(index));
  }
}
