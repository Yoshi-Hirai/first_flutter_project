import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:first_flutter_project/button.dart';
import 'package:first_flutter_project/tekken_main.dart';
import 'package:first_flutter_project/talesarise/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // アプリの主な色をカスタマイズ
        // primarySwatch : アプリ全体のテーマカラーを設定。
        primarySwatch: Colors.teal,
        // scaffoldBackgroundColor : 背景色を変更。
        scaffoldBackgroundColor: Colors.teal.shade50,
        // FAB（+ボタン）の色を設定。
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.teal, // FABボタンの色
          foregroundColor: Colors.white, // FABボタンのアイコンの色
        ),
        // テキストスタイルをカスタマイズ
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            // 見出しの設定
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
            fontFamily: 'Roboto',
          ),
          bodyMedium: TextStyle(
            // 本文の設定
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController =
      TextEditingController(); // 入力を管理するコントローラー
  final TextEditingController _mailaddressController = TextEditingController();

  int _counter = 0;
  String _inputName = '';
  String _response = "Press the button to fetch data.";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _navigateToSecontPage() {
    if (_nameController.text.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(
                name: _nameController.text,
                mailaddress: _mailaddressController.text),
          ));
    } else {
      // 入力が空の場合のエラーダイアログ
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('error'),
          content: const Text('Please enter some text'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // サーバーからデータを取得する関数
  Future<void> fetchData() async {
    final url = Uri.parse('http://localhost:8080/timeline');
    try {
      final response = await http.get(url); // GETリクエストを送信

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _response = "data: ${data['racedata']}\nBody: ${data['body']}";
        });
      } else {
        setState(() {
          _response = "Failed to load data: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _response = "Error occurred: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:',
                style: Theme.of(context).textTheme.bodyMedium),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20), // 余白を追加
            // WEBリクエストするボタンを追加
            ElevatedButton(
              onPressed: fetchData,
              child: const Text("Request"),
            ), // 新しいボタンを追加
            const SizedBox(height: 20), // 余白を追加
            // TextFieldウィジェットを追加
            TextField(
                controller: _nameController,
                onChanged: (text) {
                  setState(() {
                    _inputName = text; // 入力値を更新
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Your Name', // フィールドラベル
                  border: OutlineInputBorder(), // 枠線
                )),
            const SizedBox(height: 20), // 余白を追加
            // 入力値を表示
            Text('Your Name : $_inputName',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20), // 余白を追加
            // TextFieldウィジェットを追加
            TextField(
                controller: _mailaddressController,
                decoration: const InputDecoration(
                  labelText: 'Enter Your Mail Address', // フィールドラベル
                  border: OutlineInputBorder(), // 枠線
                )),
            const SizedBox(height: 20), // 余白を追加
            Text(
              _response,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10), // 余白を追加
            // ネットワーク画像
            Image.network(
              'https://www.bandainamco.co.jp/assets/movie/thumb-top-cm-movie.jpg',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20), // 余白を追加
            // ローカル画像
/*
            const Text(
              'Here is an Local Asset Image:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10), // 余白を追加
            Image.asset(
              'assets/images/bandainamco.png',
              width: 150,
              height: 150,
            ),
            ElevatedButton(
              onPressed: _navigateToSecontPage,
              child: const Text("Go To Secont Page"),
            ), // 新しいボタンを追加
            ImageNetworkButton(
              imageUrl:
                  'https://frame-illust.com/fi/wp-content/uploads/2019/01/flag-hong-kong-400x400.png',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('image network button pressed!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ), // 新しい画像ボタンを追加
*/
            ImageAssetButton(
              imageAsset: 'assets/images/tekken.jpg',
              onTap: () {
                // TekkenMainPageにデータを渡して遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TekkenMainPage(
                      title: 'Tekken Main Page',
                      message: 'This is Tekken fun club Main Page!',
                    ),
                  ),
                );
              },
            ), // 新しい画像ボタンを追加
            ImageAssetButton(
              imageAsset: 'assets/images/talesarise.png',
              onTap: _navigateToSecontPage,
            ), // 新しい画像ボタンを追加
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
