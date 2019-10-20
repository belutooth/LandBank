import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/ui/page/dashboard/dashboard_one/dashboard_menu_row.dart';
import 'package:the_gorgeous_login/ui/widgets/login_background.dart';
import 'package:the_gorgeous_login/ui/widgets/profile_tile.dart';
import 'package:the_gorgeous_login/utils/uidata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_gorgeous_login/style/theme.dart' as Theme;
import 'package:the_gorgeous_login/ui/page/land/myland.page.dart';

class DashboardOnePage extends StatelessWidget {
  Size deviceSize;
  Widget appBarColumn(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(
                      defaultTargetPlatform == TargetPlatform.android
                          ? Icons.arrow_back
                          : Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  new ProfileTile(
                    title: "Hi, Acep Irawan",
                    subtitle: "Welcome to Land Bank",
                    textColor: Colors.black,
                  ),
                  new IconButton(
                    icon: new Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print("hi");
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      );

  Widget searchCard() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.search),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Find Land"),
                  ),
                ),
                Icon(Icons.menu),
              ],
            ),
          ),
        ),
      );

  Widget actionMenuCard(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  DashboardMenuRow(
                    firstIcon: FontAwesomeIcons.landmark,
                    firstLabel: "My Land",
                    firstIconCircleColor: Colors.blue,
                    firstRoute: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLandPage()));
                    },
                    secondIcon: FontAwesomeIcons.userFriends,
                    secondLabel: "Profile",
                    secondIconCircleColor: Colors.orange,
                    thirdIcon: FontAwesomeIcons.mapMarkerAlt,
                    thirdLabel: "Nearby",
                    thirdIconCircleColor: Colors.purple,
                    fourthIcon: FontAwesomeIcons.locationArrow,
                    fourthLabel: "Moment",
                    fourthIconCircleColor: Colors.indigo,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget balanceCard() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Balance",
                      style: TextStyle(fontFamily: UIData.ralewayFont),
                    ),
                    Material(
                      color: Colors.black,
                      shape: StadiumBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "500 Points",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: UIData.ralewayFont),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget allCards(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: deviceSize.height * 0.1,
            ),
            appBarColumn(context),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            actionMenuCard(context),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            balanceCard(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2.0,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: deviceSize.height * 0.01,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "   Land Recomendation",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: UIData.ralewayFont,
                                  fontSize: 20.0
                              ),
                            ),
                          ],
                        ),
                        ShopItem(),
                        ShopItem(),
                      ],
                    ),
                  ),
              )
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          /*LoginBackground(
            showIcon: false,
          ),*/
          //
          allCards(context),
          new Positioned(
            top: 20.0,
            left: 0.0,
            right: 0.0,
            child: searchCard()
          ), //ShopItem(),

        ],
      ),
    );
  }
}

class ShopItem extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Padding
      (
      padding: EdgeInsets.only(bottom: 16.0),
      child: Stack
        (
        children: <Widget>
        [
          /// Item card
          Align
            (
            alignment: Alignment.topCenter,
            child: SizedBox.fromSize
              (
                size: Size.fromHeight(300.0),
                child: Stack
                  (
                  fit: StackFit.expand,
                  children: <Widget>
                  [
                    /// Item description inside a material
                    Container
                      (
                      margin: EdgeInsets.only(top: 24.0, left: 12.0, right: 12.0),
                      child: Card
                        (
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: EdgeInsets.all(10),
                        elevation: 14.0,
                        //borderRadius: BorderRadius.circular(12.0),
                        //shadowColor: Color(0x802196F3),
                        color: Colors.white,
                        child: Stack(
                          children: <Widget>[
                            Image.network(
                              'https://placeimg.com/640/480/any',
                              fit: BoxFit.fill,),
                            InkWell
                              (
                              //onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ItemReviewsPage())),
                              child: Padding
                                (
                                padding: EdgeInsets.all(24.0),
                                child: Column
                                  (
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>
                                  [
                                    /// Title and rating
                                    Column
                                      (
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>
                                      [
                                        Text('Lorem Ipsum', style: TextStyle(color: Colors.blueAccent)),
                                        Row
                                          (
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>
                                          [
                                            Text('4.6', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                            Icon(Icons.star, color: Colors.black, size: 24.0),
                                          ],
                                        ),
                                      ],
                                    ),
                                    /// Infos
                                    Row
                                      (
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>
                                      [
                                        Text('Lorem Ipsum', style: TextStyle()),
                                        Padding
                                          (
                                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Text('Lorem Ipsum', style: TextStyle(fontWeight: FontWeight.w700)),
                                        ),
                                        Text('', style: TextStyle()),
                                        Padding
                                          (
                                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Material
                                            (
                                            borderRadius: BorderRadius.circular(8.0),
                                            color: Colors.green,
                                            child: Padding
                                              (
                                              padding: EdgeInsets.all(4.0),
                                              child: Text('\$ 13K', style: TextStyle(color: Colors.white)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                    /// Item image
                  ],
                )
            ),
          ),
          /// Review
          Padding
            (
            padding: EdgeInsets.only(top: 280.0, left: 32.0),
            child: Material
              (
              elevation: 12.0,
              color: Colors.transparent,
              borderRadius: BorderRadius.only
                (
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: Container
                (
                decoration: BoxDecoration
                  (
                    gradient: LinearGradient
                      (
                        colors: [ Colors.grey[300], Colors.grey[350] ],
                        end: Alignment.topLeft,
                        begin: Alignment.bottomRight
                    )
                ),
                child: Container
                  (
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile
                    (
                    /*leading: CircleAvatar
                      (
                      backgroundColor: Colors.purple,
                      child: Text('AI'),
                    ),*/
                    title: Text('Lorem Ipsum', style: TextStyle()),
                    subtitle: Text('Lorem Ipsum', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle()),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
