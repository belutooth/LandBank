import 'dart:async';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:the_gorgeous_login/ui/page/land/addland/result.dart';
import 'package:the_gorgeous_login/ui/page/land/fisikdataland/fisik_model.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class FisikLand extends StatefulWidget {
  @override
  _FisikLandState createState() => _FisikLandState();
}

class _FisikLandState extends State<FisikLand> {
  final _ponyModel = FisikModel();

  // once the form submits, this is flipped to true, and fields can then go into autovalidate mode.
  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient

  bool _showMaterialIOS = false;

  TextEditingController _bangunan;
  TextEditingController _namaCBD;
  TextEditingController _panjang;
  TextEditingController _lebar;
  TextEditingController _luas;
  TextEditingController _kodepos;
  TextEditingController _lat;
  TextEditingController _long;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Data Fisik", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
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
            )
                : null,
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
            label: 'Kategori Lahan',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _kategoriLahan(),
            _jenisTanah()
          ],
        ),
        CardSettingsSection(
          showMaterialIOS: _showMaterialIOS,
          header: CardSettingsHeader(
            label: 'Kondisi Lahan dan Sumber Data',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _kondisiLahan(),
            _penggunaanSaatIni(),
            _bangunanLahan(3),
            _bentukTanah(),
            _batasUtara(),
            _batasSelatan(),
            _batasTimur(),
            _batasBarat(),
            _arahPosisiTanah(),
            _kondisiLingkungan(),
            _populasiDisekitarLahan(),
            _topografiKontur(),
            _topografiElevasi(),
            _sumberData()
          ],
        ),
        CardSettingsSection(
          showMaterialIOS: _showMaterialIOS,
          header: CardSettingsHeader(
            label: 'Ukuran Tanah',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _ukuranP(),
            _ukuranL(),
            _ukuranLuas(),
            _lebarDepan()
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

  CardSettingsListPicker _kategoriLahan() {
    return CardSettingsListPicker(
      label: 'Kategori Lahan',
      hintText: 'Select One',
      initialValue: _ponyModel.kategoriLahan,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Tanah Kosong', 'Tanah Sawah', 'Tanah Tambang', 'Tanah Berikut Bangunan',
      'Kavling Siap Bangun', 'Tanah Pekarangan', 'Tanah Tambak', 'Tanah Rawa', 'Tanah Perkebunan',
      'Tanah Pasang Surut', 'Tanah Gambut'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.kategoriLahan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kategoriLahan = value;
        });
        _showSnackBar('Type', value);
      },
    );
  }

  CardSettingsMultiselect _jenisTanah() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jenis Tanah',
      initialValues: _ponyModel.jenisTanah,
      options: <String>['Tanah Aluvial', 'Tanah Humus', 'Tanah Kapur', 'Tanah Podzolik', 'Tanah Vulkanis',
      'Tanah Organosol', 'Tanah Pasir', 'Tanah Laterit'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.jenisTanah = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jenisTanah = value;
        });
        _showSnackBar('Jenis Tanah', value);
      },
    );
  }

  CardSettingsListPicker _kondisiLahan() {
    return CardSettingsListPicker(
      label: 'Kondisi Lahan',
      hintText: 'Select One',
      initialValue: _ponyModel.kondisiLahan,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Tanah Matang(Siap Pakai)', 'Tanah Mentah (Butuh Penyiapan Lahan)'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.kondisiLahan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kondisiLahan = value;
        });
        _showSnackBar('Kondisi Lahan', value);
      },
    );
  }

  CardSettingsListPicker _penggunaanSaatIni() {
    return CardSettingsListPicker(
      label: 'Penggunaan Saat Ini',
      hintText: 'Select One',
      initialValue: _ponyModel.penggunaanSaatIni,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Sesuai Peruntukan','Tidak Sesuai Peruntukan', 'Belum Digunakan', 'Lainnya'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.kondisiLahan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kondisiLahan = value;
        });
        _showSnackBar('Kondisi Lahan', value);
      },
    );
  }

  CardSettingsParagraph _bangunanLahan(int lines) {
    return CardSettingsParagraph(
      showMaterialIOS: _showMaterialIOS,
      label: 'Bangunan diatas Lahan',
      controller: _bangunan,
      initialValue: _ponyModel.bangunan,
      numberOfLines: lines,
      onSaved: (value) => _ponyModel.bangunan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.bangunan = value;
        });
        _showSnackBar('Jalan', value);
      },
    );
  }

  CardSettingsListPicker _bentukTanah() {
    return CardSettingsListPicker(
      label: 'Bentuk Tanah',
      hintText: 'Select One',
      initialValue: _ponyModel.bentukTanah,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Bujur Sangkar', 'Persegi Panjang', 'Trapesium', 'Jajaran Genjang', 'Belah Ketupat', 'Tidak Beraturan'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.bentukTanah = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.bentukTanah = value;
        });
        _showSnackBar('Bentuk Tanah', value);
      },
    );
  }

  CardSettingsInt _ukuranP() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Panjang',
      unitLabel: 'm',
      initialValue: _ponyModel.panjang,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.panjang = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.panjang = value;
          _ponyModel.luas = value*_ponyModel.lebar;
          _luas = new TextEditingController(text: _ponyModel.luas.toString());
        });
        _showSnackBar('Panjang', value);
      },
    );
  }

  CardSettingsInt _ukuranL() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Lebar',
      unitLabel: 'm',
      initialValue: _ponyModel.lebar,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.lebar = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.lebar = value;
          _ponyModel.luas = value*_ponyModel.panjang;
          _luas = new TextEditingController(text: _ponyModel.luas.toString());
        });
        _showSnackBar('Lebar', value);
      },
    );
  }

  CardSettingsInt _ukuranLuas() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Luas',
      enabled: false,
      unitLabel: 'm',
      controller: _luas,
      initialValue: _ponyModel.lebar * _ponyModel.panjang,
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
        _showSnackBar('Luas', value);
      },
    );
  }

  CardSettingsInt _lebarDepan() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Lebar Depan',
      unitLabel: 'm',
      initialValue: _ponyModel.lebarDepan,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.lebarDepan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.lebarDepan = value;
        });
        _showSnackBar('Lebar Depan', value);
      },
    );
  }

  CardSettingsText _batasUtara() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Batas Utara',
      hintText: 'batas utara',
      initialValue: _ponyModel.batasUtara,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'batas required.';
        return null;
      },
      showErrorIOS: _ponyModel.batasUtara == null || _ponyModel.batasUtara.isEmpty,
      onSaved: (value) => _ponyModel.batasUtara = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.batasUtara = value;
        });
        _showSnackBar('Batas Utara', value);
      },
    );
  }

  CardSettingsText _batasSelatan() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Batas Selatan',
      hintText: 'batas selatan',
      initialValue: _ponyModel.batasSelatan,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'batas required.';
        return null;
      },
      showErrorIOS: _ponyModel.batasSelatan == null || _ponyModel.batasSelatan.isEmpty,
      onSaved: (value) => _ponyModel.batasSelatan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.batasSelatan = value;
        });
        _showSnackBar('Batas Selatan', value);
      },
    );
  }

  CardSettingsText _batasTimur() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Batas Timur',
      hintText: 'batas timur',
      initialValue: _ponyModel.batasTimur,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'batas required.';
        return null;
      },
      showErrorIOS: _ponyModel.batasTimur == null || _ponyModel.batasTimur.isEmpty,
      onSaved: (value) => _ponyModel.batasTimur = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.batasTimur = value;
        });
        _showSnackBar('Batas Timur', value);
      },
    );
  }

  CardSettingsText _batasBarat() {
    return CardSettingsText(
      showMaterialIOS: _showMaterialIOS,
      label: 'Batas Barat',
      hintText: 'batas barat',
      initialValue: _ponyModel.batasBarat,
      //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      validator: (value) {
        if (value == null || value.isEmpty) return 'batas required.';
        return null;
      },
      showErrorIOS: _ponyModel.batasBarat == null || _ponyModel.batasBarat.isEmpty,
      onSaved: (value) => _ponyModel.batasBarat = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.batasBarat = value;
        });
        _showSnackBar('Batas Barat', value);
      },
    );
  }

  CardSettingsListPicker _arahPosisiTanah() {
    return CardSettingsListPicker(
      label: 'Arah Posisi Tanah',
      hintText: 'Select One',
      initialValue: _ponyModel.arahPosisi,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Utara', 'Timur Laut', 'Timur', 'Tenggara', 'Selatan', 'Barat Daya', 'Barat', 'Barat Laut'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.arahPosisi = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.arahPosisi = value;
        });
        _showSnackBar('Arah Posisi Tanah', value);
      },
    );
  }

  CardSettingsListPicker _sumberData() {
    return CardSettingsListPicker(
      label: 'Sumber Data Peruntukan Lahan',
      hintText: 'Select One',
      initialValue: _ponyModel.sumberData,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['RUTR', 'Peta Zoning BPN', 'Peta Zoning Pemda', 'Pengamatan Petugas Survei', 'Lainnya'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.sumberData = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.sumberData = value;
        });
        _showSnackBar('Sumber Data', value);
      },
    );
  }

  CardSettingsListPicker _kondisiLingkungan() {
    return CardSettingsListPicker(
      label: 'Kondisi Lingkungan',
      hintText: 'Select One',
      initialValue: _ponyModel.kondisiLingkungan,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Elite', 'Menengah', 'Kumuh', 'Lainnya'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.kondisiLingkungan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kondisiLingkungan = value;
        });
        _showSnackBar('Kondisi Lingkungan', value);
      },
    );
  }

  CardSettingsListPicker _populasiDisekitarLahan() {
    return CardSettingsListPicker(
      label: 'Populasi disekitar Lahan',
      hintText: 'Select One',
      initialValue: _ponyModel.populasiSekitar,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Padat','Sedang/Jarang','Sepi'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.populasiSekitar = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.populasiSekitar = value;
        });
        _showSnackBar('Populasi Sekitar', value);
      },
    );
  }

  CardSettingsListPicker _topografiKontur() {
    return CardSettingsListPicker(
      label: 'Topografi Kontur Lahan',
      hintText: 'Select One',
      initialValue: _ponyModel.topografiKontur,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Datar','Terasering','Bergelombang','Miring-Menurun','Miring-Mendaki'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.topografiKontur = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.topografiKontur = value;
        });
        _showSnackBar('Topografi Kontur', value);
      },
    );
  }

  CardSettingsListPicker _topografiElevasi() {
    return CardSettingsListPicker(
      label: 'Topografi Elevasi Lahan',
      hintText: 'Select One',
      initialValue: _ponyModel.topografiElevasi,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Lebih Tinggi','Lebih Rendah','Sebagian Lebih Tinggi dan Sebagian Lebih Rendah', 'Sama Dengan Jalan'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.topografiElevasi = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.topografiElevasi = value;
        });
        _showSnackBar('Topografi Kontur', value);
      },
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
      //showResults(context, _ponyModel);
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