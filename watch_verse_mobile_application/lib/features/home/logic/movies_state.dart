import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:watch_verse/core/models/movie.dart';

part 'movies_state.freezed.dart';

@freezed
class MoviesState with _$MoviesState {
  const factory MoviesState.initial() = Initial;
  const factory MoviesState.loading() = Loading;
  const factory MoviesState.loaded(MovieResponse movies) = Loaded;
  const factory MoviesState.error(String message) = Error;
}
