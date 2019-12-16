import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = "";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

final searchScaffoldKey = GlobalKey<ScaffoldState>();

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold, BuildContext context) async {
  if (p != null) {
    // get detail (lat/lng)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;
    final List<AddressComponent> result = detail.result.addressComponents;
    final result2 = detail.result.formattedAddress;

    List allResult = [];
    allResult.add(lat);
    allResult.add(lng);
    allResult.add(result);
    allResult.add(result2);
    //print(result);
    //Navigator.pop(context, result[0].toString() + '|' + result2 + '|' + lat.toString() + '|' + lng.toString());
    Navigator.pop(context,allResult);

    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng - $result")),
    );
  }
}


class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
      apiKey: kGoogleApiKey,
      language: "en",
      components: [Component(Component.country, "id")],
      mode : Mode.overlay
  );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState, context);
      },
      logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      /*searchScaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Got answer")),
      );*/
    }
  }
}
