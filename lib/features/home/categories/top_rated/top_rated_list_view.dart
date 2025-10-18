import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_verse/features/home/categories/top_rated/top_rated_movies_cubit.dart';
import 'package:watch_verse/features/home/ui/widgets/bloc_builder_for_list_view.dart';

class TopRatedListView extends StatefulWidget {
  const TopRatedListView({super.key});

  @override
  State<TopRatedListView> createState() => _TopRatedListViewState();
}

class _TopRatedListViewState extends State<TopRatedListView> {
  late TopRatedMoviesCubit _topRatedMoviesCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _topRatedMoviesCubit = context.read<TopRatedMoviesCubit>();
    _topRatedMoviesCubit.fetchTopRatedMovies(1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: blocBuilderForListView<TopRatedMoviesCubit>(),
    );
  }
}
