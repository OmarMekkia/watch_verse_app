import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:watch_verse/features/favourites/data/models/favourite_movie_request.dart';
import 'package:watch_verse/features/favourites/data/models/favourite_movie.dart';
part 'back_end_api.g.dart';

@RestApi(baseUrl:"http://localhost:8080")
abstract class BackEndApiService {
  factory BackEndApiService(Dio dio, {String baseUrl}) = _BackEndApiService;

  @GET("/favourites/movies")
  Future<List<FavouriteMovie>> getFavouriteMovies(
  );

  @POST("/favourites/movies")
  Future<FavouriteMovie> addFavouriteMovie(
      @Body() FavouriteMovieRequest request);

  @PUT("/favourites/movies")
  Future<FavouriteMovie> updateFavouriteMovie(
      @Body() FavouriteMovieRequest request);

  @DELETE("/favourites/movies/{id}")
  Future<List<FavouriteMovie>> deleteFavouriteMovie(
      @Path("id") String id);

  @DELETE("/favourites/movies")
  Future<List<FavouriteMovie>> deleteAllFavouriteMovies(
      );
}
