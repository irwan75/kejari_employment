import 'package:kejari_employment/model/profil_pegawai.dart';
import 'package:kejari_employment/services/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class GetDb {
  Future<List<ProfilPegawai>> getProfilEmployees() async {
    var dbClient = DbHelper.db;

    final sql = '''SELECT * FROM employee''';
    final data = await dbClient.rawQuery(sql);
    // print(data);

    // List<Map> maps = await dbClient.query(
    //   "employee",
    //   columns: [
    //     "id",
    //     "nama",
    //     "nip",
    //     "pangkatGol",
    //     "pangkatTmt",
    //     "jabNama",
    //     "jabTmt",
    //     "maskerThn",
    //     "maskerBln",
    //     "latjaNama",
    //     "latjaWkt",
    //     "latjaJmlJam",
    //     "pendidikanNama",
    //     "pendidikanThnLls",
    //     "pendidikanIjazah",
    //     "usia"
    //   ],
    // );
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<ProfilPegawai> employees = [];
    if (data.length > 0) {
      for (int i = 0; i < data.length; i++) {
        employees.add(ProfilPegawai.fromMap(data[i]));
      }
    }
    return employees;
  }

  Future<List<String>> getCatMutasiKepegawaian(String nip) async {
    var dbClient = DbHelper.db;

    final sql = '''SELECT ketMutasi FROM catMutasiKepegawaian where nip=$nip''';
    final data = await dbClient.rawQuery(sql);

    // List<Map> maps = await dbClient.query(
    //   "employee",
    //   columns: [
    //     "id",
    //     "nama",
    //     "nip",
    //     "pangkatGol",
    //     "pangkatTmt",
    //     "jabNama",
    //     "jabTmt",
    //     "maskerThn",
    //     "maskerBln",
    //     "latjaNama",
    //     "latjaWkt",
    //     "latjaJmlJam",
    //     "pendidikanNama",
    //     "pendidikanThnLls",
    //     "pendidikanIjazah",
    //     "usia"
    //   ],
    // );
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<String> employees = [];
    if (data.length > 0) {
      for (int i = 0; i < data.length; i++) {
        employees.add(data[i]['ketMutasi']);
      }
    }
    return employees;
  }
}
