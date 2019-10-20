import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:geocoder/model.dart';
import 'package:the_gorgeous_login/ui/page/land/addland/result.dart';
import 'package:the_gorgeous_login/ui/page/land/addland/model.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:the_gorgeous_login/ui/page/land/addland/place_autocomplete.dart';
import 'package:the_gorgeous_login/ui/page/land/addland/pick_place.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddLand extends StatefulWidget {
  @override
  _AddLandState createState() => _AddLandState();
}

class _AddLandState extends State<AddLand> {
  final _ponyModel = LandModel();

  // once the form submits, this is flipped to true, and fields can then go into autovalidate mode.
  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient

  bool _showMaterialIOS = false;
  var locationResult = '';
  Uint8List _imageFile1;
  Uint8List _imageFile2;
  Uint8List _imageFile3;
  Uint8List _imageFile4;

  TextEditingController _jalan;
  TextEditingController _kel;
  TextEditingController _kec;
  TextEditingController _kab;
  TextEditingController _prov;
  TextEditingController _kodepos;
  TextEditingController _lat;
  TextEditingController _long;

  String uuid = new Uuid().v4().toString();

  goToSecondScreen() async {
    List result = await Navigator.push(context, new MaterialPageRoute(
      builder: (BuildContext context) => new CustomSearchScaffold(),
      fullscreenDialog: true,)
    );
    return result;
  }

  goToThirdScreen() async {
    List<Address> result = await Navigator.push(context, new MaterialPageRoute(
      builder: (BuildContext context) => new MapsDemo(),
      fullscreenDialog: true,)
    );
    return result;
  }

  Future<Null> _pickImageFromGallery(int gambar) async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    List<int> imageBytes =await FlutterImageCompress.compressWithList(
      imageFile.readAsBytesSync(),
      minHeight: 1280,
      minWidth: 720,
      quality: 96,
    );
    setState(() {
      if(gambar == 1){
        _imageFile1 = Uint8List.fromList(imageFile.readAsBytesSync());
        //tambahanSubmit.gambar1 = base64Encode(imageBytes);
      }
      else if(gambar == 2){
        _imageFile2 = Uint8List.fromList(imageFile.readAsBytesSync());
        //tambahanSubmit.gambar2 = base64Encode(imageBytes);
      }
      else if(gambar == 3){
        _imageFile3 = Uint8List.fromList(imageFile.readAsBytesSync());
        //tambahanSubmit.gambar3 = base64Encode(imageBytes);
      }
      else if(gambar == 4){
        _imageFile4 = Uint8List.fromList(imageFile.readAsBytesSync());
        //tambahanSubmit.gambar4 = base64Encode(imageBytes);
      }
    });
  }

  Future<Null> _pickImageFromCamera(int gambar) async {
    final File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    List<int> imageBytes =await FlutterImageCompress.compressWithList(
      imageFile.readAsBytesSync(),
      minHeight: 1280,
      minWidth: 720,
      quality: 96,
    );
    setState(() {
      if(gambar == 1){
        _imageFile1 = Uint8List.fromList(imageFile.readAsBytesSync());
        //tambahanSubmit.gambar1 = base64Encode(imageBytes);
      }
      else if(gambar == 2){
        _imageFile2 = Uint8List.fromList(imageFile.readAsBytesSync());
        //tambahanSubmit.gambar2 = base64Encode(imageBytes);
      }
      else if(gambar == 3){
        _imageFile3 = Uint8List.fromList(imageFile.readAsBytesSync());
        //tambahanSubmit.gambar3 = base64Encode(imageBytes);
      }
      else if(gambar == 4){
        _imageFile4 = Uint8List.fromList(imageFile.readAsBytesSync());
        //tambahanSubmit.gambar4 = base64Encode(imageBytes);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Land", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        actions: <Widget>[
          Container(
            child: Platform.isIOS
                ? IconButton(
              icon: Icon(Icons.swap_calls),
              onPressed: () {
                setState(() {
                  _showMaterialIOS = !_showMaterialIOS;
                });
              },
            ) : null,
          ),
        ],
        leading: IconButton
          (
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: _buildPortraitLayout()
      ),
    );
  }

  /* CARDSETTINGS FOR EACH LAYOUT */

  CardSettings _buildPortraitLayout() {
    return CardSettings.sectioned(
      showMaterialIOS: _showMaterialIOS,
      children: <CardSettingsSection>[
        CardSettingsSection(
          showMaterialIOS: _showMaterialIOS,
          header: CardSettingsHeader(
            label: 'Lahan ID',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  height: 10.0,
                  //width: 10.0,
                ),
                new Text(uuid,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold)),
                new SizedBox(
                  height: 10.0,
                  //width: 10.0,
                ),
                new QrImage(
                  data: uuid,
                  size: 200.0,
                ),
              ],
            )
          ],
        ),
        CardSettingsSection(
          showMaterialIOS: _showMaterialIOS,
          header: CardSettingsHeader(
            label: 'Data Lahan',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _CariButuhLahan(),
            _BentukPemanfaatanLahan(),
            _peruntukanLahan(),
            _deskripsiLahan(5),
            _luasLahan(),
            _namaPemilik(),
            _dokumenKepemilikan(),
            _masaBerlaku(),
            _sisaMasaBerlaku()
          ],
        ),
        CardSettingsSection(
          showMaterialIOS: _showMaterialIOS,
          header: CardSettingsHeader(
            label: 'Lokasi',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            new Row(
              children: <Widget>[
                new SizedBox(
                  width: 10.0,
                ),
                new OutlineButton(
                  highlightColor: Colors.grey,
                    child: Text("Cari Alamat"),
                    onPressed: () async {
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomSearchScaffold()));
                      List result = await goToSecondScreen();
                      /*setState(() {
                  _jalan = new TextEditingController(text: result.toString().split('|')[1]);
                  _ponyModel.jalan = result.toString().split('|')[1];
                });*/
                      String lat = result[0].toString();
                      String lng = result[1].toString();
                      List<AddressComponent> address = result[2];
                      String jalan = result[3];
                      setState(() {
                        _jalan = new TextEditingController(text: jalan);
                        _ponyModel.jalan = jalan;
                        _lat = new TextEditingController(text: lat);
                        _ponyModel.latitude = lat;
                        _long = new TextEditingController(text: lng);
                        _ponyModel.longitude = lng;
                      });
                      for(int i = 0; i < address.length; i++){
                        print(address[i].types.toString() + address[i].longName);
                        if(address[i].types.toString() == '[administrative_area_level_4, political]'){
                          setState(() {
                            _kel = new TextEditingController(text: address[i].longName);
                            _ponyModel.kelurahan = address[i].longName;
                          });
                        }
                        if(address[i].types.toString() == '[administrative_area_level_3, political]'){
                          setState(() {
                            _kec = new TextEditingController(text: address[i].longName);
                            _ponyModel.kecamatan = address[i].longName;
                          });
                        }
                        if(address[i].types.toString() == '[administrative_area_level_2, political]'){
                          setState(() {
                            _kab = new TextEditingController(text: address[i].longName);
                            _ponyModel.kabupaten = address[i].longName;
                          });
                        }
                        if(address[i].types.toString() == '[administrative_area_level_1, political]'){
                          setState(() {
                            _prov = new TextEditingController(text: address[i].longName);
                            _ponyModel.provinsi = address[i].longName;
                          });
                        }
                        if(address[i].types.toString() == '[postal_code]'){
                          setState(() {
                            _kodepos = new TextEditingController(text: address[i].longName);
                            _ponyModel.kodepos = address[i].longName;
                          });
                        }
                      }
                      //print(result[0]['types']);
                    }),
                new SizedBox(
                  width: 15.0,
                ),
                new  OutlineButton(
                    highlightColor: Colors.grey,
                    child: Text("Ambil Lokasi"),
                    onPressed: () async {
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomSearchScaffold()));
                      List<Address> result = await goToThirdScreen();
                      setState(() {
                        _jalan = new TextEditingController(text: result[0].addressLine);
                        _ponyModel.jalan = result[0].addressLine;
                        _lat = new TextEditingController(text: result[0].coordinates.latitude.toString());
                        _ponyModel.latitude = result[0].coordinates.latitude.toString();
                        _long = new TextEditingController(text: result[0].coordinates.longitude.toString());
                        _ponyModel.longitude = result[0].coordinates.longitude.toString();
                        _kel = new TextEditingController(text: result[0].subLocality);
                        _ponyModel.kelurahan = result[0].subLocality;
                        _kec = new TextEditingController(text: result[0].locality);
                        _ponyModel.kecamatan = result[0].locality;
                        _kab = new TextEditingController(text: result[0].subAdminArea);
                        _ponyModel.kabupaten = result[0].subAdminArea;
                        _prov = new TextEditingController(text: result[0].adminArea);
                        _ponyModel.provinsi = result[0].adminArea;
                        _kodepos = new TextEditingController(text: result[0].postalCode);
                        _ponyModel.kodepos = result[0].postalCode;
                      });
                    }),
              ],
            ),
            _jalanBesar(3),
            _rt(),
            _rw(),
            _dusun(),
            _komplek(),
            _noLingkungan(),
            _kelurahan(),
            _kecamatan(),
            _kabupaten(),
            _provinsi(),
            _kodePos(),
            _latitude(),
            _longitude()
          ],
        ),
        CardSettingsSection(
          showMaterialIOS: _showMaterialIOS,
          header: CardSettingsHeader(
            label: 'Foto Lahan',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _fotodepan(),
            _fotobelakang(),
            _fotokiri(),
            _fotokanan(),
          ],
        ),
        CardSettingsSection(
          showMaterialIOS: _showMaterialIOS,
          header: CardSettingsHeader(
            label: 'Actions',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _buildCardSettingsButton_Save(),
            _buildCardSettingsButton_Reset(),
          ],
        ),
      ],
    );
  }

  /* BUILDERS FOR EACH FIELD */

  CardSettingsListPicker _CariButuhLahan() {
    return CardSettingsListPicker(
      //icon: Icon(FontAwesomeIcons.question),
      label: 'Purpose',
      hintText: 'Select One',
      initialValue: _ponyModel.purpose,
      autovalidate: _autoValidate,
      options: <String>['Looking', 'Offering'],
      contentAlign: TextAlign.right,
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.purpose = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.purpose = value;
        });
        _showSnackBar('Type', value);
      },
    );
  }

  CardSettingsListPicker _BentukPemanfaatanLahan() {
    return CardSettingsListPicker(
      label: 'Bentuk Pemanfaatan',
      hintText: 'Select One',
      initialValue: _ponyModel.bentukPemanfaatan,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Jual', 'Sewa', 'Penyertaan Modal', 'Tukar Menukar', 'Pinjam Pakai', 'Bot', 'Hibah', 'Kerjasama Pemanfaatan'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.bentukPemanfaatan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.bentukPemanfaatan = value;
        });
        _showSnackBar('Type', value);
      },
    );
  }

  CardSettingsParagraph _deskripsiLahan(int lines) {
    return CardSettingsParagraph(
      showMaterialIOS: _showMaterialIOS,
      label: 'Uraian Lahan',
      initialValue: _ponyModel.uraianLahan,
      numberOfLines: lines,
      onSaved: (value) => _ponyModel.uraianLahan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.uraianLahan = value;
        });
        _showSnackBar('Uraian Lahan', value);
      },
    );
  }

  CardSettingsInt _luasLahan() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Luas Lahan',
      unitLabel: 'm2',
      initialValue: _ponyModel.luas,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.luas = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.luas = value;
        });
        _showSnackBar('Weight', value);
      },
    );
  }

  CardSettingsText _namaPemilik() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Nama Pemilik',
      hintText: 'masukkan nama',
      initialValue: _ponyModel.nama,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Name is required.';
        return null;
      },
      showErrorIOS: _ponyModel.nama == null || _ponyModel.nama.isEmpty,
      onSaved: (value) => _ponyModel.nama = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.nama = value;
        });
        _showSnackBar('Name', value);
      },
    );
  }

  CardSettingsListPicker _dokumenKepemilikan() {
    return CardSettingsListPicker(
      label: 'Bentuk Pemanfaatan',
      hintText: 'Select One',
      initialValue: _ponyModel.dokumenKepemilikan,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      options: <String>['SHM', 'SHGB', 'SHP', 'SHGU', 'SHPL', 'SHMRS', 'AJB', 'SPPHT',
      'PJB LUNAS', 'PJB TIDAK LUNAS', 'PPJB', 'GIRIK', 'LETTER C', 'PETUK/PETOK D', 'KEKITIR', 'PIPIL',
      'RINCIK', 'IPEDA', 'EIGENDOM VERPONDING', 'LANDRETE', 'KETERANGAN DESA/LURAH/CAMAT', 'LAINNYA'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.dokumenKepemilikan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.dokumenKepemilikan = value;
        });
        _showSnackBar('Type', value);
      },
    );
  }

  CardSettingsInt _masaBerlaku() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Masa Berlaku Hak',
      unitLabel: 'tahun',
      initialValue: _ponyModel.masaBerlakuHak,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.masaBerlakuHak = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.masaBerlakuHak = value;
        });
        _showSnackBar('Weight', value);
      },
    );
  }

  CardSettingsInt _sisaMasaBerlaku() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Sisa Masa Berlaku Hak',
      unitLabel: 'tahun',
      initialValue: _ponyModel.sisaMasaBerlakuHak,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.sisaMasaBerlakuHak = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.sisaMasaBerlakuHak = value;
        });
        _showSnackBar('Weight', value);
      },
    );
  }

  CardSettingsParagraph _jalanBesar(int lines) {
    return CardSettingsParagraph(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jalan',
      controller: _jalan,
      initialValue: _ponyModel.jalan,
      numberOfLines: lines,
      onSaved: (value) => _ponyModel.jalan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jalan = value;
        });
        _showSnackBar('Jalan', value);
      },
    );
  }
  
  CardSettingsText _rt() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'RT',
      hintText: 'rt',
      initialValue: _ponyModel.rt,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'rt is required.';
        return null;
      },
      showErrorIOS: _ponyModel.rt == null || _ponyModel.rt.isEmpty,
      onSaved: (value) => _ponyModel.rt = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.rt = value;
        });
        _showSnackBar('rt', value);
      },
    );
  }

  CardSettingsText _rw() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'RW',
      hintText: 'rw',
      initialValue: _ponyModel.rw,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'rw is required.';
        return null;
      },
      showErrorIOS: _ponyModel.rw == null || _ponyModel.rw.isEmpty,
      onSaved: (value) => _ponyModel.rw = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.rw = value;
        });
        _showSnackBar('rw', value);
      },
    );
  }

  CardSettingsText _dusun() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Dusun',
      hintText: 'dusun',
      initialValue: _ponyModel.dusun,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'dusun is required.';
        return null;
      },
      showErrorIOS: _ponyModel.dusun == null || _ponyModel.dusun.isEmpty,
      onSaved: (value) => _ponyModel.dusun = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.dusun = value;
        });
        _showSnackBar('dusun', value);
      },
    );
  }

  CardSettingsText _komplek() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Komplek / Kavling',
      hintText: 'komplek / kavling',
      initialValue: _ponyModel.komplek,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'komplek is required.';
        return null;
      },
      showErrorIOS: _ponyModel.komplek == null || _ponyModel.komplek.isEmpty,
      onSaved: (value) => _ponyModel.komplek = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.komplek = value;
        });
        _showSnackBar('komplek', value);
      },
    );
  }

  CardSettingsText _noLingkungan() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'No Lingkungan',
      hintText: 'no lingkungan',
      initialValue: _ponyModel.noLingkungan,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'nomor is required.';
        return null;
      },
      showErrorIOS: _ponyModel.noLingkungan == null || _ponyModel.noLingkungan.isEmpty,
      onSaved: (value) => _ponyModel.noLingkungan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.noLingkungan = value;
        });
        _showSnackBar('no lingkungan', value);
      },
    );
  }

  CardSettingsText _kelurahan() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Kelurahan',
      hintText: 'Kelurahan',
      controller: _kel,
      initialValue: _ponyModel.kelurahan,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'kelurahan is required.';
        return null;
      },
      showErrorIOS: _ponyModel.kelurahan == null || _ponyModel.kelurahan.isEmpty,
      onSaved: (value) => _ponyModel.kelurahan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kelurahan = value;
        });
        _showSnackBar('kelurahan', value);
      },
    );
  }

  CardSettingsText _kecamatan() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Kecamatan',
      hintText: 'Kecamatan',
      controller: _kec,
      initialValue: _ponyModel.kecamatan,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'kecamatan is required.';
        return null;
      },
      showErrorIOS: _ponyModel.kecamatan == null || _ponyModel.kecamatan.isEmpty,
      onSaved: (value) => _ponyModel.kecamatan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kecamatan = value;
        });
        _showSnackBar('kecamatan', value);
      },
    );
  }

  CardSettingsText _kabupaten() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Kabupaten',
      hintText: 'Kabupaten',
      controller: _kab,
      initialValue: _ponyModel.kabupaten,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'kecamatan is required.';
        return null;
      },
      showErrorIOS: _ponyModel.kabupaten == null || _ponyModel.kabupaten.isEmpty,
      onSaved: (value) => _ponyModel.kabupaten = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kabupaten = value;
        });
        _showSnackBar('kabupaten', value);
      },
    );
  }

  CardSettingsText _provinsi() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Provinsi',
      hintText: 'Provinsi',
      controller: _prov,
      initialValue: _ponyModel.provinsi,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'kecamatan is required.';
        return null;
      },
      showErrorIOS: _ponyModel.provinsi == null || _ponyModel.provinsi.isEmpty,
      onSaved: (value) => _ponyModel.provinsi = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.provinsi = value;
        });
        _showSnackBar('kabupaten', value);
      },
    );
  }

  CardSettingsText _kodePos() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Kode Pos',
      hintText: 'Kode Pos',
      controller: _kodepos,
      initialValue: _ponyModel.kodepos,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'kode pos is required.';
        return null;
      },
      showErrorIOS: _ponyModel.kodepos == null || _ponyModel.kodepos.isEmpty,
      onSaved: (value) => _ponyModel.kodepos = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kodepos = value;
        });
        _showSnackBar('kode pos', value);
      },
    );
  }

  CardSettingsText _latitude() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Latitude',
      hintText: 'Latitude',
      controller: _lat,
      initialValue: _ponyModel.provinsi,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'latitude is required.';
        return null;
      },
      showErrorIOS: _ponyModel.latitude == null || _ponyModel.latitude.isEmpty,
      onSaved: (value) => _ponyModel.latitude = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.latitude = value;
        });
        _showSnackBar('latitude', value);
      },
    );
  }

  CardSettingsText _longitude() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Longitude',
      hintText: 'Longitude',
      controller: _long,
      initialValue: _ponyModel.longitude,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'longitude is required.';
        return null;
      },
      showErrorIOS: _ponyModel.longitude == null || _ponyModel.longitude.isEmpty,
      onSaved: (value) => _ponyModel.longitude = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.longitude = value;
        });
        _showSnackBar('longitude', value);
      },
    );
  }

  CardSettingsMultiselect _peruntukanLahan() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Peruntukan Lahan',
      initialValues: _ponyModel.peruntukanLahan,
      options: <String>['Pertanian', 'Peternakan', 'Perikanan', 'Perkebunan', 'Wisata Argo', 'Perumahan', 'Pertokoan',
      'Pergudangan', 'Pabrik', 'Kawasan Industri', 'Pertambangan'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.peruntukanLahan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.peruntukanLahan = value;
        });
        _showSnackBar('Peruntukan', value);
      },
    );
  }

  _fotodepan(){
    return Column(
      children: <Widget>[
        new ButtonBar(
          children: <Widget>[
            Text(
                "Tampak Depan : "
            ),
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () async => await _pickImageFromCamera(1),
              tooltip: "Shoot Gambar",
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () async => await _pickImageFromGallery(1),
              tooltip: "Ambil Lewat Galeri",
            )
          ],
        ),
        _imageFile1 == null ? Placeholder() : Image.memory(_imageFile1),
      ],
    );
  }

  _fotobelakang(){
    return Column(
      children: <Widget>[
        new ButtonBar(
          children: <Widget>[
            Text(
                "Tampak Belakang : "
            ),
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () async => await _pickImageFromCamera(2),
              tooltip: "Shoot Gambar",
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () async => await _pickImageFromGallery(2),
              tooltip: "Ambil Lewat Galeri",
            )
          ],
        ),
        _imageFile2 == null ? Placeholder() : Image.memory(_imageFile2),
      ],
    );
  }

  _fotokiri(){
    return Column(
      children: <Widget>[
        new ButtonBar(
          children: <Widget>[
            Text(
                "Tampak Samping Kiri : "
            ),
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () async => await _pickImageFromCamera(3),
              tooltip: "Shoot Gambar",
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () async => await _pickImageFromGallery(3),
              tooltip: "Ambil Lewat Galeri",
            )
          ],
        ),
        _imageFile3 == null ? Placeholder() : Image.memory(_imageFile3),
      ],
    );
  }

  _fotokanan(){
    return Column(
      children: <Widget>[
        new ButtonBar(
          children: <Widget>[
            Text(
                "Tampak Samping Kanan : "
            ),
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () async => await _pickImageFromCamera(4),
              tooltip: "Shoot Gambar",
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () async => await _pickImageFromGallery(4),
              tooltip: "Ambil Lewat Galeri",
            )
          ],
        ),
        _imageFile4 == null ? Placeholder() : Image.memory(_imageFile4),
      ],
    );
  }

  CardSettingsButton _buildCardSettingsButton_Reset() {
    return CardSettingsButton(
      showMaterialIOS: _showMaterialIOS,
      label: 'RESET',
      isDestructive: true,
      onPressed: _resetPressed,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
  }

  CardSettingsButton _buildCardSettingsButton_Save() {
    return CardSettingsButton(
      showMaterialIOS: _showMaterialIOS,
      label: 'SAVE',
      onPressed: _savePressed,
    );
  }

  CardSettingsPassword _buildCardSettingsPassword() {
    return CardSettingsPassword(
      showMaterialIOS: _showMaterialIOS,
      icon: Icon(Icons.lock),
      initialValue: _ponyModel.password,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value == null) return 'Password is required.';
        if (value.length <= 6) return 'Must be more than 6 characters.';
        return null;
      },
      onSaved: (value) => _ponyModel.password = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.password = value;
        });
        _showSnackBar('Password', value);
      },
    );
  }

  CardSettingsEmail _buildCardSettingsEmail() {
    return CardSettingsEmail(
      showMaterialIOS: _showMaterialIOS,
      icon: Icon(Icons.person),
      initialValue: _ponyModel.email,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Email is required.';
        if (!value.contains('@'))
          return "Email not formatted correctly."; // use regex in real application
        return null;
      },
      onSaved: (value) => _ponyModel.email = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.email = value;
        });
        _showSnackBar('Email', value);
      },
    );
  }

  CardSettingsPhone _buildCardSettingsPhone() {
    return CardSettingsPhone(
      showMaterialIOS: _showMaterialIOS,
      label: 'Box Office',
      initialValue: _ponyModel.boxOfficePhone,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value != null && value.toString().length != 10)
          return 'Incomplete number';
        return null;
      },
      onSaved: (value) => _ponyModel.boxOfficePhone = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.boxOfficePhone = value;
        });
        _showSnackBar('Box Office', value);
      },
    );
  }

  CardSettingsCurrency _buildCardSettingsCurrency() {
    return CardSettingsCurrency(
      showMaterialIOS: _showMaterialIOS,
      label: 'Ticket Price',
      initialValue: _ponyModel.ticketPrice,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value != null && value > 100) return 'No scalpers allowed!';
        return null;
      },
      onSaved: (value) => _ponyModel.ticketPrice = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.ticketPrice = value;
        });
        _showSnackBar('Ticket Price', value);
      },
    );
  }

  CardSettingsTimePicker _buildCardSettingsTimePicker() {
    return CardSettingsTimePicker(
      showMaterialIOS: _showMaterialIOS,
      icon: Icon(Icons.access_time),
      label: 'Time',
      initialValue: TimeOfDay(
          hour: _ponyModel.showDateTime.hour,
          minute: _ponyModel.showDateTime.minute),
      onSaved: (value) => _ponyModel.showDateTime =
          updateJustTime(value, _ponyModel.showDateTime),
      onChanged: (value) {
        setState(() {
          _ponyModel.showDateTime =
              updateJustTime(value, _ponyModel.showDateTime);
        });
        _showSnackBar('Show Time', value);
      },
    );
  }

  CardSettingsDatePicker _buildCardSettingsDatePicker() {
    return CardSettingsDatePicker(
      showMaterialIOS: _showMaterialIOS,
      justDate: true,
      icon: Icon(Icons.calendar_today),
      label: 'Date',
      initialValue: _ponyModel.showDateTime,
      onSaved: (value) => _ponyModel.showDateTime =
          updateJustDate(value, _ponyModel.showDateTime),
      onChanged: (value) {
        setState(() {
          _ponyModel.showDateTime = value;
        });
        _showSnackBar(
            'Show Date', updateJustDate(value, _ponyModel.showDateTime));
      },
    );
  }

  CardSettingsInstructions _buildCardSettingsInstructions() {
    return CardSettingsInstructions(
      showMaterialIOS: _showMaterialIOS,
      text: 'This is when this little horse got her big break',
    );
  }

  CardSettingsInt _buildCardSettingsInt_Weight() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Weight',
      unitLabel: 'lbs',
      initialValue: _ponyModel.weight,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },
      onSaved: (value) => _ponyModel.weight = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.weight = value;
        });
        _showSnackBar('Weight', value);
      },
    );
  }

  CardSettingsDouble _buildCardSettingsDouble_Height() {
    return CardSettingsDouble(
      showMaterialIOS: _showMaterialIOS,
      label: 'Height',
      unitLabel: 'feet',
      initialValue: _ponyModel.height,
      onSaved: (value) => _ponyModel.height = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.height = value;
        });
        _showSnackBar('Height', value);
      },
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Spot() {
    return CardSettingsColorPicker(
      showMaterialIOS: _showMaterialIOS,
      label: 'Spot',
      initialValue: intelligentCast<Color>(_ponyModel.spotColor),
      visible: _ponyModel.hasSpots,
      onSaved: (value) => _ponyModel.spotColor = colorToString(value),
      onChanged: (value) {
        setState(() {
          _ponyModel.type = colorToString(value);
        });
        _showSnackBar('Spot', value);
      },
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Spots() {
    return CardSettingsSwitch(
      showMaterialIOS: _showMaterialIOS,
      label: 'Has Spots?',
      initialValue: _ponyModel.hasSpots,
      onSaved: (value) => _ponyModel.hasSpots = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.hasSpots = value;
        });
        _showSnackBar('Has Spots?', value);
      },
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Mane() {
    return CardSettingsColorPicker(
      showMaterialIOS: _showMaterialIOS,
      label: 'Mane of many colors',
      initialValue: intelligentCast<Color>(_ponyModel.maneColor),
      autovalidate: _autoValidate,
      validator: (value) {
        if (value.computeLuminance() > .7) return 'This color is too light.';
        return null;
      },
      onSaved: (value) => _ponyModel.maneColor = colorToString(value),
      onChanged: (value) {
        setState(() {
          _ponyModel.maneColor = colorToString(value);
        });
        _showSnackBar('Mane', value);
      },
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Coat() {
    return CardSettingsColorPicker(
      showMaterialIOS: _showMaterialIOS,
      label: 'Coat',
      initialValue: intelligentCast<Color>(_ponyModel.coatColor),
      autovalidate: _autoValidate,
      validator: (value) {
        if (value.computeLuminance() < .3)
          return 'This color is not cheery enough.';
        return null;
      },
      onSaved: (value) => _ponyModel.coatColor = colorToString(value),
      onChanged: (value) {
        setState(() {
          _ponyModel.coatColor = colorToString(value);
        });
        _showSnackBar('Coat', value);
      },
    );
  }

  CardSettingsMultiselect _buildCardSettingsMultiselect() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Hobbies',
      initialValues: _ponyModel.hobbies,
      options: allHobbies,
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one hobby.';

        return null;
      },
      onSaved: (value) => _ponyModel.hobbies = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.hobbies = value;
        });
        _showSnackBar('Hobbies', value);
      },
    );
  }

  CardSettingsParagraph _buildCardSettingsParagraph(int lines) {
    return CardSettingsParagraph(
      showMaterialIOS: _showMaterialIOS,
      label: 'Description',
      initialValue: _ponyModel.description,
      numberOfLines: lines,
      onSaved: (value) => _ponyModel.description = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.description = value;
        });
        _showSnackBar('Description', value);
      },
    );
  }

  CardSettingsNumberPicker _buildCardSettingsNumberPicker(
      {TextAlign labelAlign}) {
    return CardSettingsNumberPicker(
      showMaterialIOS: _showMaterialIOS,
      label: 'Age',
      labelAlign: labelAlign,
      initialValue: _ponyModel.age,
      min: 1,
      max: 30,
      validator: (value) {
        if (value == null) return 'Age is required.';
        if (value > 20) return 'No grown-ups allwed!';
        if (value < 3) return 'No Toddlers allowed!';
        return null;
      },
      onSaved: (value) => _ponyModel.age = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.age = value;
        });
        _showSnackBar('Age', value);
      },
    );
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Type() {
    return CardSettingsListPicker(
      showMaterialIOS: _showMaterialIOS,
      label: 'Type',
      initialValue: _ponyModel.type,
      hintText: 'Select One',
      autovalidate: _autoValidate,
      options: <String>['Earth', 'Unicorn', 'Pegasi', 'Alicorn'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.type = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.type = value;
        });
        _showSnackBar('Type', value);
      },
    );
  }

  CardSettingsText _buildCardSettingsText_Name() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Name',
      hintText: 'something cute...',
      initialValue: _ponyModel.name,
      requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Name is required.';
        return null;
      },
      showErrorIOS: _ponyModel.name == null || _ponyModel.name.isEmpty,
      onSaved: (value) => _ponyModel.name = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.name = value;
        });
        _showSnackBar('Name', value);
      },
    );
  }

  CardSettingsSlider _buildCardSettingsDouble_Slider() {
    return CardSettingsSlider(
      showMaterialIOS: _showMaterialIOS,
      label: 'Rating',
      initialValue: _ponyModel.rating,
      autovalidate: _autoValidate,
      validator: (double value) {
        if (value == null) return 'You must pick a rating.';
        return null;
      },
      onSaved: (value) => _ponyModel.rating = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.rating = value;
        });
        _showSnackBar('Rating', value);
      },
    );
  }

  /* EVENT HANDLERS */

  Future _savePressed() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      showResults(context, _ponyModel);
    } else {
      setState(() => _autoValidate = true);
    }
  }

  void _resetPressed() {
    _formKey.currentState.reset();
  }

  void _showSnackBar(String label, dynamic value) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text(label + ' = ' + value.toString()),
      ),
    );
  }
}