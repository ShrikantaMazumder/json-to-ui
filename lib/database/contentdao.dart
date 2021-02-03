import 'package:assets_to_ui/database/database.dart';
import 'package:assets_to_ui/models/models.dart';
import 'package:sembast/sembast.dart';

class DBLogic {
  static const String STORE = 'home';

  final _home = intMapStoreFactory.store(STORE);

  Future<Database> get db async => await AppDB.instance.db;

  Future insert(Home home) async {
    await _home.add(await db, home.toMap());
  }

  Future update(Home home) async {
    final finder = Finder(filter: Filter.byKey(home.id));
    await _home.update(await db, home.toMap(), finder: finder);
  }

  Future delete(Home home) async {
    final finder = Finder(filter: Filter.byKey(home.id));
    await _home.delete(await db, finder: finder);
  }

  Future<List<Home>> getAllHome() async {
    final snapshot = await _home.find(await db);
    return snapshot.map((e) {
      final home = Home.fromMap(e.value);
      return home;
    }).toList();
  }
}
