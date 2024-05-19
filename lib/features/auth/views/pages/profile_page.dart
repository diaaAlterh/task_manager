import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/di/injection_container.dart';
import 'package:task_manager/core/views/widgets/image_view.dart';
import 'package:task_manager/core/views/widgets/loader_widget.dart';
import 'package:task_manager/features/auth/cubit/todos_cubit/auth_cubit.dart';
import 'package:task_manager/features/auth/cubit/todos_cubit/auth_state.dart';
import 'package:task_manager/features/auth/views/widgets/change_language_button.dart';
import 'package:task_manager/features/auth/views/widgets/logout_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
    _authCubit.refreshToken();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AuthCubit, AuthState>(
          bloc: _authCubit,
          builder: (context, state) {
            return state.maybeWhen(
                orElse: () => const SizedBox(),
                loading: ()=>const LoaderWidget(),
                loaded: (user) => Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            height: 150,
                            width: 150,
                            child: ImageView(
                              imageUrl: user?.image ?? '',
                              radius: 100,
                            )),
                        Text(
                          '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                        )
                      ],
                    ));
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const ChangeLanguageButton(),
        const LogoutButton()
      ],
    );
  }
}
