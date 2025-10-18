import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:watch_verse/features/favourites/data/models/favourite_movie.dart';

part 'favourite_state.freezed.dart';

@freezed
class FavouriteState with _$FavouriteState {
  const factory FavouriteState.initial() = Initial;
  const factory FavouriteState.loading() = Loading;
  const factory FavouriteState.loaded(List<FavouriteMovie>? movies) = Loaded;
  const factory FavouriteState.error(String message) = Error;
}
