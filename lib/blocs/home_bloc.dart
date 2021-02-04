import 'dart:async';

import 'package:assets_to_ui/database/contentdao.dart';
import 'package:assets_to_ui/models/models.dart';

class HomeBloc {
  final DBLogic logic;

  StreamController<List<Home>> _homes = StreamController.broadcast();
  StreamController<Home> _incoming = StreamController();
  Stream<List<Home>> get outgoing => _homes.stream;
  StreamSink<Home> get inSink => _incoming.sink;
  HomeBloc(this.logic) {
    _incoming.stream.listen((home) async {
      switch (home.state) {
        case HomeState.INSERT:
          logic.insert(home).then((_) async => {
                {_homes.add(await logic.getAllHome())}
              });
          break;
        case HomeState.UPDATE:
          logic.update(home).then((_) async => {
                {_homes.add(await logic.getAllHome())}
              });
          break;
        case HomeState.GETALL:
          _homes.add(await logic.getAllHome());
          break;
        case HomeState.DELETE:
          logic.delete(home).then((_) async => {
                {_homes.add(await logic.getAllHome())}
              });
          break;
        case HomeState.DELETEALL:
          logic.deleteAll().then((_) async => {
                // {_homes.add(await logic.getAllHome())}
              });
          break;
        case HomeState.NOPE:
          break;
      }
    });
  }
  void dispose() {
    _incoming.close();
    _homes.close();
  }
}
