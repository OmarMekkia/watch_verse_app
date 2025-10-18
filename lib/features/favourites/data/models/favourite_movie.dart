import 'package:json_annotation/json_annotation.dart';

part 'favourite_movie.g.dart';

@JsonSerializable()
class FavouriteMovie {
  final String id;
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
  final DateTime? createdAt;
  DateTime? updatedAt;

  FavouriteMovie({
    required this.id,
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
    this.createdAt,
    this.updatedAt,
  });

  factory FavouriteMovie.fromJson(Map<String, dynamic> json) =>
      _$FavouriteMovieFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteMovieToJson(this);
}
