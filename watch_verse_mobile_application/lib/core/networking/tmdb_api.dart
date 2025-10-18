import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:watch_verse/core/constants/string_constants.dart';
import 'package:watch_verse/core/models/movie.dart';
part 'tmdb_api.g.dart';

@RestApi(baseUrl: StringConstants.baseUrl)
abstract class TmdbApi {
  factory TmdbApi(Dio dio) = _TmdbApi;

  @GET("/movie/popular")
  Future<MovieResponse> loadNowPlayingMovies(
    @Header("Authorization") String apiKey,
    @Header("accept") String accept,
    @Query("language") String language,
    @Query("page") int page,
  );

  @GET("/movie/upcoming")
  Future<MovieResponse> loadComingSoonMovies(
    @Header("Authorization") String apiKey,
    @Header("accept") String accept,
    @Query("language") String language,
    @Query("page") int page,
  );

  @GET("/trending/movie/{time_window}")
  Future<MovieResponse> loadTrendingMovies(
    @Header("Authorization") String apiKey,
    @Header("accept") String accept,
    @Path("time_window") String timeWindow,
    @Query("language") String language,
  );

  @GET("/movie/top_rated")
  Future<MovieResponse> loadTopRatedMovies(
    @Header("Authorization") String apiKey,
    @Header("accept") String accept,
    @Query("language") String language,
    @Query("page") int page,
  ); 
  
  
  @GET("/search/movie")
  Future<MovieResponse> loadSearchMovies(
    @Header("Authorization") String apiKey,
    @Header("accept") String accept,
    @Query("query") String query,
    @Query("language") String language,
    @Query("page") int page,
  );

}
