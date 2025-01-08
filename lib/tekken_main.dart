import 'package:flutter/material.dart';

class TekkenMainPage extends StatelessWidget {
  final String title; // タイトルを受け取るプロパティ
  final String message; // メッセージを受け取るプロパティ

  const TekkenMainPage({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
