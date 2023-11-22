import 'package:qiita_search/models/user.dart';

// Articleクラス: Qiitaの記事を表現するクラス
class Article{
  //コンストラクタ
  Article({
    required this.title,
    required this.user,
    this.likesCount = 0,//デフォルトで0
    this.tags = const[],//デフォルトで空配列
    required this.createdAt,
    required this.url,
  });

  //プロパティ
  final String title;
  final User user;
  final int likesCount;
  final List<String> tags;
  final DateTime createdAt;
  final String url;

  // JSONデータからArticleオブジェクトを生成するファクトリメソッド
  factory Article.fromJson(dynamic json){
    // Articleオブジェクトを生成して返す
    return Article(
      title: json['title'] as String,
      user: User.fromJson(json['user']),// User.fromJson()を使ってUserを生成
      url: json['url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),// DateTime.parse()を使って文字列をDateTimeに変換
      likesCount: json['likes_count'] as int,
      tags: List<String>.from(json['tags'].map((tag) => tag['name'])),// List<String>.from()を使ってList<String>に変換
    );
  }
}
