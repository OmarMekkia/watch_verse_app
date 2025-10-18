import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_verse/core/di/di.dart';
import 'package:watch_verse/core/repos/tmdb_repo.dart';
import 'package:watch_verse/features/favourites/ui/favorites_screen.dart';
import 'package:watch_verse/features/home/ui/home_screen.dart';
import 'package:watch_verse/features/profile/ui/profile_screen.dart';
import 'package:watch_verse/features/search/logic/search_cubit.dart';
import 'package:watch_verse/features/search/ui/search_screen.dart';

class BottomNav extends StatefulWidget {
  final TmdbRepo tmdbRepo;
  const BottomNav({super.key, required this.tmdbRepo});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      HomeScreen(tmdbRepo: widget.tmdbRepo),
      BlocProvider.value(value: getIt<SearchCubit>(), child: SearchScreen()),
      FavoritesScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display current page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Switch page
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
