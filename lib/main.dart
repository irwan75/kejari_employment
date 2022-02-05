import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kejari_employment/services/db_helper.dart';
import 'package:kejari_employment/view/main_list_pegawai.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper().database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future getPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    getPermission();
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/main_list',
          page: () => MainListPegawai(),
        ),
      ],
      home: MainListPegawai(),
    );
  }
}
