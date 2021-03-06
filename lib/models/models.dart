import 'dart:convert';

enum HomeState {
  GETALL,
  INSERT,
  UPDATE,
  DELETE,
  DELETEALL,
  NOPE,
}
List<Content> HomeFromJson(String str) {
  final jsonData = jsonDecode(str);
  return new List<Content>.from(jsonData.map((x) => Content.fromMap(x)));
}

class Content {
  List<Home> home;
  Content({
    this.home,
  });

  factory Content.fromJson(String str) => Content.fromMap(jsonDecode(str));

  String toJson() => jsonEncode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => new Content(
        home: new List<Home>.from(json["home"].map((x) => Home.fromMap(x))),
      );
  Map<String, dynamic> toMap() => {
        "home": new List<dynamic>.from(home.map((e) => e.toMap())),
      };
}

class Home {
  String id;
  String name;
  String email;
  String desc;
  HomeState state;

  Home({
    this.id,
    this.name,
    this.email,
    this.desc,
    this.state,
  });

  factory Home.fromJson(String str) => Home.fromMap(jsonDecode(str));
  String toJson() => jsonEncode(toMap());

  Home.fromMap(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        email = json["email"],
        desc = json["desc"];

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "desc": desc,
      };
}
