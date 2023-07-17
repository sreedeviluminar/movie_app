import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widegts/toprated.dart';
import 'package:movie_app/widegts/trending.dart';
import 'package:movie_app/widegts/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.teal),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];

  final String apikey = '900d64eccb694946c6f18c19955888dd';
  final readaccesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MDBkNjRlY2NiNjk0OTQ2YzZmMThjMTk5NTU4ODhkZCIsInN1YiI6IjY0YWM0Mzc2YjY4NmI5MDBhZjlmMDcwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xkIPUd-svlIlWpVIHinzj6RGjcf_cAaNenx_lukq21U';

  void initState(){
    loadmovies();
    super.initState();
  }

  loadmovies() async{
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readaccesstoken),
    logConfig: ConfigLogger(
      showLogs: true,
      showErrorLogs: true
    ));

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending(); // fetch all the trending movies
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
    print(trendingmovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,
        title: modified_text(text: 'Movie App', color: Colors.white,size: 20,),),
      body: ListView(
        children: [
          TV(tv: tv,),
          TopRated(toprated: topratedmovies),
          TrendingMovies(trending: trendingmovies,), //refractoring widget to show the trending movies
        ],
      ),
    );
  }
}




