import 'dart:convert';

Model modelFromJson(String str) => Model.fromJson(json.decode(str));

String modelToJson(Model data) => json.encode(data.toJson());

class Model {

  Model({
    required this.pGiseno,
    required this.pNewupdate,
    required this.links,
  });

  String pGiseno;
  int pNewupdate;
  List<Link> links;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    pGiseno: json["p_giseno"],
    pNewupdate: json["p_newupdate"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );



  Map<String, dynamic> toJson() => {
    "p_giseno": pGiseno,
    "p_newupdate": pNewupdate,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class Link {
  Link({
    required this.rel,
    required this.href,
  });

  String rel;
  String href;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    rel: json["rel"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "rel": rel,
    "href": href,
  };
}
