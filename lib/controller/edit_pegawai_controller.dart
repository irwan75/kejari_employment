import 'dart:io';

import 'package:get/get_state_manager/get_state_manager.dart';

class EditPegawaiController extends GetxController {
  int kondisiMutasi = 0;

  void setMutasiKepegawaian(int val) {
    kondisiMutasi = val;
    update(['mutasiKepegawaian']);
  }

  void setImage() {
    update(['profilPicture']);
  }
}
