import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static Database db;
  static const String TABLE = 'employee';
  static const String TABLERELASI = 'catMutasiKepegawaian';
  static const String DB_NAME = 'emplo.db';

  Future<Database> get database async {
    if (db != null) {
      return db;
    }
    db = await initDb();
    return db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    // await db.execute("DELETE TABLE $TABLERELASI");
    // await db.execute("DELETE TABLE $TABLE");
    await db.execute(
        "create TABLE $TABLE (id INTEGER PRIMARY KEY, pathPicture TEXT, nama VARCHAR(50), nip BIGINT UNIQUE, pangkatGol VARCHAR(10), pangkatTmt VARCHAR(12), jabNama VARCHAR(50), jabTmt VARCHAR(12), maskerThn INT,maskerBln INT, latjaNama VARCHAR(50), latjaWkt VARHCAR(10),latjaJmlJam INT, pendidikanNama VARCHAR(20), pendidikanThnLls INT, pendidikanIjazah VARCHAR(10), usia INT)");
    await db.execute(
        "CREATE TABLE $TABLERELASI (id INTEGER PRIMARY KEY, nip BIGINT, ketMutasi VARCHAR(50), FOREIGN KEY(nip) REFERENCES employee(nip) ON DELETE CASCADE ON UPDATE CASCADE)");
  }
}
