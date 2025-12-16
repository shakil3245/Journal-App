
import 'dart:convert';

List<JournalsModel> journalsModelFromJson(String str) => List<JournalsModel>.from(json.decode(str).map((x) => JournalsModel.fromJson(x)));

String journalsModelToJson(List<JournalsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JournalsModel {
  String id;
  String title;
  String content;
  Author author;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  JournalsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory JournalsModel.fromJson(Map<String, dynamic> json) => JournalsModel(
    id: json["_id"],
    title: json["title"],
    content: json["content"],
    author: Author.fromJson(json["author"]),
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "content": content,
    "author": author.toJson(),
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Author {
  String id;
  String username;
  String email;

  Author({
    required this.id,
    required this.username,
    required this.email,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
  };
}
