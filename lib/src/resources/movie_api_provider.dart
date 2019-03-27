import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:learnflutterapp/src/models/ItemModel.dart';
import 'package:learnflutterapp/src/models/trailer_model.dart';

class MovieApiProvider{

  Client client = Client();
  final _apiKey = "";
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<ItemModel> fetchMovieList()async{
    print("entered");
    final response =  await client.get("$_baseUrl/popular?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId)async{
    final response = await client.get("$_baseUrl/$movieId/videos?api_key=$_apiKey");
    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}


