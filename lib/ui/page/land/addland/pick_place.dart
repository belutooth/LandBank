import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoder/services/base.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const kGoogleApiKey = "AIzaSyAff5oMqOhSw8da9Dl6i9OGpkuIkp3L7L4";

class GoogleGeocoding implements Geocoding {

  static const _host = 'https://maps.google.com/maps/api/geocode/json';

  final String apiKey;

  final HttpClient _httpClient;

  GoogleGeocoding(this.apiKey) :
        _httpClient = HttpClient(),
        assert(apiKey != null, "apiKey must not be null");

  Future<List<Address>> findAddressesFromCoordinates(Coordinates coordinates) async  {
    final url = '$_host?key=$apiKey&latlng=${coordinates.latitude},${coordinates.longitude}';
    return _send(url);
  }

  Future<List<Address>> findAddressesFromQuery(String address) async {
    var encoded = Uri.encodeComponent(address);
    final url = '$_host?key=$apiKey&address=$encoded';
    return _send(url);
  }

  Future<List<Address>> _send(String url) async {
    print("Sending $url...");
    final uri = Uri.parse(url);
    final request = await this._httpClient.getUrl(uri);
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();
    print("Received $responseBody...");
    var data = jsonDecode(responseBody);

    var results = data["results"];

    if(results == null)
      return null;

    return results.map(_convertAddress)
        .map<Address>((map) => Address.fromMap(map))
        .toList();
  }

  Map _convertCoordinates(dynamic geometry) {
    if(geometry == null)
      return null;

    var location = geometry["location"];
    if(location == null)
      return null;

    return {
      "latitude" : location["lat"],
      "longitude" : location["lng"],
    };
  }

  Map _convertAddress(dynamic data) {

    Map result = Map();

    result["coordinates"] = _convertCoordinates(data["geometry"]);
    result["addressLine"] = data["formatted_address"];

    var addressComponents = data["address_components"];

    addressComponents.forEach((item) {

      List types = item["types"];

      if(types.contains("route")) {

        result["thoroughfare"] = item["long_name"];
      }
      else if(types.contains("street_number")) {

        result["subThoroughfare"] = item["long_name"];
      }
      else if(types.contains("country")) {
        result["countryName"] = item["long_name"];
        result["countryCode"] = item["short_name"];
      }
      else if(types.contains("administrative_area_level_3")) {
        result["locality"] = item["long_name"];
      }
      else if(types.contains("postal_code")) {
        result["postalCode"] = item["long_name"];
      }
      else if(types.contains("postal_code")) {
        result["postalCode"] = item["long_name"];
      }
      else if(types.contains("administrative_area_level_1")) {
        result["adminArea"] = item["long_name"];
      }
      else if(types.contains("administrative_area_level_2")) {
        result["subAdminArea"] = item["long_name"];
      }
      else if(types.contains("administrative_area_level_4")) {
        result["subLocality"] = item["long_name"];
      }
      else if(types.contains("premise")) {
        result["featureName"] = item["long_name"];
      }

      result["featureName"] = result["featureName"] ?? result["addressLine"];

    });

    return result;
  }
}

class MapsDemo extends StatefulWidget {

  @override
  State createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
  var geolocator = Geolocator();
  Position position;
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(-33.852, 151.211),
    zoom: 11.0,
  );
  CameraPosition _position = _kInitialPosition;
  bool _isMoving = false;
  StreamSubscription _getPositionSubscription;
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, timeInterval: 10);
  GoogleMapController mapController;


  @override
  void initState() {
    super.initState();
    _getPositionSubscription=   geolocator.getPositionStream(locationOptions).listen(
            (Position position) {
          this.position=position;
          //print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude,position.longitude), zoom: 20.0),

            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {


    return  Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              trackCameraPosition: true,
              initialCameraPosition: _kInitialPosition,
              /*options: GoogleMapOptions(
                  myLocationEnabled: true
              )*/

          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child:   new RaisedButton(
              onPressed: _getAddress,
              textColor: Colors.white,
              color: Colors.red,
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "GetAddress",
              ),
            ),
          ),
        ),
        /*Center(
          child: Image.asset(
            'assets/images/startloc.png'
            ,height: 60,
            width: 60,
          ),
        )*/
      ],


    );

  }

  void _onMapCreated(GoogleMapController controller) {

    mapController = controller;
    mapController.addListener(_onMapChanged);
    _extractMapInfo();
    setState(() {});

  }
  void _onMapChanged() {
    setState(() {
      _extractMapInfo();
    });
  }

  void _extractMapInfo() {
    _position = mapController.cameraPosition;
    //print(_position.target.longitude);
    _isMoving = mapController.isCameraMoving;
  }

  Future<Null> _getAddress() async {
//    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude,position.longitude);
//     print(placemark.elementAt(0).locality);\
    //print( _position.target.latitude);
    final coordinates = new Coordinates(_position.target.latitude,_position.target.longitude);

    //print(coordinates);

    var addresses = await GoogleGeocoding(kGoogleApiKey).findAddressesFromCoordinates(coordinates);
    final List<Address> address = addresses;
    Navigator.pop(context,address);
    //print( addresses.first.addressLine);
  }
  @override
  void dispose() {
    _getPositionSubscription.cancel();
    super.dispose();
  }

}