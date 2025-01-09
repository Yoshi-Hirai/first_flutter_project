import 'package:flutter/material.dart';

import 'package:first_flutter_project/timeline.dart';
import 'package:first_flutter_project/button.dart';

// 新しい画面を定義
class MainPage extends StatefulWidget {
  final String name; // 渡されたデータ
  final String mailaddress;

  const MainPage({super.key, required this.name, required this.mailaddress});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> _postData = []; // 空のリストを初期化
  final TextEditingController _controllerPost = TextEditingController();

  @override
  void dispose() {
    _controllerPost.dispose(); // コントローラーのリソースを解放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page !!"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: ${widget.name} numPost: $_postData.length',
              style: const TextStyle(fontSize: 12),
            ),
/*
            const SizedBox(height: 20),
            Text(
              'Mail: ${widget.mailaddress}',
              style: const TextStyle(fontSize: 12),
            ),
*/
            const SizedBox(height: 20),
            if (_postData.length > 0)
              Expanded(
                child: ListView.builder(
                  itemCount: _postData.length,
                  itemBuilder: (context, index) {
                    final postData = _postData[_postData.length - index - 1];
                    return TimelinePostWidget(
                      message: postData,
                      buttons: [
                        ImageAssetButton(
                          imageAsset: 'assets/images/good.png',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('You chose good!')),
                            );
                          },
                        ),
                        ImageAssetButton(
                          imageAsset: 'assets/images/heart.png',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('You chose heart!')),
                            );
                          },
                        ),
                        ImageAssetButton(
                          imageAsset: 'assets/images/cry.png',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('You chose cry!')),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
/*
              for (int i = 0; i < _numPost; i++)
                [
                  TimelinePostWidget(
                    message: _postData[0],
                    buttons: [
                      ImageAssetButton(
                        imageAsset: 'assets/images/good.png',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('You chose good!')),
                          );
                        },
                      ),
                      ImageAssetButton(
                        imageAsset: 'assets/images/heart.png',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('You chose heart!')),
                          );
                        },
                      ),
                      ImageAssetButton(
                        imageAsset: 'assets/images/cry.png',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('You chose cry!')),
                          );
                        },
                      ),
                    ],
                  ),
                ]
*/
            const SizedBox(height: 20),
            // 改行付きテキストフィールド
            TextField(
              controller: _controllerPost,
              maxLines: null, // 改行を許可
              keyboardType: TextInputType.multiline, // 改行ボタンを表示
              decoration: const InputDecoration(
                labelText: 'Enter your message',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _postData.add(_controllerPost.text);
                });
                // 入力内容をダイアログで表示
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Your Message'),
                    content: Text(_controllerPost.text),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
