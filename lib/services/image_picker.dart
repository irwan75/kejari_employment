import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kejari_employment/services/save_image.dart';
import 'package:path_provider/path_provider.dart';

final picker = ImagePicker();

Future<String> imgFromCamera() async {
  try {
    final image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      print(image.path);
      return image.path;
    }
  } on Exception catch (e) {
    displayDialog();
  }
}

Future<String> imgFromGallery() async {
  try {
    final image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      print(image.path);
      return image.path;
    }
  } on Exception catch (e) {
    displayDialog();
  }
}

void displayDialog() {
  Get.defaultDialog(
    title: "",
    titleStyle: TextStyle(fontSize: 0),
    content: Container(
      child: Text(
        "Hanya Yang Berekstensi JPG",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
