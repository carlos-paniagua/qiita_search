import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qiita_search/models/article.dart';
import 'package:qiita_search/models/user.dart';

import '../widgets/article_container.dart';

// 検索画面のウィジェットを表すSearchScreenクラス
class SearchScreen extends StatefulWidget {
  // SearchScreenクラスのコンストラクタ
  const SearchScreen({super.key});
  // Stateオブジェクトを作成する createState メソッドの実装
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

// SearchScreenのStateオブジェクトを管理するための_SearchScreenStateクラス
class _SearchScreenState extends State<SearchScreen> {
  List<Article> articles = []; // 検索結果を格納する変数

  // ビルドメソッドの実装
  @override
  Widget build(BuildContext context) {
    // スキャフォールド（画面の基本構造）を作成
    return Scaffold(
      // アプリケーションバーを設定
      appBar: AppBar(
        // アプリケーションバーのタイトル
        title: const Text('Qiita Search'),
      ),

      // 画面のメインコンテンツを表示するためのコンテナ
      body: Column(
        //検索ボックス
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
            child: TextField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: '検索ワードを入力してください',
              ),
              onSubmitted: (String value) async {
                final results = await searchQiita(value); // ← 検索処理を実行する
                setState(() => articles = results); // 検索結果を代入
              },
            ),
          ),

          //検索結果一覧
          // ArticleContainer(
          //   article: Article(
          //     title: 'テスト',
          //     user: User(
          //       id: 'quii-taro',
          //       profileImageUrl: 'https://firebasestorage.googleapis.com/v0/b/gs-expansion-test.appspot.com/o/unknown_person.png?alt=media',
          //     ),
          //     createdAt: DateTime.now(),
          //     tags: ['Flutter','dart'],
          //     url:'https://example.com',
          //   ),
          // ),
          Expanded(
            child: ListView(
              children: articles.map((article) => ArticleContainer(article: article)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Article>> searchQiita(String keyword) async {
    // 1. http通信に必要なデータを準備をする
    // Uri.https([baseUrl], [Urlパス], Map<String,dynamic>[クエリパラメータ])
    final uri = Uri.https('qiita.com', '/api/v2/items', {
      'query': 'title:$keyword',
      'per_page': '10',
    });
    //アクセストークンの取得
    final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

    // 2. Qiita APIにリクエストを送る
    final http.Response res = await http.get(uri, headers: {
      'Authorization': 'Bearer &token', // アクセストークンをヘッダーに追加
    });

    // 3. 戻り値をArticleクラスの配列に変換
    // 4. 変換したArticleクラスの配列を返す(returnする)
    if (res.statusCode == 200) {
      final List<dynamic> body = jsonDecode(res.body);
      return body.map((dynamic json) => Article.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
