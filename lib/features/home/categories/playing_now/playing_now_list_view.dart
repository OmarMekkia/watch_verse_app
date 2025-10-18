import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_verse/features/home/categories/playing_now/now_playing_movies_cubit.dart';
import 'package:watch_verse/features/home/ui/widgets/bloc_builder_for_list_view.dart';

class PlayingNowListView extends StatefulWidget {
  const PlayingNowListView({super.key});

  @override
  State<PlayingNowListView> createState() => _PlayingNowListViewState();
}

class _PlayingNowListViewState extends State<PlayingNowListView> {
  late PlayingNowMoviesCubit _playingNowMoviesCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _playingNowMoviesCubit = context.read<PlayingNowMoviesCubit>();
    _playingNowMoviesCubit.fetchPlayingNowMovies(1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: blocBuilderForListView<PlayingNowMoviesCubit>(),
    );
  }
}
