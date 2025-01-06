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
  final TextEditingController _nameController =
      TextEditingController(); // 入力を管理するコントローラー
  final TextEditingController _mailaddressController = TextEditingController();

  int _counter = 0;
  String _inputName = '';

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
            builder: (context) => SecondPage(
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
              onPressed: _navigateToSecontPage,
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
  final String name; // 渡されたデータ
  final String mailaddress;

  const SecondPage({super.key, required this.name, required this.mailaddress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Input",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'Name: $name',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Mail: $mailaddress',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
