import 'package:assets_to_ui/database/contentdao.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDB {
  // Singleto instance
  static final AppDB _singleton = AppDB._();
  // Singleton accessor
  static AppDB get instance => _singleton;

  AppDB._();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await getDB();
    return _db;
  }

  Future<Database> getDB() async {
    final documentDIR = await getApplicationDocumentsDirectory();
    final dbPath = join(documentDIR.path, 'test.db');
    final database = databaseFactoryIo.openDatabase(dbPath);
    return database;
  }
}

final DBLogic dbLogic = DBLogic();
