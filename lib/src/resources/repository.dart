import 'dart:async';

import 'package:learnflutterapp/src/models/ItemModel.dart';
import 'package:learnflutterapp/src/models/trailer_model.dart';
import 'package:learnflutterapp/src/resources/movie_api_provider.dart';

class Repository{

  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();

  Future<TrailerModel> fetchTrailers(int movieId) => moviesApiProvider.fetchTrailer(movieId);
}