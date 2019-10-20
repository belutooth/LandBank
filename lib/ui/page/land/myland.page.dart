import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/ui/page/land/addland.page.dart';
import 'package:the_gorgeous_login/ui/page/land/detailland.page.dart';

class MyLandPage extends StatefulWidget
{
  @override
  _MyLandPageState createState() => _MyLandPageState();
}

class _MyLandPageState extends State<MyLandPage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
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
          title: Text('My Land (1)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        ),
        body: ListView
          (
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>
          [
            Container
              (
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 54.0),
                child: Material
                  (
                  elevation: 8.0,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(32.0),
                  child: InkWell
                    (
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddLand()));
                    },
                    child: Padding
                      (
                      padding: EdgeInsets.all(12.0),
                      child: Row
                        (
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>
                        [
                          Icon(Icons.add, color: Colors.white),
                          Padding(padding: EdgeInsets.only(right: 16.0)),
                          Text('ADD A LAND', style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                )
            ),
            ShopItem(),
          ],
        )
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
                          color: Colors.white,
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                'https://placeimg.com/640/480/any',
                                fit: BoxFit.fill,),
                              InkWell
                                (
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailLand())),
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