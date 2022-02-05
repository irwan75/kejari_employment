import 'package:kejari_employment/services/db_helper.dart';

class DeleteDb {
  Future<int> deleteEmployee(List<int> id) async {
    try {
      for (int i = 0; i < id.length; i++) {
        var dbClient = DbHelper.db;
        final sql = ''' DELETE FROM employee WHERE id=${id[i]}''';
        await dbClient.rawQuery(sql);
      }
      return 1;
    } on Exception catch (e) {
      print(e);
      return 0;
    }
  }
}
