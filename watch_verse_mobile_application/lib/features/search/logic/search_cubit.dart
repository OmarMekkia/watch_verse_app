import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_verse/core/networking/api_result.dart';
import 'package:watch_verse/core/repos/tmdb_repo.dart';
import 'package:watch_verse/features/home/logic/movies_state.dart';

class SearchCubit extends Cubit<MoviesState> {
  final TmdbRepo tmdbRepo;
  SearchCubit({required this.tmdbRepo}) : super(MoviesState.initial());

  void searchMovies(String query) async{
    emit(MoviesState.loading());
    final data = await tmdbRepo.searchMovies(query: query,page: 1);
    data.when(
      success: (data) {
        emit(MoviesState.loaded(data));
      },
      error: (message) {
        emit(MoviesState.error(message));
      },
    );
  }
}
