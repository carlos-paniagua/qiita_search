import 'package:flutter/material.dart';

// Userクラス: ユーザーの情報を表現するクラス
class User{
  //コンストラクタ
  User({
    required this.id,
    required this.profileImageUrl,
  });

  //プロパティ
  final String id;// ユーザーID
  final String profileImageUrl;// プロフィール画像のURL

   // JSONデータからUserオブジェクトを生成するファクトリメソッド
  factory User.fromJson(dynamic json){
    // Userオブジェクトを生成して返す
    return User(
      id: json['id'] as String,
      profileImageUrl: json['profile_image_url'] as String,
      //展開した値は as <データ型> と明記する事で指定したデータ型へキャストする
    );
  }
}

