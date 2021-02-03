import 'package:assets_to_ui/models/models.dart';
import 'package:flutter/services.dart';

class LoadJson {
  static final LoadJson _singleton = LoadJson._();
  static LoadJson get instance => _singleton;
  LoadJson._();

  Future<String> loadHome(String root) async {
    print(root);
    return await rootBundle.loadString("assets/json/${root}.json");
  }

  Future loadContent() async {
    List<Content> home = HomeFromJson(await loadHome("home"));
    print(home);
  }
}
