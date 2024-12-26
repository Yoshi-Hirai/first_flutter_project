import 'package:flutter/material.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(
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
            // ネットワーク画像
            const Text(
              'Here is an Network Image:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10), // 余白を追加
            Image.network(
              'https://frame-illust.com/fi/wp-content/uploads/2019/01/flag-hong-kong-400x400.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20), // 余白を追加
            // ローカル画像
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SecondPage(),
                    ));
              },
              child: const Text("Go To Secont Page"),
            ), // 新しいボタンを追加
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

// 新しい画面を定義
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: const Center(
        child: Text(
          "This is the Second Page!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
