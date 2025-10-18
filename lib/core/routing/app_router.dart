import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_verse/core/di/di.dart';
import 'package:watch_verse/core/networking/tmdb_api.dart';
import 'package:watch_verse/core/models/movie.dart';
import 'package:watch_verse/core/repos/tmdb_repo.dart';
import 'package:watch_verse/core/routing/app_routes.dart';
import 'package:watch_verse/features/auth/logic/auth_cubit.dart';
import 'package:watch_verse/core/widgets/bottom_nav.dart';
import 'package:watch_verse/features/auth/ui/login_screen.dart';
import 'package:watch_verse/features/favourites/data/models/favourite_movie.dart';
import 'package:watch_verse/features/favourites/logic/favourite_cubit.dart';
import 'package:watch_verse/features/movie_details/movie_details_page.dart';
import 'package:watch_verse/features/auth/ui/signup_screen.dart';
import 'package:watch_verse/features/search/logic/search_cubit.dart';
import 'package:watch_verse/features/search/ui/search_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.signUpScreen,

    routes: [
      GoRoute(
        path: AppRoutes.loginScreen,
        builder: (context, state) =>
            LoginScreen(authCubit: context.read<AuthCubit>()),
      ),

      GoRoute(
        path: AppRoutes.signUpScreen,
        builder: (context, state) =>
            SignupScreen(authCubit: context.read<AuthCubit>()),
      ),

      GoRoute(
        path: AppRoutes.navigationBarScreen,
        builder: (context, state) => BottomNav(tmdbRepo: TmdbRepo(tmdbApi: getIt<TmdbApi>())),
      ),

      GoRoute(
        path: AppRoutes.movieDetailsPage,
        builder: (context, state) {
          final Map<String, dynamic> map = state.extra as Map<String, dynamic>;
          final result = map["result"] as Result?;
          final favMovie = map["fav"] as FavouriteMovie?;
          return BlocProvider.value(
            value: getIt<FavouriteCubit>(),
            child: MovieDetailsPage(result: result, favouriteMovie: favMovie),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.searchScreen,
        builder: (context, state) => SearchScreen(),
      ),
    ],
  );
}
