import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_verse/features/home/categories/coming_soon/coming_soon_movies_cubit.dart';
import 'package:watch_verse/features/home/categories/playing_now/now_playing_movies_cubit.dart';
import 'package:watch_verse/features/home/categories/top_rated/top_rated_movies_cubit.dart';
import 'package:watch_verse/features/home/categories/trending/trending_movies_cubit.dart';
import 'package:watch_verse/core/di/di.dart';
import 'package:watch_verse/core/helpers/spacing.dart';
import 'package:watch_verse/core/repos/tmdb_repo.dart';
import 'package:watch_verse/features/home/categories/coming_soon/coming_soon_movies_widget.dart';
import 'package:watch_verse/features/home/categories/playing_now/playing_now_list_view.dart';
import 'package:watch_verse/features/home/categories/top_rated/top_rated_list_view.dart';
import 'package:watch_verse/features/home/categories/trending/trending_list_view.dart';

class HomeScreen extends StatefulWidget {
  final TmdbRepo tmdbRepo;
  const HomeScreen({super.key, required this.tmdbRepo});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          titleSpacing: 22,
          bottom: const TabBar(
            padding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(text: "Trending", height: 38),
              Tab(text: "Now Playing", height: 38),
              Tab(text: "Top Rated", height: 38),
            ],
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: ListView(
            padding: EdgeInsets.all(10.r),
            children: [
              verticalSpacing(10.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 35.h,
                children: [
                  Column(
                    spacing: 20.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upcoming Movies",
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: BlocProvider.value(
                          value: getIt<ComingSoonCubit>(),
                          child: const ComingSoonMoviesWidget(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 370.h,
                    child: TabBarView(
                      children: [
                        BlocProvider.value(
                          value: getIt<TrendingMoviesCubit>(),
                          child: Column(
                            spacing: 20.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Trending",
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Expanded(child: TrendingListView()),
                            ],
                          ),
                        ),
                        BlocProvider.value(
                          value: getIt<PlayingNowMoviesCubit>(),
                          child: Column(
                            spacing: 20.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Playing Now",
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Expanded(child: PlayingNowListView()),
                            ],
                          ),
                        ),
                        BlocProvider.value(
                          value: getIt<TopRatedMoviesCubit>(),
                          child: Column(
                            spacing: 20.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Top Rated",
                                style: TextStyle(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Expanded(child: TopRatedListView()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
