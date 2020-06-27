import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ownfood/core/datasource/api.dart';
import 'package:ownfood/core/tools/helper.dart';
import 'package:ownfood/models/food_model.dart';
import 'package:http/http.dart' as http;
import 'package:ownfood/core/style/app_color.dart';

class DetailPage extends StatefulWidget {
  final String idMeal;

  DetailPage({@required this.idMeal});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  Helper _helper;
  API _api;
  Future _detailFuture;
  FoodModel _foodModel;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _helper = new Helper(context: context);
    _api = new API();
    _detailFuture = _api.detail(idMeal: widget.idMeal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _detailFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    colorAccent,
                  ),
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasData) {
                http.Response res = snapshot.data;
                if (res.statusCode == 200) {
                  _foodModel = FoodModel.fromJson(jsonDecode(res.body));

                  var data = _foodModel.meals[0];
                  return NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          expandedHeight: 350.0,
                          brightness: Brightness.dark,
                          floating: true,
                          pinned: true,
                          snap: true,
                          iconTheme: IconThemeData(
                            color: Colors.white,
                          ),
                          flexibleSpace: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Image.network(
                                  data.strMealThumb,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  var top = constraints.biggest.height;
                                  return FlexibleSpaceBar(
                                    title: AnimatedOpacity(
                                      duration: Duration(milliseconds: 300),
                                      opacity: top ==
                                              MediaQuery.of(context)
                                                      .padding
                                                      .top +
                                                  kToolbarHeight
                                          ? 1.0
                                          : 0.0,
                                      child: Text(
                                        data.strMeal,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    background: Image.network(
                                      data.strMealThumb,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: kToolbarHeight + 32.0,
                          left: 16.0,
                          right: 16.0,
                          bottom: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _itemData(
                              title: "Category",
                              data: data.strCategory,
                            ),
                            SizedBox(height: 8.0),
                            _itemData(
                              title: "Area",
                              data: data.strArea,
                            ),
                            SizedBox(height: 8.0),
                            _itemData(
                              title: "Instruction",
                              data: data.strInstructions,
                            ),
                            SizedBox(height: 8.0),
                            _itemData(
                              title: "Tags",
                              data: data.strTags,
                            ),
                            SizedBox(height: 8.0),
                            InkWell(
                              child: _itemData(
                                title: "Youtube",
                                data: data.strYoutube,
                              ),
                              onTap: (){
                                _helper.intentLauncher(data.strYoutube);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
          }
          return Container();
        },
      ),
    );
  }

  Widget _itemData({@required String title, @required String data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(data),
      ],
    );
  }
}
