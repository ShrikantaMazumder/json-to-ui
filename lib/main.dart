import 'package:assets_to_ui/blocs/home_bloc.dart';
import 'package:assets_to_ui/blocs/provider.dart';
import 'package:assets_to_ui/database/contentdao.dart';
import 'package:assets_to_ui/models/models.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      builder: (context, HomeBloc bloc) => bloc ?? HomeBloc(DBLogic()),
      onDispose: (context, bloc) => bloc.dispose(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON to UI'),
      ),
      body: HomeView(bloc),
    );
  }
}

class HomeView extends StatefulWidget {
  HomeBloc bloc;

  HomeView(this.bloc);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    widget.bloc.inSink.add(Home(state: HomeState.GETALL));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: StreamBuilder(
          stream: widget.bloc.outgoing,
          builder: (context, AsyncSnapshot<List<Home>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            if (snapshot.data.isEmpty) {
              return Text("No data avilable");
            }
            return ListView(
              children: snapshot.data.map((info) {
                return GestureDetector(
                  onTap: () {
                    print("Tapped ${info.id}");
                  },
                  child: ListTile(
                    title: Text(info.name),
                    subtitle: Text(info.email),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

//   _getAllHome() async {
//     final data = await dbLogic.getAllHome();
//     return data;
//   }
//
//   void deleteAll() async {
//     await dbLogic.deleteAll();
//     print("DB Cleared");
//   }
// }
