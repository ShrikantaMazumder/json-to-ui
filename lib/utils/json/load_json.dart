import 'package:assets_to_ui/database/database.dart';
import 'package:assets_to_ui/models/models.dart';
import 'package:flutter/services.dart' show rootBundle;

class LoadJson {
  static final LoadJson _singleton = LoadJson._();
  static LoadJson get instance => _singleton;
  LoadJson._();

  Future<String> loadHome(String root) async {
    return await rootBundle.loadString("assets/json/${root}.json");
  }

  Future loadContent() async {
    List<Content> home = HomeFromJson(await loadHome("data"));
    for (int i = 0; i < home[0].home.length; i++) {
      await dbLogic.insert(home[0].home[i]);
    }
  }
}
