import 'package:watch_verse/core/networking/tmdb_api.dart';
import 'package:watch_verse/core/constants/string_constants.dart';
import 'package:watch_verse/core/networking/api_result.dart';
import 'package:watch_verse/features/home/categories/trending/trending_time_window.dart';
import 'package:watch_verse/core/models/movie.dart';
import 'package:watch_verse/env.dart';

class TmdbRepo {
  final TmdbApi tmdbApi;

  TmdbRepo({required this.tmdbApi});

  Future<ApiResult<MovieResponse>> getComingSoonMovies({
    required int page,
  }) async {
    try {
      final result = await tmdbApi.loadComingSoonMovies(
        BEARER_KEY,
        StringConstants.accept,
        StringConstants.englishLanguage,
        page,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<MovieResponse>> getNowPlayingMovies({
    required int page,
  }) async {
    try {
      final result = await tmdbApi.loadNowPlayingMovies(
        BEARER_KEY,
        StringConstants.accept,
        StringConstants.englishLanguage,
        page,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<MovieResponse>> getTopRatedMovies({
    required int page,
  }) async {
    try {
      final result = await tmdbApi.loadTopRatedMovies(
        BEARER_KEY,
        StringConstants.accept,
        StringConstants.englishLanguage,
        page,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<MovieResponse>> getTrendingMovies({
    required TrendingTimeWindow trendingTimeWindow,
  }) async {
    try {
     
      final result = await tmdbApi.loadTrendingMovies(
        BEARER_KEY,
        StringConstants.accept,
        trendingTimeWindow.value,
        StringConstants.englishLanguage,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.error(
        "Failed to fetch trending movies: ${e.toString()}",
      );
    }
  }

  Future<ApiResult<MovieResponse>> searchMovies({
    required String query,
    required int page,
  }) async {
    try {
      final data = await tmdbApi.loadSearchMovies(
        BEARER_KEY,
        StringConstants.accept,
        query,
        StringConstants.englishLanguage,
        page,
      );
      return ApiResult.success(data);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }
}
