import 'package:sqflite/sqflite.dart';

class DbManger {
  static final DbManger _dbManger = DbManger._internal();
  Database db;
  String databasePath;
  factory DbManger () {
    return _dbManger;
  }
  DbManger._internal();

  Future<Database> openDb(int version) async{
    var path = await getDatabasesPath();
    db = await openDatabase( path + '/validus.db', version: version, onCreate: (db, ver) async {
    await db.execute('CREATE TABLE stock (id TEXT PRIMARY KEY, stockName TEXT, price TEXT, dayGain TEXT, lastTrade TEXT, extendedHours TEXT, lastPrice TEXT)');
      return db;
    });
  }
  Future<void> insert(List<dynamic> values) async {
    db.transaction((txn) async {
      int id1 = await txn.rawInsert('INSERT INTO stock(id, stockName, price, dayGain, lastTrade, extendedHours, lastPrice) values (?, ?, ?, ?, ?, ?, ?)', values);
    });
  }
  Future<List<Map>> getRows() async {
    List<Map> list = await db.rawQuery('SELECT * FROM stock');
    list.forEach((element) {
      print ('----- row: ${element.toString()}');
    });
    return list;
  }
  closeDb () async {
    await db?.close();
  }
  deleteDb () async {
    await deleteDatabase(databasePath);
  }
}