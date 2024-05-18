import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/app_cubit/theme_cubit.dart';
import 'package:task_manager/core/di/injection_container.dart';
import 'package:task_manager/core/views/widgets/main_button.dart';
import 'package:task_manager/core/views/widgets/main_scaffold.dart';
import 'package:task_manager/features/auth/cubit/todos_cubit/auth_cubit.dart';
import 'package:task_manager/features/auth/cubit/todos_cubit/auth_state.dart';
import 'package:task_manager/features/auth/views/widgets/password_field.dart';
import 'package:task_manager/features/auth/views/widgets/user_name_field.dart';
import 'package:task_manager/features/home/views/widgets/welcome_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthCubit _authCubit;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
  }

  login() {
    if (formKey.currentState?.validate() ?? false) {
      _authCubit.login(
        userName: controllerUsername.text,
        password: controllerPassword.text,
      );
    } else {
      HapticFeedback.vibrate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appbar: const WelcomeWidget(
        message: 'Login to Start Using The Task Manger',
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: _authCubit,
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => MainButton(
                title: 'login'.tr(),
                onPressed: login,
              ),
              loading: () => MainButton(
                title: 'login'.tr(),
                isLoading: true,
                onPressed: () {},
              ),
            );
          },
          listener: (BuildContext context, AuthState state) {
            state.maybeWhen(orElse: () {}, loaded: (user) {
              context.go('/todos');

            });
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            UserNameField(controller: controllerUsername),
            PasswordField(controller: controllerPassword),
          ],
        ),
      ),
    );
  }
}
