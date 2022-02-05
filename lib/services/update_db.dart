import 'package:kejari_employment/model/profil_pegawai.dart';
import 'package:kejari_employment/services/db_helper.dart';

class UpdateDb {
  Future<int> updateEmployee(
      ProfilPegawai employee, List<String> listCatMutasi) async {
    var dbClient = DbHelper.db;

    try {
      final sql = ''' UPDATE employee SET 
      pathPicture = '${employee.pathPicture}',
      nama = '${employee.nama}',
      nip = ${employee.nip},
      pangkatGol = '${employee.pangkatGol}',
      pangkatTmt = '${employee.pangkatTmt}',
      jabNama = '${employee.jabNama}',
      jabTmt = '${employee.jabTmt}',
      maskerThn = ${employee.maskerThn},
      maskerBln = ${employee.maskerBln},
      latjaNama = '${employee.latjaNama}',
      latjaWkt = '${employee.latjaWkt}',
      latjaJmlJam = ${employee.latjaJmlJam},
      pendidikanNama = '${employee.pendidikanNama}',
      pendidikanThnLls = ${employee.pendidikanThnLls},
      pendidikanIjazah = '${employee.pendidikanIjazah}',
      usia = ${employee.usia}
      WHERE id = ${employee.id}
    ''';
      await dbClient.rawQuery(sql);

      final sqlDeleteDataMutasi =
          ''' DELETE FROM catMutasiKepegawaian WHERE nip=${employee.nip}''';

      await dbClient.rawQuery(sqlDeleteDataMutasi);

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

      return 1;
    } on Exception catch (e) {
      print("Error : Ada Cacata");
      return 0;
    }
  }
}
