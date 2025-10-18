import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_verse/features/home/logic/movies_state.dart';
import 'package:watch_verse/core/networking/api_result.dart';
import 'package:watch_verse/core/repos/tmdb_repo.dart';

class ComingSoonCubit extends Cubit<MoviesState> {
  final TmdbRepo tmdbRepo;
  ComingSoonCubit({required this.tmdbRepo}) : super(MoviesState.initial());

  void fetchComingSoonMovies({required int page}) async {
    emit(MoviesState.loading());
    final movies = await tmdbRepo.getComingSoonMovies(page: page);

    movies.when(
      success: (data) => emit(MoviesState.loaded(data)),
      error: (message) => emit(MoviesState.error(message)),
    );
  }
}
