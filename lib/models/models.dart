import 'dart:convert';

List<Content> HomeFromJson(String str) {
  final jsonData = jsonDecode(str);
  return new List<Content>.from(jsonData.map((x) => Content.fromMap(x)));
}

class Content {
  List home;
  Content({
    this.home,
  });

  factory Content.fromJson(String str) => Content.fromJson(jsonDecode(str));

  String toJson() => jsonEncode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => new Content(
        home: new List<Home>.from(json["home"].map((x) => x.toMap())),
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

  Home({
    this.id,
    this.name,
    this.email,
    this.desc,
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
