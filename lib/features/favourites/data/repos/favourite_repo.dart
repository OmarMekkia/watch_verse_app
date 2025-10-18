import 'package:watch_verse/core/networking/back_end_api.dart';
import 'package:watch_verse/core/networking/api_result.dart';
import 'package:watch_verse/features/favourites/data/models/favourite_movie_request.dart';

class FavouriteRepo {

  final BackEndApiService apiService;
  FavouriteRepo({required this.apiService});

  Future<ApiResult> getFavouriteMovies() async{
    try {
      final data = await  apiService.getFavouriteMovies();
    return ApiResult.success(data);
    } catch (e) {
      return ApiResult.error(e.toString());
    }

  }

  Future<ApiResult> addFavouriteMovie(FavouriteMovieRequest request) async {
    try {
      final data = await apiService.addFavouriteMovie(request);
    return ApiResult.success(data);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult> updateFavouriteMovie(FavouriteMovieRequest request) async {
    try {
      final data = await apiService.updateFavouriteMovie(request);
      return ApiResult.success(data);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult> deleteFavouriteMovie(String id) async {
    try {
      final data = await apiService.deleteFavouriteMovie(id);
      return ApiResult.success(data);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult> deleteAllFavouriteMovies() async {
    try {
      final data = await apiService.deleteAllFavouriteMovies();
      return ApiResult.success(data);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }
}