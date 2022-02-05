import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> saveImage(File image, int nip) async {
  try {
// final Directory _appDocDirFolder =  Directory('${_appDocDir.path}/$folderName/');

    // final Directory _appDocDir = await getApplicationDocumentsDirectory();
    final Directory _appDocDir = await getExternalStorageDirectory();
    final Directory _appDocDirFolder =
        Directory("${_appDocDir.path.substring(0, 20)}kejari_mks_pegawai/");

    if (await _appDocDirFolder.exists()) {
    } else {
      await Directory(_appDocDirFolder.path).create(recursive: true);
    }
    File tmpFileNew = await image.copy('${_appDocDirFolder.path}$nip.jpg');

    // final String dirPath =
    //     "${extDir.path.toString().substring(0, 20)}/kejariApps";

    // print(_appDocDir.toString());
    // print(dirPath);
    // print("${DateTime.now().toUtc().toIso8601String()}.png");

    // await Directory(dirPath).create(recursive: true);

    // final String fileName = basename(pickedFile.path); // Filename without extension
    // final String fileExtension = extension(pickedFile.path); // e.g. '.jpg'
    // File tmpFile = File(image.path);
    // 6. Save the file by copying it to the new location on the device.
    // File tmpFileNew = await tmpFile.copy('$filePath/okee.jpg');

    // print(tmpFileNew.path);

//Get this App Document Directory
    // final Directory _appDocDir = await getApplicationDocumentsDirectory();
    // //App Document Directory + folder name
    // final Directory _appDocDirFolder =
    //     Directory('${_appDocDir.path}/$folderName/');

    // if (await _appDocDirFolder.exists()) {
    //   //if folder already exists return path
    //   return _appDocDirFolder.path;
    // } else {
    //   //if folder not exists create folder and then return its path
    //   final Directory _appDocDirNewFolder =
    //       await _appDocDirFolder.create(recursive: true);
    //   return _appDocDirNewFolder.path;
    // }
    return "${tmpFileNew.path}";
  } on Exception catch (e) {
    return "Path Error $e";
  }
}
