import 'package:get/get_state_manager/get_state_manager.dart';

class AddPegawaiController extends GetxController {
  int kondisiMutasi = 0;

  void setPicture() {
    update(['profilPicture']);
  }

  void setMutasiKepegawaian(int nilai) {
    kondisiMutasi = nilai;
    update(['mutasiKepegawaian']);
  }
}
