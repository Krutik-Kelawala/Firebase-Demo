import 'dart:convert';

GetApiModel getApiModelFromJson(String str) => GetApiModel.fromJson(json.decode(str));

String getApiModelToJson(GetApiModel data) => json.encode(data.toJson());

class GetApiModel {
  String status;
  int totalResults;
  List<Article> articles;

  GetApiModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory GetApiModel.fromJson(Map<String, dynamic> json) => GetApiModel(
        status: json["status"] ?? "",
        totalResults: json["totalResults"] ?? 0,
        articles: json["articles"] != null ? List<Article>.from(json["articles"].map((x) => Article.fromJson(x))) : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime? publishedAt;
  String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        url: json["url"] ?? "",
        urlToImage: json["urlToImage"] ?? "",
        publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
        content: json["content"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt!.toIso8601String(),
        "content": content,
      };
}

class Source {
  String name;

  Source({
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
