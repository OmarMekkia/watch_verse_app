import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:watch_verse/core/di/di.dart';
import 'package:watch_verse/core/networking/auth_back_end_api.dart';
import 'package:watch_verse/core/routing/app_router.dart';
import 'package:watch_verse/features/auth/data/repos/auth_repo.dart';
import 'package:watch_verse/features/auth/logic/auth_cubit.dart';
import 'package:watch_verse/features/favourites/logic/favourite_cubit.dart';
import 'package:watch_verse/theme/app_theme.dart';

class WatchVerseApp extends StatelessWidget {
  const WatchVerseApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return BlocProvider.value(
          value: AuthCubit(
            authRepo: AuthRepo(
              authApiService: getIt<AuthBackendApi>(),
              storage: getIt<FlutterSecureStorage>(),
            ),
          ),
          child: BlocProvider.value(
            value: getIt<FavouriteCubit>(),

            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: ThemeMode.dark,
              routerConfig: AppRouter.router,
            ),
          ),
        );
      },
    );
  }
}
