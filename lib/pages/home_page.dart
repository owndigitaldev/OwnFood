import 'package:flutter/material.dart';
import 'package:ownfood/core/style/app_color.dart';
import 'package:ownfood/core/tools/helper.dart';
import 'package:ownfood/pages/about_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _search;
  Helper _helper;
  bool _onSearch;

  void _toAboutPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AboutPage(),
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

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _search = new TextEditingController();
    _helper = new Helper(context: context);
    _onSearch = false;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? size.height * .25
                        : size.height * .5,
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
                        SizedBox(height: 32.0),
                        _searchBar(),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
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
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
              ),
            ],
          ),
        ),
      ),
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
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _search,
              keyboardType: TextInputType.text,
              cursorColor: colorAccent,
              onChanged: (String s) {
                setState(() {
                  _onSearch = s != "";
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
                print(s);
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
                    });
                  },
                )
        ],
      ),
    );
  }
}
