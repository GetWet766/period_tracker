import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/core/router/router.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:period_tracker/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:period_tracker/features/profile/presentation/cubit/invite/invite_cubit.dart';
import 'package:period_tracker/features/profile/presentation/cubit/profile/profile_cubit.dart';

class PeriodTracker extends StatefulWidget {
  const PeriodTracker({super.key});

  @override
  State<PeriodTracker> createState() => _PeriodTrackerState();
}

class _PeriodTrackerState extends State<PeriodTracker> {
  late final AuthCubit _authCubit;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authCubit = sl<AuthCubit>()..checkAuthStatus();
    _appRouter = AppRouter(_authCubit);
  }

  @override
  Future<void> dispose() async {
    await _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _authCubit,
        ),
        BlocProvider(
          create: (context) => sl<ProfileCubit>()..getMyProfile(),
        ),
        BlocProvider(
          create: (context) => sl<InviteCubit>()..createPartnerInvite(),
        ),
        BlocProvider(
          create: (context) => sl<CycleCubit>()
            ..loadCycleLogs(
              from: DateTime.now().subtract(const Duration(days: 90)),
            ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.pink)),
        darkTheme: ThemeData(
          brightness: .dark,
          colorScheme: .fromSeed(brightness: .dark, seedColor: Colors.pink),
        ),

        routerConfig: _appRouter.config,
      ),
    );
  }
}
