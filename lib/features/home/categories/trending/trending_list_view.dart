import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_verse/features/home/categories/trending/trending_movies_cubit.dart';
import 'package:watch_verse/features/home/categories/trending/trending_time_window.dart';
import 'package:watch_verse/features/home/ui/widgets/bloc_builder_for_list_view.dart';

class TrendingListView extends StatefulWidget {
  const TrendingListView({super.key});

  @override
  State<TrendingListView> createState() => _TrendingListViewState();
}

class _TrendingListViewState extends State<TrendingListView> {
  late TrendingMoviesCubit _trendingMoviesCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _trendingMoviesCubit = context.read<TrendingMoviesCubit>();
    _trendingMoviesCubit.fetchTrendingMovies(
      page: 1,
      timeWindow: TrendingTimeWindow.week,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: blocBuilderForListView<TrendingMoviesCubit>(),
    );
  }
}
