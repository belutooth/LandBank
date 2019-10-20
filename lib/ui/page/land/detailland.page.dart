import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/ui/widgets/label_icon.dart';
import 'package:the_gorgeous_login/ui/page/land/addland.page.dart';
import 'package:the_gorgeous_login/ui/page/land/saranadataland/saranaland.page.dart';
import 'package:the_gorgeous_login/ui/page/land/fisikdataland/fisikland.page.dart';
import 'package:the_gorgeous_login/ui/page/land/lingkungandataland/lingkunganland.page.dart';

class DetailLand extends StatefulWidget {
  @override
  _DetailLandState createState() => _DetailLandState();
}

class _DetailLandState extends State<DetailLand> {
  Widget mainCard() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
             "lorem ipsum",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("lorem ipsum"),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LabelIcon(
                  icon: Icons.star,
                  iconColor: Colors.cyan,
                  label: "4,6",
                ),
                Text(
                  "murah",
                  style: TextStyle(
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.w700,
                      fontSize: 25.0),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );

  Widget imagesCard() => SizedBox(
    height: MediaQuery.of(context).size.height / 2.5,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        elevation: 2.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network('https://placeimg.com/640/480/any'),
          ),
        ),
      ),
    ),
  );

  Widget descCard() => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Info Lahan",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Info Umum Dari Lahan",
                  style:
                  TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Spacer(),
            OutlineButton(
              child: Text('Detail'),
              highlightColor: Colors.grey,
            ),
            OutlineButton(
              child: Text('Edit'),
              highlightColor: Colors.grey,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddLand()));
              },
            )
          ],
        )
      ),
    ),
  );

  Widget saranaCard() => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Sarana Lahan",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Info Sarana Dari Lahan",
                    style:
                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Spacer(),
              OutlineButton(
                child: Text('Detail'),
                highlightColor: Colors.grey,
              ),
              OutlineButton(
                child: Text('Edit'),
                highlightColor: Colors.grey,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SaranaLand()));
                },
              )
            ],
          )
      ),
    ),
  );

  Widget fisikCard() => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Fisik Lahan",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Info Fisik Dari Lahan",
                    style:
                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Spacer(),
              OutlineButton(
                child: Text('Detail'),
                highlightColor: Colors.grey,
              ),
              OutlineButton(
                child: Text('Edit'),
                highlightColor: Colors.grey,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FisikLand()));
                },
              )
            ],
          )
      ),
    ),
  );

  Widget lingkunganCard() => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Lingkungan Lahan",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child:  Text(
                      "Info Lingkungan Dari Lahan",
                      style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                    ),
                  )

                ],
              ),
              Spacer(),
              OutlineButton(
                child: Text('Detail'),
                highlightColor: Colors.grey,
              ),
              OutlineButton(
                child: Text('Edit'),
                highlightColor: Colors.grey,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LingkunganLand()));
                },
              )
            ],
          )
      ),
    ),
  );

  /*Widget actionCard() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShoppingAction(product: product)),
    ),
  );*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar
        (
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton
          (
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text('My Land Detail', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /*SizedBox(
              height: deviceSize.height / 4,
            ),*/
            mainCard(),
            imagesCard(),
            descCard(),
            saranaCard(),
            fisikCard(),
            lingkunganCard()
          ],
        ),
      ),
    );
  }

}