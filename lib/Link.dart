import 'dart:io';

class Link{

  String ref;
  String href;

  Link(this.ref,this.href);

  factory Link.fromJson(Map<String , dynamic > json){

    return Link(json["ref"] as String,json["href"] as String);
  }

}