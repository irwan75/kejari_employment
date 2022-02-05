import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kejari_employment/model/profil_pegawai.dart';
import 'package:kejari_employment/resources/colors.dart';
import 'package:kejari_employment/services/get_db.dart';
import 'package:kejari_employment/view/features/edit_pegawai.dart';

class LihatPegawai extends StatefulWidget {
  ProfilPegawai hasil;
  String nip;
  LihatPegawai({
    Key key,
    this.hasil,
    this.nip,
  }) : super(key: key);
  @override
  _LihatPegawaiState createState() => _LihatPegawaiState();
}

class _LihatPegawaiState extends State<LihatPegawai> {
  List<String> _listCatMutasi = [];

  Future<List<String>> getDataMutasi() async {
    var nilai = await GetDb().getCatMutasiKepegawaian(widget.nip);
    _listCatMutasi = nilai;
    return nilai;
  }

  Color colorExpansion = Colors.black;

  @override
  Widget build(BuildContext context) {
    getDataMutasi();
    return Scaffold(
      appBar: AppBar(
        title: Text("Data ${widget.hasil.nama}"),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Get.to(
                EditPegawai(
                  hasil: widget.hasil,
                  listCatMutasi: _listCatMutasi,
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        width: Get.width,
        height: Get.height,
        child: ListView(
          children: [
            SizedBox(height: 15),
            Center(
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
                          File(widget.hasil.pathPicture),
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text(widget.hasil.pathPicture),
            // Image.file(File(widget.hasil.pathPicture)),
            listTileCustom("Nama", "${widget.hasil.nama}"),
            listTileCustom("NIP", "${widget.hasil.nip}"),
            rowSetKeterangan(
              "Pangkat",
              <Widget>[
                rowKeterangan("Gol Ruang", 1),
                rowKeterangan("TMT", 1),
              ],
              <Widget>[
                rowKeterangan("${widget.hasil.pangkatGol}", 2),
                rowKeterangan("${widget.hasil.pangkatTmt}", 2),
              ],
            ),
            rowSetKeterangan(
              "Jabatan",
              <Widget>[
                rowKeterangan("Nama", 1),
                rowKeterangan("TMT", 1),
              ],
              <Widget>[
                rowKeterangan("${widget.hasil.jabNama}", 2),
                rowKeterangan("${widget.hasil.jabTmt}", 2),
              ],
            ),
            rowSetKeterangan(
              "Masa Kerja",
              <Widget>[
                rowKeterangan("Tahun", 1),
                rowKeterangan("Bulan", 1),
              ],
              <Widget>[
                rowKeterangan("${widget.hasil.maskerThn}", 2),
                rowKeterangan("${widget.hasil.maskerBln}", 2),
              ],
            ),
            rowSetKeterangan(
              "Latihan Jabatan",
              <Widget>[
                rowKeterangan("Nama", 1),
                rowKeterangan("Bln/Thn", 1),
                rowKeterangan("Jmlh Jam", 1),
              ],
              <Widget>[
                rowKeterangan("${widget.hasil.latjaNama}", 2),
                rowKeterangan("${widget.hasil.latjaWkt}", 2),
                rowKeterangan("${widget.hasil.latjaJmlJam}", 2),
              ],
            ),
            rowSetKeterangan(
              "Pendidikan",
              <Widget>[
                rowKeterangan("Nama", 1),
                rowKeterangan("Thn Lulus", 1),
                rowKeterangan("Tngkt Ijazah", 1),
              ],
              <Widget>[
                rowKeterangan("${widget.hasil.pendidikanNama}", 2),
                rowKeterangan("${widget.hasil.pendidikanThnLls}", 2),
                rowKeterangan("${widget.hasil.pendidikanIjazah}", 2),
              ],
            ),
            listTileCustom("Usia", "${widget.hasil.usia}"),
            SizedBox(height: 17),
            expansionTileCustom(
                "Cat Mutasi Kepegawaian", "${widget.hasil.nip}"),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget listTileCustom(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
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
            style: TextStyle(fontSize: 15),
          ),
          Divider(
            color: Colors.grey,
            height: 5,
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

  Widget rowKeterangan(String text, int mode) {
    switch (mode) {
      case 1:
        return Expanded(
          flex: 1,
          child: Text(
            text,
          ),
        );
        break;
      case 2:
        return Expanded(
          flex: 1,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        );
        break;
    }
    return Expanded(
      flex: 1,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget expansionTileCustom(String title, String nip) {
    return FutureBuilder<List<String>>(
      future: getDataMutasi(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var hasil = snapshot.data;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: ExpansionTile(
              onExpansionChanged: (expanded) {
                expanded
                    ? colorExpansion = primaryColor
                    : colorExpansion = Colors.black;
                setState(() {});
              },
              title: Text(
                title,
                style: TextStyle(
                  color: colorExpansion,
                  fontWeight: FontWeight.bold,
                ),
              ),
              tilePadding: EdgeInsets.symmetric(horizontal: 7),
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  width: Get.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: hasil.length,
                    itemBuilder: (context, index) {
                      return Text(
                        "${hasil[index]}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
