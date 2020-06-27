import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ownfood/core/datasource/api.dart';
import 'package:ownfood/core/style/app_color.dart';
import 'package:ownfood/core/tools/helper.dart';
import 'package:ownfood/models/area_model.dart';
import 'package:ownfood/models/area_model.dart' as a;
import 'package:ownfood/models/category_model.dart';
import 'package:ownfood/models/category_model.dart' as c;
import 'package:ownfood/models/food_model.dart';
import 'package:ownfood/models/ingredient_model.dart';
import 'package:ownfood/models/ingredient_model.dart' as i;
import 'package:ownfood/pages/about_page.dart';
import 'package:http/http.dart' as http;
import 'package:ownfood/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _search;
  Helper _helper;
  API _api;
  bool _onSearch;
  String _selectedFilter;
  String _selectedChild;
  String _filterBy;
  Future _filterFuture;
  Future _bodyFuture;

  FoodModel _foodModel;
  CategoryModel _categoryModel;
  AreaModel _areaModel;
  IngredientModel _ingredientModel;

  void _toAboutPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AboutPage(),
      ),
    );
  }

  void _toDetailPage(String idMeal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailPage(
          idMeal: idMeal,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            content: new Text("Ingin Keluar Dari Aplikasi?"),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Tidak",
                  style: TextStyle(color: colorPrimary),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text(
                  "Ya",
                  style: TextStyle(color: colorPrimary),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        ) ??
        false;
  }

  Future _showFilter(context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (ctx, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  children: <Widget>[
                    SizedBox(height: 32.0),
                    Center(
                      child: Text(
                        "Filter",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(height: 32.0),
                    Divider(),
                    SizedBox(height: 32.0),
                    _selectedFilter == null
                        ? Container()
                        : Text("Berdasarkan :"),
                    DropdownButton<String>(
                      value: _selectedFilter,
                      iconSize: 24,
                      elevation: 16,
                      hint: Text("Filter Berdasarkan"),
                      onChanged: (String newValue) {
                        state(() {
                          _selectedFilter = newValue;
                          _selectedChild = null;
                          switch (newValue) {
                            case 'Main Ingredient':
                              _filterBy = 'i';
                              break;
                            case 'Category':
                              _filterBy = 'c';
                              break;
                            case 'Area':
                              _filterBy = 'a';
                              break;
                          }
                          _filterFuture = _api.getListFilter(by: _filterBy);
                        });
                      },
                      isExpanded: true,
                      itemHeight: 64.0,
                      items: <String>[
                        'Main Ingredient',
                        'Category',
                        'Area',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 32.0),
                    _selectedChild == null
                        ? Container()
                        : Text(_selectedFilter + " :"),
                    _selectedFilter == null
                        ? Container()
                        : FutureBuilder(
                            future: _filterFuture,
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.active:
                                case ConnectionState.waiting:
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                        colorAccent,
                                      ),
                                    ),
                                  );
                                case ConnectionState.done:
                                  if (snapshot.hasData) {
                                    http.Response res = snapshot.data;
                                    if (res.statusCode == 200) {
                                      switch (_filterBy) {
                                        case 'i':
                                          _ingredientModel =
                                              IngredientModel.fromJson(
                                                  jsonDecode(res.body));
                                          break;
                                        case 'c':
                                          _categoryModel =
                                              CategoryModel.fromJson(
                                                  jsonDecode(res.body));
                                          break;
                                        case 'a':
                                          _areaModel = AreaModel.fromJson(
                                              jsonDecode(res.body));
                                          break;
                                      }

                                      return DropdownButton<String>(
                                        value: _selectedChild,
                                        iconSize: 24,
                                        elevation: 16,
                                        hint: Text("Pilih " + _selectedFilter),
                                        onChanged: (String newValue) {
                                          state(() {
                                            _selectedChild = newValue;
                                          });
                                        },
                                        isExpanded: true,
                                        itemHeight: 64.0,
                                        items: _filterBy == 'a'
                                            ? _areaModel.meals
                                                .map<DropdownMenuItem<String>>(
                                                    (a.Meal value) {
                                                return DropdownMenuItem<String>(
                                                  value: value.strArea,
                                                  child: Text(value.strArea),
                                                );
                                              }).toList()
                                            : _filterBy == 'c'
                                                ? _categoryModel.meals.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (c.Meal value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value.strCategory,
                                                      child: Text(
                                                          value.strCategory),
                                                    );
                                                  }).toList()
                                                : _ingredientModel.meals.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (i.Meal value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value:
                                                          value.strIngredient,
                                                      child: Text(
                                                          value.strIngredient),
                                                    );
                                                  }).toList(),
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
                    _selectedFilter == null
                        ? Container()
                        : MaterialButton(
                            color: colorAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Hapus",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              state(() {
                                Navigator.of(context).pop(true);
                                _bodyFuture = _api.getRandom();
                                _selectedFilter = null;
                                _selectedChild = null;
                                _filterBy = null;
                              });
                            },
                          ),
                    _selectedChild == null
                        ? Container()
                        : MaterialButton(
                            color: colorPrimary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.list,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Aktifkan",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              state(() {
                                _search.text = "";
                                Navigator.of(context).pop(true);
                                _bodyFuture = _api.getDataFilter(
                                    by: _filterBy, data: _selectedChild);
                              });
                            },
                          ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _search = new TextEditingController();
    _helper = new Helper(context: context);
    _api = new API();
    _onSearch = false;
    _bodyFuture = _api.getRandom();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _appBar(),
              _body(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          width: size.width,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          decoration: BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _helper.greetingText(),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Segoe",
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      _showFilter(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                        Text(
                          "Filter",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Segoe",
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              _searchBar(),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Row(
            children: <Widget>[
              Expanded(child: Container()),
              IconButton(
                icon: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                onPressed: () {
                  _toAboutPage();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              size: 24.0,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _selectedFilter = null;
                _selectedChild = null;
                _filterBy = null;
                _bodyFuture = _api.search(data: _search.text);
              });
            },
          ),
          Expanded(
            child: TextField(
              controller: _search,
              keyboardType: TextInputType.text,
              cursorColor: colorAccent,
              onChanged: (String s) {
                setState(() {
                  if (s != "") {
                    _onSearch = s != "";
                    _selectedFilter = null;
                    _selectedChild = null;
                    _filterBy = null;
                    _bodyFuture = _api.search(data: _search.text);
                  } else {
                    _bodyFuture = _api.getRandom();
                  }
                });
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                hintText: "Cari makanan kesukaanmu...",
              ),
              onSubmitted: (String s) {
                setState(() {
                  if (s != "") {
                    _onSearch = s != "";
                    _selectedFilter = null;
                    _selectedChild = null;
                    _filterBy = null;
                    _bodyFuture = _api.search(data: _search.text);
                  } else {
                    _bodyFuture = _api.getRandom();
                  }
                });
              },
            ),
          ),
          !_onSearch
              ? Container()
              : IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 24.0,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _onSearch = false;
                      _search.text = "";
                      _bodyFuture = _api.getRandom();
                    });
                  },
                )
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: _bodyFuture,
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

                  return _onSearch == false && _filterBy == null
                      ? _contentMain()
                      : _contentSearchFilter();
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

  Widget _contentSearchFilter() {
    final gridCount = MediaQuery.of(context).size.width ~/ 160.0;
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      physics: ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCount,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.96,
      ),
      itemCount: _foodModel.meals.length,
      itemBuilder: (ctx, idx) {
        var data = _foodModel.meals[idx];
        return InkWell(
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    height: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data.strMealThumb)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                      color: colorAccent,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.strMeal,
                          maxLines: 1,
                          style: TextStyle(
                            color: colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          data.strArea ?? '-',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          data.strTags ?? '-',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: (){
            _toDetailPage(data.idMeal);
          },
        );
      },
    );
  }

  Widget _contentMain() {
    var data = _foodModel.meals[0];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.0),
        Text(
          "Random Food",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 16.0),
        InkWell(
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(data.strMealThumb)),
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color: colorAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container()),
                  Container(
                    width: double.infinity,
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.strMeal,
                          maxLines: 1,
                          style: TextStyle(
                            color: colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          data.strArea ?? '-',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          data.strTags ?? '-',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: (){
            _toDetailPage(data.idMeal);
          },
        ),
      ],
    );
  }
}
