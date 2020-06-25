import 'package:flutter/material.dart';
import 'package:ownfood/core/style/app_color.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
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
                color: Color.fromRGBO(255, 255, 255, 0.5),
              ),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi"
                    " tincidunt molestie ultrices. Proin elit libero, interdum nec "
                    "mauris in, pulvinar blandit ligula. Sed vulputate vitae est "
                    "eget tristique. Nullam suscipit feugiat libero. Vestibulum "
                    "orci diam, pharetra at erat at, rhoncus tempor diam. Mauris "
                    "varius urna orci, eu facilisis augue imperdiet ac. "
                    "Pellentesque habitant morbi tristique senectus et netus et "
                    "malesuada fames ac turpis egestas. Nulla augue nulla, "
                    "interdum vel nisi iaculis, malesuada malesuada tellus. Duis "
                    "ut purus vel lectus vestibulum lacinia a vitae dui. Mauris "
                    "eget iaculis orci, vel auctor libero. Suspendisse a molestie "
                    "nibh. Cras nec erat faucibus, lobortis metus in, tincidunt "
                    "mauris. Mauris suscipit pellentesque consectetur. Duis risus "
                    "erat, iaculis a scelerisque ac, ornare eu dui. Aenean "
                    "pellentesque elementum purus, ullamcorper posuere dui "
                    "egestas sit amet. Maecenas posuere quam turpis, sed tristique "
                    "mauris aliquet vel. Maecenas dapibus rhoncus pharetra. "
                    "Integer sed vestibulum mauris. Integer tellus eros, consequat "
                    "in urna non, scelerisque accumsan leo. Vivamus ultricies, "
                    "diam at congue blandit, erat nunc cursus turpis, vitae "
                    "aliquet nunc elit vitae erat. Integer consectetur risus vel "
                    "aliquet malesuada. Sed ut tristique nisi. Aliquam erat "
                    "volutpat. Sed in elementum nulla, sit amet malesuada metus. "
                    "Class aptent taciti sociosqu ad litora torquent per conubia "
                    "nostra, per inceptos himenaeos. Quisque porta purus eu lacus "
                    "porttitor viverra. Phasellus nec consequat erat, ac viverra "
                    "erat. Pellentesque bibendum risus ante, varius efficitur "
                    "lectus varius in. Donec rhoncus convallis porttitor. ",
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: size.height * .1),
          ],
        ),
      ),
    );
  }
}
