import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:watch_verse/core/networking/back_end_api.dart';
import 'package:watch_verse/features/home/categories/coming_soon/coming_soon_movies_cubit.dart';
import 'package:watch_verse/features/favourites/data/repos/favourite_repo.dart';
import 'package:watch_verse/features/favourites/logic/favourite_cubit.dart';
import 'package:watch_verse/features/home/categories/playing_now/now_playing_movies_cubit.dart';
import 'package:watch_verse/features/search/logic/search_cubit.dart';
import 'package:watch_verse/features/home/categories/top_rated/top_rated_movies_cubit.dart';
import 'package:watch_verse/features/home/categories/trending/trending_movies_cubit.dart';
import 'package:watch_verse/core/networking/auth_back_end_api.dart';
import 'package:watch_verse/core/networking/dio_factory.dart';
import 'package:watch_verse/core/networking/tmdb_api.dart';
import 'package:watch_verse/core/repos/tmdb_repo.dart';
import 'package:watch_verse/features/auth/data/repos/auth_repo.dart';
import 'package:watch_verse/features/auth/logic/auth_cubit.dart';

final Dio dio = DioFactory.getDio();
final GetIt getIt = GetIt.instance;

void setup() {
  // External Packages
  getIt.registerSingleton<BackEndApiService>(BackEndApiService(dio));
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton<Dio>(Dio(), instanceName: "tmdbDio");
  getIt.registerSingleton<Dio>(dio, instanceName: "backendDio");

  // Data Sources & API Clients
  getIt.registerSingleton<AuthBackendApi>(
    AuthBackendApi(getIt<Dio>(instanceName: "backendDio")),
  );
  getIt.registerSingleton<TmdbApi>(
    TmdbApi(getIt<Dio>(instanceName: "tmdbDio")),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepo(authApiService: getIt(), storage: getIt()),
  );
  getIt.registerLazySingleton<TmdbRepo>(() => TmdbRepo(tmdbApi: getIt()));
  getIt.registerSingleton<FavouriteRepo>(
    // Using getIt<Type>() is slightly more type-safe and explicit
    FavouriteRepo(apiService: getIt()),
  );

  // Cubits & State Management
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(authRepo: getIt()));
  getIt.registerLazySingleton<ComingSoonCubit>(
    () => ComingSoonCubit(tmdbRepo: getIt()),
  );
  getIt.registerLazySingleton<TrendingMoviesCubit>(
    () => TrendingMoviesCubit(tmdbRepo: getIt()),
  );
  getIt.registerLazySingleton<PlayingNowMoviesCubit>(
    () => PlayingNowMoviesCubit(tmdbRepo: getIt()),
  );
  getIt.registerLazySingleton<TopRatedMoviesCubit>(
    () => TopRatedMoviesCubit(tmdbRepo: getIt()),
  );
  getIt.registerSingleton<SearchCubit>(
    SearchCubit(tmdbRepo: getIt()), // Added dependency
  );
  getIt.registerSingleton<FavouriteCubit>(
    FavouriteCubit(favouriteRepo: getIt()),
  );
}
