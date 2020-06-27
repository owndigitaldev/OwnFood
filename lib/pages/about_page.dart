import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ownfood/core/style/app_color.dart';
import 'package:ownfood/core/tools/helper.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  Helper _helper;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _helper = new Helper(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * .1),
            Align(
              alignment: Alignment.topCenter,
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "asset/images/ic_text_own_food.png",
                    width: size.width * .5,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * .1),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: _itemTitle(title: "Tentang OwnFood"),
                  ),
                  SizedBox(height: 8.0),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              "Sebuah platform untuk melayani pesan antar makanan dari "
                              "restoran terdekat. Terdapat resep makanan yang kami peroleh dari ",
                        ),
                        TextSpan(
                          text: "The Meal DB",
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _helper.intentLauncher(
                                  "https://www.themealdb.com/api.php");
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  _itemTitle(title: "Library"),
                  SizedBox(height: 8.0),
                  _itemList(
                    name: "flutter_launcher_icons",
                    url: "https://pub.dev/packages/flutter_launcher_icons",
                  ),
                  _itemList(
                    name: "flappy_search_bar",
                    url: "https://pub.dev/packages/flappy_search_bar",
                  ),
                  _itemList(
                    name: "url_launcher",
                    url: "https://pub.dev/packages/url_launcher",
                  ),
                  _itemList(
                    name: "http",
                    url: "https://pub.dev/packages/http",
                  ),
                  SizedBox(height: 16.0),
                  _itemTitle(title: "Developed by"),
                  SizedBox(height: 8.0),
                  _itemList(
                    name: "Rahmat Trinanda",
                    url: "https://www.linkedin.com/in/rahmat-trinanda/",
                    description: "Sebagai Programmer",
                  ),
                  _itemList(
                    name: "M. Zidan Azis",
                    url: "https://www.instagram.com/semeru.zidan/",
                    description: "Sebagai UI/UX Designer",
                  ),
                  SizedBox(height: 16.0),
                  _itemTitle(title: "Powered by"),
                  SizedBox(height: 8.0),
                  _itemList(
                    name: "Flutter",
                    url: "https://flutter.dev/",
                  ),
                  _itemList(
                    name: "Android Studio",
                    url: "https://developer.android.com/studio",
                  ),
                  _itemList(
                    name: "Git",
                    url: "https://git-scm.com/",
                  ),
                  _itemList(
                    name: "GitHub",
                    url: "https://github.com/",
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: InkWell(
                      child: Text(
                        "Original Design",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        _helper.intentLauncher(
                            "https://1drv.ms/f/s!Auc0Dx9nvP8YiAoiN70AwsD6_jqL");
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * .1),
          ],
        ),
      ),
    );
  }

  Widget _itemTitle({@required String title}) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    );
  }

  Widget _itemList(
      {@required String name, @required String url, String description}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: "\u2022 ",
          ),
          TextSpan(
            text: name + " ",
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _helper.intentLauncher(url);
              },
          ),
          TextSpan(
            text: description ?? "",
          ),
        ],
      ),
    );
  }
}
