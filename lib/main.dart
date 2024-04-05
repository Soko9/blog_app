import "package:blog_app/core/shared/cubits/app_user/app_user_cubit.dart";
import "package:blog_app/features/auth/presentation/screens/signin_screen.dart";
import "package:blog_app/features/blog/presentation/bloc/blog_bloc.dart";
import "package:blog_app/features/blog/presentation/screens/blog_screen.dart";

import "core/theme/app_theme.dart";
import "dependency_injection.dart";
import "features/auth/presentation/bloc/auth_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppUserCubit>(
          create: (_) => sl<AppUserCubit>(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider<BlogBloc>(
          create: (_) => sl<BlogBloc>(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthGetCurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blog App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: BlocBuilder<AppUserCubit, AppUserState>(
        builder: (_, state) {
          return state is AppUserLoggedIn
              ? const BlogScreen()
              : const SigninScreen();
        },
      ),
    );
  }
}
