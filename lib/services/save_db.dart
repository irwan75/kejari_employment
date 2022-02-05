import 'package:kejari_employment/model/profil_pegawai.dart';
import 'package:kejari_employment/services/db_helper.dart';
import 'package:sqflite/sqlite_api.dart';

class SaveDb {
  Future<bool> saveEmployee(
      ProfilPegawai employee, List<String> listCatMutasi) async {
    var dbClient = DbHelper.db;

    try {
      final sqlTblEmployee = ''' INSERT INTO employee(
        pathPicture,
        nama, 
        nip, 
        pangkatGol, 
        pangkatTmt, 
        jabNama, 
        jabTmt, 
        maskerThn, 
        maskerBln, 
        latjaNama, 
        latjaWkt, 
        latjaJmlJam,
        pendidikanNama, 
        pendidikanThnLls, 
        pendidikanIjazah, 
        usia) 
      VALUES (
        '${employee.pathPicture}',
        '${employee.nama}',
        ${employee.nip},
        '${employee.pangkatGol}',
        '${employee.pangkatTmt}',
        '${employee.jabNama}',
        '${employee.jabTmt}',
        ${employee.maskerThn},
        ${employee.maskerBln},
        '${employee.latjaNama}',
        '${employee.latjaWkt}',
        ${employee.latjaJmlJam},
        '${employee.pendidikanNama}',
        ${employee.pendidikanThnLls},
        '${employee.pendidikanIjazah}',
        ${employee.usia}
      )
    ''';
      await dbClient.rawQuery(sqlTblEmployee);

      if (listCatMutasi.length != 0) {
        for (int i = 0; i < listCatMutasi.length; i++) {
          final sqlTblCatMutasi = '''INSERT INTO catMutasiKepegawaian(
        nip,
        ketMutasi
      )
      VALUES(
        ${employee.nip},
        '${listCatMutasi[i]}'
      )
      ''';
          await dbClient.rawQuery(sqlTblCatMutasi);
        }
      }

      return true;
    } on DatabaseException catch (e) {
      return false;
    } on Exception catch (e) {
      return false;
    }
  }
}
