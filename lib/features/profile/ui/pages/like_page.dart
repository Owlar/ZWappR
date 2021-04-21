import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zwappr/features/profile/services/i_like_service.dart';
import 'package:zwappr/features/profile/services/like_service.dart';
import 'package:zwappr/features/profile/ui/widgets/back_btn_blue.dart';

class LikePage extends StatefulWidget {
  @override
  _LikePageState createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  static final ILikeService _likeService = LikeService();

  Future<Map> _getAllLikesFromService() async {
    return await _likeService.get();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getAllLikesFromService();
    });
  }

  Future<FutureOr> onGoBack(dynamic value) {
    setState(() {
      _getAllLikesFromService();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            BackBtnBlue(),
            Text(
              "Likte gjenstander",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Expanded(
              child: FutureBuilder<Map>(
                future: _getAllLikesFromService(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text("Ingen likte gjenstander"));
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(14.0),
                      itemCount: snapshot.data["data"].length,
                      itemBuilder: (BuildContext context, int index) {
                        final thing = snapshot.data["data"][index];
                        return Card(
                            margin: EdgeInsets.fromLTRB(2.0, 14.0, 2.0, 0),
                            child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(children: <Widget>[
                                  Container(
                                      child: Row(children: <Widget>[
                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Text(
                                                      thing["myItem"]["title"] ==
                                                          null
                                                          ? ""
                                                          : thing["myItem"]
                                                      ["title"],

                                                      overflow:
                                                      TextOverflow.ellipsis),
                                                  thing["myItem"]["imageUrl"] ==
                                                          null
                                                      ? Image.asset(
                                                          "assets/images/thing_image_placeholder.png")
                                                      : Image.network(
                                                          thing["myItem"]
                                                              ["imageUrl"]),

                                                ])),
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 2,
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Text(
                                                      thing["offerItem"]["title"] ==
                                                          null
                                                          ? ""
                                                          : thing["offerItem"]
                                                      ["title"],

                                                      overflow:
                                                      TextOverflow.ellipsis),
                                                  thing["offerItem"]["imageUrl"] ==
                                                      null
                                                      ? Image.asset(
                                                      "assets/images/thing_image_placeholder.png")
                                                      : Image.network(
                                                      thing["offerItem"]
                                                      ["imageUrl"]),

                                                ])),
                                        SizedBox(width: 6),
                                        Expanded(
                                            flex: 4,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Text(
                                                      thing["offerItem"]["title"] ==
                                                              null
                                                          ? ""
                                                          : thing["offerItem"]
                                                              ["title"],
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis),
                                                  SizedBox(height: 4),
                                                  Text(
                                                      thing["offerItem"]
                                                                  ["description"] ==
                                                              null
                                                          ? ""
                                                          : thing["offerItem"]
                                                              ["description"],
                                                      style:
                                                          TextStyle(fontSize: 16),
                                                      overflow:
                                                          TextOverflow.ellipsis),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      thing["offerItem"][
                                                                  "exchangeValue"] ==
                                                              null
                                                          ? ""
                                                          : thing["offerItem"][
                                                                  "exchangeValue"] +
                                                              " kr",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis),
                                                  SizedBox(height: 4),
                                                  Text(
                                                      thing["offerItem"]
                                                                  ["condition"] ==
                                                              null
                                                          ? ""
                                                          : "Brukstilstand: " +
                                                              thing["offerItem"]
                                                                  ["condition"],
                                                      style:
                                                          TextStyle(fontSize: 14),
                                                      overflow:
                                                          TextOverflow.ellipsis),
                                                  Text(
                                                      thing["offerItem"]
                                                                  ["category"] ==
                                                              null
                                                          ? ""
                                                          : "Kategori: " +
                                                              thing["offerItem"]
                                                                  ["category"],
                                                      style:
                                                          TextStyle(fontSize: 14),
                                                      overflow:
                                                          TextOverflow.ellipsis),
                                                ])),
                                      ])),
                                ])));
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
