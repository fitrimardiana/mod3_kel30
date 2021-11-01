import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mod3_kel30/screens/profiles.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  final String title;
  final int item;
  Detail({
    Key key,
    this.title,
    this.item,
  }) : super(key: key);
  
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  Future<AiringDetail> detail;

  @override
  void initState() {
    super.initState();
    detail = fetchDetails(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Detail',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: FutureBuilder<AiringDetail>(
          future: detail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(snapshot.data.image),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    snapshot.data.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black, letterSpacing: .5),
                    ),
                    Text(snapshot.data.score.toString()),
                    Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(    
                        snapshot.data.synopsis,                 
                        style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        letterSpacing: .5,
                          ),
                        ),
                      ),
                ],
              ));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong :('));
            }
            return Padding(
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    value: 0.20,
                )),
                padding: const EdgeInsets.only(top: 100));
          },
        )),
      ),
    );
  }
}

class AiringDetail {
  String image;
  String title;
  String synopsis;
  num malId;
  num score;

  AiringDetail(
      { this.image,
       this.title,
       this.synopsis,
       this.malId,
       this.score});

  factory AiringDetail.fromJson(json) {
    return AiringDetail(
      image: json['image_url'],
      title: json['title'],
      synopsis: json['synopsis'],
      malId: json['mal_id'],
      score: json['score'],
    );
  }
}

Future<AiringDetail> fetchDetails(malId) async {
  String api = 'https://api.jikan.moe/v3/anime/$malId';
  var response = await http.get(
    Uri.parse(api),
  );

  if (response.statusCode == 200) {
    return AiringDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
