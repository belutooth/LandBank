import 'dart:async';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:the_gorgeous_login/ui/page/land/addland/result.dart';
import 'package:the_gorgeous_login/ui/page/land/saranadataland/sarana_model.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class SaranaLand extends StatefulWidget {
  @override
  _SaranaLandState createState() => _SaranaLandState();
}

class _SaranaLandState extends State<SaranaLand> {
  final _ponyModel = SaranaModel();

  // once the form submits, this is flipped to true, and fields can then go into autovalidate mode.
  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient

  bool _showMaterialIOS = false;

  TextEditingController _jalan;
  TextEditingController _namaCBD;
  TextEditingController _kec;
  TextEditingController _kab;
  TextEditingController _prov;
  TextEditingController _kodepos;
  TextEditingController _lat;
  TextEditingController _long;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Data Sarana", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
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
            label: 'Sarana Jalan dan Fasilitas Umum',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _jalanBesar(3),
            _jarakJalanUtama(),
            _aksesLokasi(),
            _angkutanUmum(),
            _jarakAngkutanUmum(),
            _lebarJalan(),
            _statusJalan(),
            _arusLaluLintas(),
            _kontruksiJalan(),
            _kondisiJalan(),
            _kategoriLokasi(),
            _fasilitasUmum(),
            _fasilitasSosial(),
            _kategoriLokasi(),
            _sumberAir()
          ],
        ),
        CardSettingsSection(
          showMaterialIOS: _showMaterialIOS,
          header: CardSettingsHeader(
            label: 'Pusat Bisnis(CBD) dan Rekreasi Terdekat',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _namaKawasanCBD(2),
            _jarakCBD(),
            _saranaBisnis(),
            _saranaRekreasi()
          ],
        ),
        CardSettingsSection(
          showMaterialIOS: _showMaterialIOS,
          header: CardSettingsHeader(
            label: 'Sarana Kesahatan dan Ibadah',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _saranaKesehatan(),
            _saranaIbadah()
          ],
        ),
        CardSettingsSection(
          showMaterialIOS: _showMaterialIOS,
          header: CardSettingsHeader(
            label: 'Sarana Pendidikan dan Olahraga',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _saranaPendidikan(),
            _saranaOlahraga()
          ],
        ),
        CardSettingsSection(
          showMaterialIOS: _showMaterialIOS,
          header: CardSettingsHeader(
            label: 'Sarana Keamanan dan Kebersihan',
            showMaterialIOS: _showMaterialIOS,
          ),
          children: <Widget>[
            _saranaKeamanan(),
            _kantorPolisiTerdekat(2),
            _jarakKantorPolisi(),
            _kriteriaKeamanan(),
            _saranaKebersihan(),
            _kriteriaKebersihan()
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

  CardSettingsListPicker _angkutanUmum() {
    return CardSettingsListPicker(
      label: 'Bentuk Pemanfaatan',
      hintText: 'Select One',
      initialValue: _ponyModel.angkutanUmum,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Sangat Baik', 'Baik', 'Cukup', 'Kurang'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.angkutanUmum = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.angkutanUmum = value;
        });
        _showSnackBar('Type', value);
      },
    );
  }

  CardSettingsInt _jarakJalanUtama() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jarak Jalan Utama',
      unitLabel: 'm',
      initialValue: _ponyModel.jarakJalan,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.jarakJalan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jarakJalan = value;
        });
        _showSnackBar('Jarak Jalan', value);
      },
    );
  }

  CardSettingsInt _jarakAngkutanUmum() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jarak ke Angkutan Umum',
      unitLabel: 'm',
      initialValue: _ponyModel.jarakAngkutanUmum,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.jarakAngkutanUmum = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jarakAngkutanUmum = value;
        });
        _showSnackBar('Jarak Angkutan', value);
      },
    );
  }

  CardSettingsInt _lebarJalan() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Lebar Jalan',
      unitLabel: 'm',
      initialValue: _ponyModel.lebarJalan,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.lebarJalan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.lebarJalan = value;
        });
        _showSnackBar('Lebar Jalan', value);
      },
    );
  }

  CardSettingsListPicker _statusJalan() {
    return CardSettingsListPicker(
      label: 'Status Jalan',
      hintText: 'Select One',
      initialValue: _ponyModel.statusJalan,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Sangat Baik', 'Baik', 'Cukup', 'Kurang'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.statusJalan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.statusJalan = value;
        });
        _showSnackBar('Status Jalan', value);
      },
    );
  }

  CardSettingsListPicker _arusLaluLintas() {
    return CardSettingsListPicker(
      label: 'Arus Lalu Lintas',
      hintText: 'Select One',
      initialValue: _ponyModel.arusLaluLintas,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['1 Arah', '2 Arah dengan Separator', '2 Arah tanpa Separator'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.arusLaluLintas = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.arusLaluLintas = value;
        });
        _showSnackBar('Arus Lalu Lintas', value);
      },
    );
  }

  CardSettingsListPicker _kontruksiJalan() {
    return CardSettingsListPicker(
      label: 'Kontruksi Jalan',
      hintText: 'Select One',
      initialValue: _ponyModel.kontruksiJalan,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Aspal', 'Paving', 'Beton', 'Rabat', 'Tanah', 'Pasir Batu', 'Lainnya'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.kontruksiJalan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kontruksiJalan = value;
        });
        _showSnackBar('Kontruksi Jalan', value);
      },
    );
  }

  CardSettingsListPicker _kondisiJalan() {
    return CardSettingsListPicker(
      label: 'Kondisi Jalan',
      hintText: 'Select One',
      initialValue: _ponyModel.kondisiJalan,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Baik', 'Sedang', 'Jelek/Rusak'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.kondisiJalan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kondisiJalan = value;
        });
        _showSnackBar('Kondisi Jalan', value);
      },
    );
  }

  CardSettingsMultiselect _fasilitasUmum() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Fasilitas Umum',
      initialValues: _ponyModel.fasilitasUmum,
      options: <String>['Listrik', 'Air Bersih', 'Jaringan Gas', 'Telkom/PSTN', 'Telepon GSM', 'TV Kabel',
      'Free WIFI', 'Taman', 'Internet Kabel', 'Jalur Pejalan Kaki', 'Jalur Sepeda', 'Pembuangan Sampah',
      'Saluran Limbah', 'Pemakaman'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.fasilitasUmum = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.fasilitasUmum = value;
        });
        _showSnackBar('Fasilitas Umum', value);
      },
    );
  }

  CardSettingsMultiselect _fasilitasSosial() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Akses ke Lokasi',
      initialValues: _ponyModel.fasilitasSosial,
      options: <String>['Tempat/Taman Bermain', 'Gedung/Balai Pertemuan', 'Panti Jompo', 'Panti Asuhan'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.fasilitasSosial = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.fasilitasSosial = value;
        });
        _showSnackBar('Fasilitas Sosial', value);
      },
    );
  }

  CardSettingsListPicker _kategoriLokasi() {
    return CardSettingsListPicker(
      label: 'Kategori Lokasi',
      hintText: 'Select One',
      initialValue: _ponyModel.kategoriLokasi,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Dalam Kota', 'Luar/Pinggiran Kota', 'Desa'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.kategoriLokasi = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kategoriLokasi = value;
        });
        _showSnackBar('Kategori Lokasi', value);
      },
    );
  }

  CardSettingsListPicker _sumberAir() {
    return CardSettingsListPicker(
      label: 'Sumber Air',
      hintText: 'Select One',
      initialValue: _ponyModel.sumberAir,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Air Tanah', 'Mata Air', 'Perusahaan Air Minum'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.sumberAir = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.sumberAir = value;
        });
        _showSnackBar('Sumber Air', value);
      },
    );
  }

 /* CardSettingsText _namaPemilik() {
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
*/
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

  CardSettingsMultiselect _aksesLokasi() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Akses ke Lokasi',
      initialValues: _ponyModel.aksesLokasi,
      options: <String>['Bis Kota', 'Bis Antar Kota', 'Mikrolet', 'Minibus', 'Busway', 'Kereta Api',
      'Monorel', 'KRL/LRT', 'Taksi', 'Becak', 'Lain-Lain'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.aksesLokasi = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.aksesLokasi = value;
        });
        _showSnackBar('Akses Lokasi', value);
      },
    );
  }

  CardSettingsParagraph _namaKawasanCBD(int lines) {
    return CardSettingsParagraph(
      showMaterialIOS: _showMaterialIOS,
      label: 'Nama Kawasan CBD',
      controller: _namaCBD,
      initialValue: _ponyModel.namaKawasanCBD,
      numberOfLines: lines,
      onSaved: (value) => _ponyModel.namaKawasanCBD = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.namaKawasanCBD = value;
        });
        _showSnackBar('Nama Kawasan CBD', value);
      },
    );
  }

  CardSettingsInt _jarakCBD() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jarak ke CBD',
      unitLabel: 'km',
      initialValue: _ponyModel.jarakCBD,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.jarakCBD = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jarakCBD = value;
        });
        _showSnackBar('Jarak ke CBD', value);
      },
    );
  }

  CardSettingsMultiselect _saranaBisnis() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Sarana Bisnis',
      initialValues: _ponyModel.saranaBisnis,
      options: <String>['Mall', 'Plaza', 'Minimarket 24 Jam', 'Minimarket', 'Pasar Modern', 'Pasar Tradisional',
      'Kios/Grosir', 'Toko/Warung'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.saranaBisnis = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.saranaBisnis = value;
        });
        _showSnackBar('Sarana Bisnis', value);
      },
    );
  }

  CardSettingsMultiselect _saranaRekreasi() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Sarana Rekreasi',
      initialValues: _ponyModel.saranaRekreasi,
      options: <String>['Wisata Alam', 'Wisata Buatan', 'Wisata Budaya', 'Wisata Kuliner', 'Lainnya'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.saranaRekreasi = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.saranaRekreasi = value;
        });
        _showSnackBar('Sarana Rekreasi', value);
      },
    );
  }

  CardSettingsMultiselect _saranaKesehatan() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Sarana Kesehatan',
      initialValues: _ponyModel.saranaKesehatan,
      options: <String>['Puskesmas Rawat Inap', 'Puskesmas Non Rawat Inap', 'Praktik Dokter Umum',
      'Praktik Dokter Spesialis', 'Praktik Dokter Gigi', 'Klinik Kesehatan', 'Klinik Kesehatan 24 Jam',
      'Klinik Kesehatan Gigi', 'Rumah Sakit Umum', 'Rumah Sakit Ibu dan Anak', 'Rumah Sakit Bersalin',
      'Apotek', 'Kios Obat', 'Apotek 24 Jam'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.saranaKesehatan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.saranaKesehatan = value;
        });
        _showSnackBar('Sarana Kesehatan', value);
      },
    );
  }

  CardSettingsMultiselect _saranaIbadah() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Sarana Ibadah',
      initialValues: _ponyModel.saranaIbadah,
      options: <String>['Masjid', 'Musholla', 'Gereja', 'Wihara', 'Kapel', 'Pura', 'Klenteng'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.saranaIbadah = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.saranaIbadah = value;
        });
        _showSnackBar('Sarana Ibadah', value);
      },
    );
  }

  CardSettingsMultiselect _saranaPendidikan() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Sarana Pendidikan',
      initialValues: _ponyModel.saranaPendidikan,
      options: <String>['PAUD', 'KB', 'TK', 'SD', 'SMP', 'SMU/SMK', 'Akademi', 'Politeknik',
      'PTN/PTS', 'Home Schooling', 'Pesantren', 'Kursus', 'Les/Privat', 'Bimbingan Belajar', 'Lainnya'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.saranaPendidikan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.saranaPendidikan = value;
        });
        _showSnackBar('Sarana Pendidikan', value);
      },
    );
  }

  CardSettingsMultiselect _saranaOlahraga() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Sarana Olahraga',
      initialValues: _ponyModel.saranaOlahraga,
      options: <String>['Jogging Track', 'Kolam Renang', 'Lapangan Tenis', 'Lapangan Bulu Tangkis',
      'Lapangan Basket', 'Lapangan Golf', 'Driving Range', 'Fitness Center', 'Sport Club/Center',
      'Lapangan Futsal', 'Lapangan Sepak Bola', 'Lainnya'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.saranaOlahraga = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.saranaIbadah = value;
        });
        _showSnackBar('Sarana Olah Raga', value);
      },
    );
  }

  CardSettingsMultiselect _saranaKeamanan() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Fasilitas Keamanan',
      initialValues: _ponyModel.saranaKeamanan,
      options: <String>['CCTV', 'Cluster', 'Jaga Malam Oleh Satpam/Hansip', 'Satpam/Hansip 24 Jam',
      'Siskamling', 'Lainnya'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.saranaKeamanan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.saranaKeamanan = value;
        });
        _showSnackBar('Fasilitas Keamanan', value);
      },
    );
  }

  CardSettingsParagraph _kantorPolisiTerdekat(int lines) {
    return CardSettingsParagraph(
      showMaterialIOS: _showMaterialIOS,
      label: 'Kantor Polisi Terdekat',
      controller: _namaCBD,
      initialValue: _ponyModel.kantorPolisiTerdekat,
      numberOfLines: lines,
      onSaved: (value) => _ponyModel.kantorPolisiTerdekat = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kantorPolisiTerdekat = value;
        });
        _showSnackBar('Kantor Polisi Terdekat', value);
      },
    );
  }

  CardSettingsInt _jarakKantorPolisi() {
    return CardSettingsInt(
      showMaterialIOS: _showMaterialIOS,
      label: 'Jarak ke Kantor Polisi',
      unitLabel: 'm',
      initialValue: _ponyModel.jarakKantorPolisi,
      autovalidate: _autoValidate,
      contentAlign: TextAlign.right,
      /*validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },*/
      onSaved: (value) => _ponyModel.jarakKantorPolisi = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.jarakKantorPolisi = value;
        });
        _showSnackBar('Jarak ke Kantor Polisi', value);
      },
    );
  }

  CardSettingsListPicker _kriteriaKeamanan() {
    return CardSettingsListPicker(
      label: 'Kriteria Keamanan',
      hintText: 'Select One',
      initialValue: _ponyModel.kriteriaKeamanan,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Sangat Baik', 'Baik', 'Cukup', 'Kurang'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.kriteriaKeamanan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kriteriaKeamanan = value;
        });
        _showSnackBar('Kriteria Keamanan', value);
      },
    );
  }

  CardSettingsMultiselect _saranaKebersihan() {
    return CardSettingsMultiselect(
      showMaterialIOS: _showMaterialIOS,
      label: 'Fasilitas Kebersihan',
      initialValues: _ponyModel.saranaKebersihan,
      options: <String>['Petugas Kebersihan Pemda', 'Petugas Kebersihan Swadaya', 'Truck Pengangkut Sampah',
      'Gerobak Sampah', 'Lainnya'],
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one.';

        return null;
      },
      onSaved: (value) => _ponyModel.saranaKebersihan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.saranaKebersihan = value;
        });
        _showSnackBar('Fasilitas Kebersihan', value);
      },
    );
  }

  CardSettingsListPicker _kriteriaKebersihan() {
    return CardSettingsListPicker(
      label: 'Kriteria Kebersihan',
      hintText: 'Select One',
      initialValue: _ponyModel.kriteriaKebersihan,
      contentAlign: TextAlign.right,
      autovalidate: _autoValidate,
      options: <String>['Sangat Baik', 'Baik', 'Cukup', 'Kurang'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.kriteriaKebersihan = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.kriteriaKebersihan = value;
        });
        _showSnackBar('Kriteria Kebersihan', value);
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