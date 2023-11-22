import 'package:flutter/material.dart';
import 'package:qiita_search/screens/search_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async{
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

// MainAppクラス: アプリケーションのエントリーポイントとなるウィジェット
class MainApp extends StatelessWidget {
  // MainAppクラスのコンストラクタ
  const MainApp({super.key});

  // ビルドメソッドの実装
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      // アプリケーションのタイトル
      title: 'Qiita Search',
      // アプリのテーマデータ
      theme: ThemeData(
        // プライマリーカラーの設定
        primarySwatch: Colors.green,
        // フォントファミリーの設定
        fontFamily: 'Hiragino Sans',
        // アプリバーのテーマデータ
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF55C500),
        ),
        // テキストのテーマデータ
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
        ),
      ),

      // アプリケーションのホーム画面としてSearchScreenを指定
      home:const SearchScreen(),
    );
  }
}
