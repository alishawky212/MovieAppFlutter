
import 'package:flutter/material.dart';
import 'package:learnflutterapp/src/blocs/MoviesBloc.dart';
import 'package:learnflutterapp/src/blocs/movie_detail_bloc_provider.dart';
import 'package:learnflutterapp/src/models/ItemModel.dart';
import 'package:learnflutterapp/src/ui/movie_detail.dart';
class MovieList extends StatefulWidget{
  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieList>{
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: StreamBuilder(
          stream: bloc.allMovies,
          builder: (context,AsyncSnapshot<ItemModel> snapshot ){
            if(snapshot.hasData){
              return buildList(snapshot);
            }else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }
    ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot){
    return GridView.builder(
      itemCount: snapshot.data.results.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data
                    .results[index].poster_path}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailScreen(snapshot.data.results[index]),
            ),
          );
        });
  }

  void openDetailScreen(Result data){
    Navigator.push(context,
      MaterialPageRoute(builder: (context){
      return MovieDetailBlocProvider(
        child: MovieDetail(data),
      );
      }
      )
    );

  }
}
