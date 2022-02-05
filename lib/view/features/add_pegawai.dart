import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kejari_employment/controller/add_pegawai_controller.dart';
import 'package:kejari_employment/controller/main_list_controller.dart';
import 'package:kejari_employment/resources/colors.dart';
import 'package:kejari_employment/services/image_picker.dart';
import 'package:kejari_employment/services/save_db.dart';
import 'package:kejari_employment/model/profil_pegawai.dart';
import 'package:kejari_employment/services/save_image.dart';

class AddPegawai extends StatelessWidget {
  TextEditingController _formNama = TextEditingController();
  TextEditingController _formNip = TextEditingController();
  TextEditingController _formPangkatGol = TextEditingController();
  TextEditingController _formPangkatTMT = TextEditingController();
  TextEditingController _formJabatanNama = TextEditingController();
  TextEditingController _formJabatanTMT = TextEditingController();
  TextEditingController _formMasKerTahun = TextEditingController();
  TextEditingController _formMasKerBulan = TextEditingController();
  TextEditingController _formLatJabNama = TextEditingController();
  TextEditingController _formLatJabWktu = TextEditingController();
  TextEditingController _formLatJabJmlJam = TextEditingController();
  TextEditingController _formPendidikanNama = TextEditingController();
  TextEditingController _formPendidikanThn = TextEditingController();
  TextEditingController _formPendidikanIjazah = TextEditingController();
  TextEditingController _formUsia = TextEditingController();
  TextEditingController _formMutasiKepegawaian = TextEditingController();

  List<String> catMutasiKepegawaian = [];

  final AddPegawaiController _pegawaiController =
      Get.put(AddPegawaiController());

  final MainListController _mainListController = Get.put(MainListController());

  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        width: Get.width,
        height: Get.height,
        child: ListView(
          children: [
            SizedBox(height: 15),
            GetBuilder<AddPegawaiController>(
              id: 'profilPicture',
              init: AddPegawaiController(),
              builder: (controller) {
                return Material(
                  child: InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        title: "Pilih Media",
                        content: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: RaisedButton(
                                  color: primaryColor,
                                  onPressed: () async {
                                    Get.back();
                                    var hasil = await imgFromGallery();
                                    if (hasil != null) {
                                      _image = File(hasil);
                                      controller.setPicture();
                                    } else {
                                      print(hasil);
                                    }
                                  },
                                  child: Text(
                                    "Gallery",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                flex: 1,
                                child: RaisedButton(
                                  color: primaryColor,
                                  onPressed: () async {
                                    Get.back();
                                    var hasil = await imgFromCamera();
                                    if (hasil != null) {
                                      _image = File(hasil);
                                      controller.setPicture();
                                    } else {
                                      print(hasil);
                                    }
                                  },
                                  child: Text(
                                    "Camera",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: _image == null
                        ? CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 128,
                            child: Text(
                              "Tambah Foto",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          )
                        : Center(
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    width: 255,
                                    height: 255,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(150),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(0, 2),
                                  child: Center(
                                    child: ClipOval(
                                      child: Image.file(
                                        _image,
                                        width: 250,
                                        height: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: ClipOval(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(150),
                                      ),
                                      width: 255,
                                      height: 255,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width: Get.width,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          color: Colors.grey.withOpacity(0.6),
                                          child: Text(
                                            "Ganti Foto",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                );
              },
            ),
            listTileCustom("Nama", _formNama, TextInputType.name),
            listTileCustom("NIP", _formNip, TextInputType.number),
            rowSetKeterangan(
              "Pangkat",
              <Widget>[
                rowKeterangan("Gol Ruang"),
                rowKeterangan("TMT"),
              ],
              <Widget>[
                rowKeteranganEdit(_formPangkatGol, TextInputType.name),
                SizedBox(width: 20),
                rowKeteranganEdit(_formPangkatTMT, TextInputType.datetime)
              ],
            ),
            rowSetKeterangan(
              "Jabatan",
              <Widget>[
                rowKeterangan("Nama"),
                SizedBox(width: 20),
                rowKeterangan("TMT"),
              ],
              <Widget>[
                rowKeteranganEdit(_formJabatanNama, TextInputType.name),
                SizedBox(width: 20),
                rowKeteranganEdit(_formJabatanTMT, TextInputType.datetime)
              ],
            ),
            rowSetKeterangan(
              "Masa Kerja",
              <Widget>[
                rowKeterangan("Tahun"),
                SizedBox(width: 20),
                rowKeterangan("Bulan"),
              ],
              <Widget>[
                rowKeteranganEdit(_formMasKerTahun, TextInputType.number),
                SizedBox(width: 20),
                rowKeteranganEdit(_formMasKerBulan, TextInputType.number),
              ],
            ),
            rowSetKeterangan(
              "Latihan Jabatan",
              <Widget>[
                rowKeterangan("Nama"),
                SizedBox(width: 20),
                rowKeterangan("Bln/Thn"),
                SizedBox(width: 20),
                rowKeterangan("Jmlh Jam"),
              ],
              <Widget>[
                rowKeteranganEdit(_formLatJabNama, TextInputType.name),
                SizedBox(width: 20),
                rowKeteranganEdit(_formLatJabWktu, TextInputType.name),
                SizedBox(width: 20),
                rowKeteranganEdit(_formLatJabJmlJam, TextInputType.number)
              ],
            ),
            rowSetKeterangan(
              "Pendidikan",
              <Widget>[
                rowKeterangan("Nama"),
                SizedBox(width: 20),
                rowKeterangan("Thn Lulus"),
                SizedBox(width: 20),
                rowKeterangan("Tngkt Ijazah"),
              ],
              <Widget>[
                rowKeteranganEdit(_formPendidikanNama, TextInputType.name),
                SizedBox(width: 20),
                rowKeteranganEdit(_formPendidikanThn, TextInputType.number),
                SizedBox(width: 20),
                rowKeteranganEdit(_formPendidikanIjazah, TextInputType.name),
              ],
            ),
            listTileCustom("Usia", _formUsia, TextInputType.number),
            SizedBox(height: 15),
            addCatMutasi(),
            SizedBox(height: 20),
            MaterialButton(
              padding: EdgeInsets.symmetric(vertical: 13),
              color: primaryColor,
              onPressed: () async {
                if (_formNama.text.isEmpty ||
                    _formNip.text.isEmpty ||
                    _formPangkatGol.text.isEmpty ||
                    _formPangkatTMT.text.isEmpty ||
                    _formJabatanNama.text.isEmpty ||
                    _formJabatanTMT.text.isEmpty ||
                    _formMasKerTahun.text.isEmpty ||
                    _formMasKerBulan.text.isEmpty ||
                    _formLatJabNama.text.isEmpty ||
                    _formLatJabWktu.text.isEmpty ||
                    _formLatJabJmlJam.text.isEmpty ||
                    _formPendidikanNama.text.isEmpty ||
                    _formPendidikanThn.text.isEmpty ||
                    _formPendidikanIjazah.text.isEmpty ||
                    _formUsia.text.isEmpty) {
                  Get.defaultDialog(
                    title: "",
                    titleStyle: TextStyle(fontSize: 0),
                    content: Container(
                      child: Text(
                        "Form Masih Ada yang Kosong",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else if (_image == null) {
                  Get.defaultDialog(
                    title: "",
                    titleStyle: TextStyle(fontSize: 0),
                    content: Container(
                      child: Text(
                        "Harap Pilih Foto",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else {
                  var hasil = await SaveDb().saveEmployee(
                    new ProfilPegawai(
                      id: 0,
                      nama: _formNama.text,
                      nip: int.parse(_formNip.text),
                      jabNama: _formJabatanNama.text,
                      jabTmt: _formJabatanTMT.text,
                      latjaJmlJam: int.parse(_formLatJabJmlJam.text),
                      latjaNama: _formLatJabNama.text,
                      latjaWkt: "${_formLatJabWktu.text}",
                      maskerBln: int.parse(_formMasKerBulan.text),
                      maskerThn: int.parse(_formMasKerTahun.text),
                      pangkatGol: _formPangkatGol.text,
                      pangkatTmt: _formPangkatTMT.text,
                      pathPicture:
                          await saveImage(_image, int.parse(_formNip.text)),
                      pendidikanIjazah: _formPendidikanIjazah.text,
                      pendidikanNama: _formPendidikanNama.text,
                      pendidikanThnLls: int.parse(_formPendidikanThn.text),
                      usia: int.parse(_formUsia.text),
                    ),
                    catMutasiKepegawaian,
                  );
                  if (hasil == true) {
                    _mainListController.setMainList();
                    Get.back();
                  }
                }

                // print(_image.path);

                // print(_formNama.text);
                // print(_formNip.text);

                // print(_formPangkatGol.text);
                // print(_formPangkatTMT.text);

                // print(_formJabatanNama.text);
                // print(_formJabatanTMT.text);

                // print(_formMasKerBulan.text);
                // print(_formMasKerTahun.text);

                // print(_formLatJabJmlJam.text);
                // print(_formLatJabNama.text);
                // print(_formLatJabWktu.text);

                // print(_formPendidikanIjazah.text);
                // print(_formPendidikanNama.text);
                // print(_formPendidikanThn.text);

                // print(_formUsia.text);
                // print(catMutasiKepegawaian.length.toString());
              },
              child: Text(
                "Tambah",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget addCatMutasi() {
    return GetBuilder<AddPegawaiController>(
      id: 'mutasiKepegawaian',
      init: AddPegawaiController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cat Mutasi Kepegawaian",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Material(
                    color: Colors.green,
                    child: InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        controller.setMutasiKepegawaian(1);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 6,
                        ),
                        child: Text(
                          "Tambah",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: catMutasiKepegawaian.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    catMutasiKepegawaian.removeAt(index);
                    controller.setMutasiKepegawaian(0);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${catMutasiKepegawaian[index]}",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            (controller.kondisiMutasi == 1) ? addKondisiMutasi() : Container(),
          ],
        );
      },
    );
  }

  Widget addKondisiMutasi() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: TextFormField(
                controller: _formMutasiKepegawaian,
              ),
            ),
          ),
          SizedBox(width: 15),
          Column(
            children: [
              buttonCircleCatMutasi(Icons.remove, Colors.red, 0),
              SizedBox(height: 10),
              buttonCircleCatMutasi(Icons.check, Colors.green, 1),
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonCircleCatMutasi(IconData icon, Color color, int kondisi) {
    return GestureDetector(
      onTap: () {
        if (kondisi == 0) {
          _pegawaiController.setMutasiKepegawaian(0);
        } else {
          catMutasiKepegawaian.add(_formMutasiKepegawaian.text);
          _formMutasiKepegawaian.clear();
          _pegawaiController.setMutasiKepegawaian(0);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget rowSetKeterangan(
      String title, List<Widget> rowTitleKonten, List<Widget> rowKonten) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: rowTitleKonten,
          ),
          Row(
            children: rowKonten,
          ),
        ],
      ),
    );
  }

  Widget rowKeterangan(String text) {
    return Expanded(
      flex: 1,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget rowKeteranganEdit(
      TextEditingController controller, TextInputType type) {
    return Container(
      child: Expanded(
        flex: 1,
        child: TextFormField(
          keyboardType: type,
          controller: controller,
        ),
      ),
    );
  }

  Widget listTileCustom(
      String title, TextEditingController controller, TextInputType type) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          TextFormField(
            controller: controller,
            keyboardType: type,
          ),
        ],
      ),
    );
  }
}
