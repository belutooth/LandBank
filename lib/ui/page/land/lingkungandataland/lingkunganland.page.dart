import 'dart:async';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:the_gorgeous_login/ui/page/land/addland/result.dart';
import 'package:the_gorgeous_login/ui/page/land/lingkungandataland/lingkungan_model.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class LingkunganLand extends StatefulWidget {
  @override
  _LingkunganLandState createState() => _LingkunganLandState();
}

class _LingkunganLandState extends State<LingkunganLand> {
  final _ponyModel = LingkunganModel();

  // once the form submits, this is flipped to true, and fields can then go into autovalidate mode.
  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient

  bool _showMaterialIOS = false;

  bool v_bencana = false;
  bool v_sutet = false;
  bool v_gardu = false;
  bool v_reaktor = false;
  bool v_spbu = false;
  bool v_tempatSampah = false;
  bool v_menara = false;
  bool v_jalurMigas = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Data Lingkungan", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
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
            label: 'Informasi Lingkungan',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _kualitasAir(),
            _kualitasUdara(),
            _intensitasKebisingan(),
            _sumberKebisingan(),
            _jaringanListrik(),
            _jaringanTelepon()
          ],
        ),
        CardSettingsSection(
          showMaterialIOS: _showMaterialIOS,
          header: CardSettingsHeader(
            label: 'Potensi Bencana',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _kerawananBencana(),
            _jenisBencana(),
            _intensitasBencana(),
            _sutet(),
            _jarakSutet(),
            _garduPLN(),
            _jarakGardu(),
            _reaktor(),
            _jarakReaktor(),
            _spbu(),
            _jarakSPBU(),
            _tempatSampah(),
            _jarakTempatSampah(),
            _menara(),
            _jarakMenara(),
            _migas(),
            _jarakJalurMigas()
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

  CardSettingsListPicker _kualitasAir() {
    return CardSettingsListPicker(
      label: 'Kualitas Air Tanah',
      hintText: 'Select One',
      initialValue: _ponyModel.kualitasAir,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Layak Konsumsi', 'Kurang Layak Konsumsi', 'Tidak Layak Konsumsi'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.kualitasAir = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kualitasAir = value;
        });
        _showSnackBar('Kualitas Air', value);
      },
    );
  }

  CardSettingsListPicker _kualitasUdara() {
    return CardSettingsListPicker(
      label: 'Kualitas Udara',
      hintText: 'Select One',
      initialValue: _ponyModel.kualitasUdara,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Baik', 'Sedang', 'Tidak Sehat', 'Sangat Tidak Sehat', 'Berbahaya'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.kualitasUdara = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kualitasUdara = value;
        });
        _showSnackBar('Kualitas Udara', value);
      },
    );
  }

  CardSettingsListPicker _intensitasKebisingan() {
    return CardSettingsListPicker(
      label: 'Intensitas Kebisingan',
      hintText: 'Select One',
      initialValue: _ponyModel.intensitasKebisingan,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Tenang', 'Sedang', 'Bising'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.intensitasKebisingan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.intensitasKebisingan = value;
        });
        _showSnackBar('Intensitas Kebisingan', value);
      },
    );
  }

  CardSettingsMultiselect _sumberKebisingan() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Sumber Kebisingan',
      initialValues: _ponyModel.sumberKebisingan,
      options: <String>['Jalan Raya', 'Jalan Tol', 'Kereta Api',
      'Pesawat Udara', 'Pabrik', 'Kantor', 'Pasar', 'Lainnya'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.sumberKebisingan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.sumberKebisingan = value;
        });
        _showSnackBar('Sumber Kebisingan', value);
      },
    );
  }

  CardSettingsListPicker _jaringanListrik() {
    return CardSettingsListPicker(
      label: 'Jaringan Listrik',
      hintText: 'Select One',
      initialValue: _ponyModel.jaringanListrik,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Jaringan Udara', 'Jaringan Bawah Tanah', 'Tidak Ada'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.jaringanListrik = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jaringanListrik = value;
        });
        _showSnackBar('Jaringan Listrik', value);
      },
    );
  }

  CardSettingsListPicker _jaringanTelepon() {
    return CardSettingsListPicker(
      label: 'Jaringan Telepon',
      hintText: 'Select One',
      initialValue: _ponyModel.jaringanTelepon,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Jaringan Udara', 'Jaringan Bawah Tanah', 'Tidak Ada'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.jaringanTelepon = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jaringanTelepon = value;
        });
        _showSnackBar('Jaringan Telepon', value);
      },
    );
  }

  CardSettingsListPicker _kerawananBencana() {
    return CardSettingsListPicker(
      label: 'Kerawanan Bencana',
      hintText: 'Select One',
      initialValue: _ponyModel.kerawananBencana,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Ya', 'Tidak'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.kerawananBencana = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kerawananBencana = value;
          if(value == 'Ya') v_bencana = true;
          else if(value == 'Tidak') v_bencana = false;
        });
        _showSnackBar('Kerawanan Bencana', value);
      },
    );
  }

  CardSettingsMultiselect _jenisBencana() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jenis Bencana',
      initialValues: _ponyModel.jenisBencana,
      options: <String>['Banjir', 'Banjir Rob', 'Banjir Bandang', 'Longsor', 'Angin/Badai',
      'Letusan Gunung Berapi', 'Pemanasan', 'Kekeringan', 'Kebakaran Hutan', 'Gempa', 'Tanah Retak/Gerak/Ambles'],
      autovalidate: _autoValidate,
      visible: v_bencana,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';
        return null;
      },
      onSaved: (value) => _ponyModel.jenisBencana = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jenisBencana = value;
        });
        _showSnackBar('Jenis Bencana', value);
      },
    );
  }

  CardSettingsListPicker _intensitasBencana() {
    return CardSettingsListPicker(
      label: 'Intensitas Bencana',
      hintText: 'Select One',
      initialValue: _ponyModel.intensitasBencana,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      visible: v_bencana,
      options: <String>['Sering(<=1 Tahun)', 'Sedang(>1 Tahun sd 2 Tahun)', 'Jarang(>=2 Tahun)'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.intensitasBencana = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.intensitasBencana = value;
        });
        _showSnackBar('Intensitas Bencana', value);
      },
    );
  }

  CardSettingsListPicker _sutet() {
    return CardSettingsListPicker(
      label: 'Dekat SUTET',
      hintText: 'Select One',
      initialValue: _ponyModel.dekatSutet,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Ya', 'Tidak'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.dekatSutet = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.dekatSutet = value;
          if(value == 'Ya') v_sutet = true;
          else if(value == 'Tidak') v_sutet = false;
        });
        _showSnackBar('Dekat Sutet', value);
      },
    );
  }

  CardSettingsInt _jarakSutet() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jarak ke SUTET',
      unitLabel: 'm',
      initialValue: _ponyModel.jarakSutet,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      visible: v_sutet,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.jarakSutet = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jarakSutet = value;
        });
        _showSnackBar('Jarak ke SUTET', value);
      },
    );
  }

  CardSettingsListPicker _garduPLN() {
    return CardSettingsListPicker(
      label: 'Dekat Gardu PLN',
      hintText: 'Select One',
      initialValue: _ponyModel.garduPln,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Ya', 'Tidak'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.dekatSutet = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.garduPln = value;
          if(value == 'Ya') v_gardu = true;
          else if(value == 'Tidak') v_gardu = false;
        });
        _showSnackBar('Dekat Gardu PLN', value);
      },
    );
  }

  CardSettingsInt _jarakGardu() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jarak ke Gardu PLN',
      unitLabel: 'm',
      initialValue: _ponyModel.jarakGarduPln,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      visible: v_gardu,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.jarakGarduPln = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jarakGarduPln = value;
        });
        _showSnackBar('Jarak ke Gardu PLN', value);
      },
    );
  }

  CardSettingsListPicker _reaktor() {
    return CardSettingsListPicker(
      label: 'Dekat Reaktor Nuklir',
      hintText: 'Select One',
      initialValue: _ponyModel.reaktorNuklir,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Ya', 'Tidak'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.reaktorNuklir = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.reaktorNuklir = value;
          if(value == 'Ya') v_reaktor = true;
          else if(value == 'Tidak') v_reaktor = false;
        });
        _showSnackBar('Dekat Reaktor Nuklir', value);
      },
    );
  }

  CardSettingsInt _jarakReaktor() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jarak ke Reaktor Nuklir',
      unitLabel: 'm',
      initialValue: _ponyModel.jarakReaktorNuklir,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      visible: v_reaktor,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.jarakReaktorNuklir = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jarakReaktorNuklir = value;
        });
        _showSnackBar('Jarak ke Reaktor Nuklir', value);
      },
    );
  }

  CardSettingsListPicker _spbu() {
    return CardSettingsListPicker(
      label: 'Dekat SPBU',
      hintText: 'Select One',
      initialValue: _ponyModel.spbu,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Ya', 'Tidak'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.spbu = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.spbu = value;
          if(value == 'Ya') v_spbu = true;
          else if(value == 'Tidak') v_spbu = false;
        });
        _showSnackBar('Dekat SPBU', value);
      },
    );
  }

  CardSettingsInt _jarakSPBU() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jarak ke SPBU',
      unitLabel: 'm',
      initialValue: _ponyModel.jarakSpbu,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      visible: v_spbu,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.jarakSpbu = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jarakSpbu = value;
        });
        _showSnackBar('Jarak ke SPBU', value);
      },
    );
  }

  CardSettingsListPicker _tempatSampah() {
    return CardSettingsListPicker(
      label: 'Dekat Tempat Sampah',
      hintText: 'Select One',
      initialValue: _ponyModel.tempatSampah,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Ya', 'Tidak'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.tempatSampah = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.tempatSampah = value;
          if(value == 'Ya') v_tempatSampah = true;
          else if(value == 'Tidak') v_tempatSampah = false;
        });
        _showSnackBar('Dekat Tempat Sampah', value);
      },
    );
  }

  CardSettingsInt _jarakTempatSampah() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jarak ke Tempat Sampah',
      unitLabel: 'm',
      initialValue: _ponyModel.jarakTempatSampah,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      visible: v_tempatSampah,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.jarakTempatSampah = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jarakTempatSampah = value;
        });
        _showSnackBar('Jarak ke Tempat Sampah', value);
      },
    );
  }

  CardSettingsListPicker _menara() {
    return CardSettingsListPicker(
      label: 'Dekat Menara/Tower',
      hintText: 'Select One',
      initialValue: _ponyModel.menara,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Ya', 'Tidak'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.menara = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.menara = value;
          if(value == 'Ya') v_menara = true;
          else if(value == 'Tidak') v_menara = false;
        });
        _showSnackBar('Dekat Sutet', value);
      },
    );
  }

  CardSettingsInt _jarakMenara() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jarak ke Menara/Tower',
      unitLabel: 'm',
      initialValue: _ponyModel.jarakMenara,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      visible: v_menara,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.jarakMenara = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jarakMenara = value;
        });
        _showSnackBar('Jarak ke Menara/Tower', value);
      },
    );
  }

  CardSettingsListPicker _migas() {
    return CardSettingsListPicker(
      label: 'Dekat Jalur Minyak dan Gas',
      hintText: 'Select One',
      initialValue: _ponyModel.jalurMinyakGas,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Ya', 'Tidak'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.jalurMinyakGas = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jalurMinyakGas = value;
          if(value == 'Ya') v_jalurMigas = true;
          else if(value == 'Tidak') v_jalurMigas = false;
        });
        _showSnackBar('Dekat Jalur Migas', value);
      },
    );
  }

  CardSettingsInt _jarakJalurMigas() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jarak ke Jalur Migas',
      unitLabel: 'm',
      initialValue: _ponyModel.jarakJalurMinyakGas,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      visible: v_jalurMigas,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.jarakJalurMinyakGas = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jarakJalurMinyakGas = value;
        });
        _showSnackBar('Jarak ke Jalur Migas', value);
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