import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_verse/core/widgets/custom_text_button.dart';
import 'package:watch_verse/core/widgets/custom_text_form_field.dart';
import 'package:watch_verse/features/home/logic/movies_state.dart';
import 'package:watch_verse/features/search/logic/search_cubit.dart';
import 'package:watch_verse/features/search/ui/build_results_list_function.dart';
import 'package:watch_verse/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            CustomTextFormField(
              controller: _searchController,
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<SearchCubit>().searchMovies(value);
                }
              },
              isObscureText: false,
              text: 'Search movies...',
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, MoviesState>(
                builder: (context, state) {
                  return state.when(
                    initial: () =>
                        const Center(child: Text('Please enter a search term')),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (movies) {
                      if (movies.results.isEmpty) {
                        return const Center(child: Text('No results found'));
                      }

                      return buildResultsList(
                        movies,
                        _searchController,
                        context,
                      );
                    },
                    error: (message) => Center(child: Text('Error: $message')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
