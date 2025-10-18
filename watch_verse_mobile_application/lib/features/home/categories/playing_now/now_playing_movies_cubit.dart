import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_verse/features/home/logic/movies_state.dart';
import 'package:watch_verse/core/networking/api_result.dart';
import 'package:watch_verse/core/repos/tmdb_repo.dart';

class PlayingNowMoviesCubit extends Cubit<MoviesState> {
  final TmdbRepo tmdbRepo;
  PlayingNowMoviesCubit({required this.tmdbRepo}) : super(MoviesState.initial());

  void fetchPlayingNowMovies(int page) async {
    emit(MoviesState.loading());
    final movies = await tmdbRepo.getNowPlayingMovies(page: page);

    movies.when(
      success: (data) => emit(MoviesState.loaded(data)),
      error: (message) => emit(MoviesState.error(message)),
    );
  }
}
