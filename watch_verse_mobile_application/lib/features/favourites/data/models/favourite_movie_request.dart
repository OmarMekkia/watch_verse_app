import 'package:json_annotation/json_annotation.dart';

part 'favourite_movie_request.g.dart';

@JsonSerializable()
class FavouriteMovieRequest {
  final String? movieId;
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  FavouriteMovieRequest({
    this.movieId,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  /// Deserialize JSON → Dart object
  factory FavouriteMovieRequest.fromJson(Map<String, dynamic> json) =>
      _$FavouriteMovieRequestFromJson(json);

  /// Serialize Dart object → JSON
  Map<String, dynamic> toJson() => _$FavouriteMovieRequestToJson(this);
}
