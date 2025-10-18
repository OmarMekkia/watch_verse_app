import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_verse/features/home/logic/movies_state.dart';
import 'package:watch_verse/core/widgets/center_circular_progress_indicator.dart';
import 'package:watch_verse/features/auth/ui/widgets/error_dialog.dart';
import 'package:watch_verse/features/home/ui/widgets/horizontal_list_view.dart';

Widget blocBuilderForListView<C extends Cubit<MoviesState>>() {
  return BlocBuilder<C, MoviesState>(
    builder: (context, state) {
      return state.when(
        initial: () => const CenterCircularProgressIndicator(),
        loading: () => const CenterCircularProgressIndicator(),
        loaded: (data) {
          return HorizontalListView(movieResponse: data,);
        },
        error: (message) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            errorDialog(context, message);
          });
          return const SizedBox.shrink();
        },
      );
    },
  );
}
