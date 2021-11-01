import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mod3_kel30/screens/detail.dart';
import 'package:mod3_kel30/screens/profiles.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   Future<List<AiringModel>> airing;
   Future<List<Top>> top;
  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    airing = fetchAiring();
    top = fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('My Anime List',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize:25,
          fontWeight: FontWeight.bold,)
          ),
        actions: <Widget>[
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profiles(),
                    ),
                  ),
              icon: Icon(
                Icons.manage_accounts_rounded,
                size: 24,
              )
              )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    'Top Airing',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
              Padding(
                padding:const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 200.0,
                  child: FutureBuilder<List<AiringModel>>(
                    future: airing,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index)=>
                              GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detail(
                                    item: snapshot.data[index].malId,
                                    title: snapshot.data[index].title,
                                  ),
                                ),
                              );
                            },
                        child: Card(
                        elevation: 0,
                          child: Container(
                            height: 150,
                            width: 100,
                              child: Column(
                                children: [
                                  Container(
                                    height: 150,
                                    child: Image.network(
                                      snapshot.data[index].imageUrl)),
                                      Text(
                                        snapshot.data[index].title,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        ),
                                   ],
                                  ),
                                ),
                              ),
                            ),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 20),
              child: Text(
                'Top Anime',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: SizedBox(
                child: FutureBuilder<List<Top>>(
                    future: top,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) =>
                              ListTile(
                            leading: Image.network(
                              snapshot.data[index].imageUrl,
                            ),
                            title: Text(snapshot.data[index].title),
                            subtitle: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.black,
                                  size: 15.0,
                                ),
                                Text(snapshot.data[index].score.toString()),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detail(
                                    title: snapshot.data[index].title,
                                    item: snapshot.data[index].malId,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Padding(
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                              value: 0.20,
                          )),
                          padding: const EdgeInsets.only(top: 60));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AiringModel {
  final int malId;
  final String title;
  final num score;
  final String imageUrl;

  AiringModel({
     this.score,
     this.title,
     this.imageUrl,
     this.malId,
  });

  factory AiringModel.fromJson(Map<String, dynamic> json) {
    return AiringModel(
      malId: json['mal_id'],
      title: json['title'],
      score: json["score"],
      imageUrl: json['image_url'],
    );
  }
}

//fetch api

Future<List<AiringModel>> fetchAiring() async {
  String api = 'https://api.jikan.moe/v3/top/anime/1/airing';
  final response = await http.get(
    Uri.parse(api),
  );

  if (response.statusCode == 200) {
    var airingRes = jsonDecode(response.body)['top'] as List;

    return airingRes.map((airing) => AiringModel.fromJson(airing)).toList();
  } else {
    throw Exception('Request failed');
  }
}

class Top {
  final int malId;
  final String title;
  final String imageUrl;
  final num score;

  Top({
     this.malId,
     this.title,
     this.imageUrl,
     this.score,
  });

  factory Top.fromJson(Map<String, dynamic> json) {
    return Top(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['image_url'],
      score: json['score'],
    );
  }
}

Future<List<Top>> fetchShows() async {
  String api = 'https://api.jikan.moe/v3/top/anime/1';
  final response = await http.get(
    Uri.parse(api),
  );

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['top'] as List;

    return topShowsJson.map((top) => Top.fromJson(top)).toList();
  } else {
    throw Exception('Request failed');
  }
}
