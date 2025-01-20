import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:first_flutter_project/timeline.dart';
import 'package:first_flutter_project/button.dart';

// 新しい画面を定義
class MainPage extends StatefulWidget {
  final String accountid; // 渡されたデータ
  final String accountname;

  const MainPage(
      {super.key, required this.accountid, required this.accountname});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> _postData = []; // 空のリストを初期化
  bool _isLoading = false;
  String _response = '';
  final TextEditingController _controllerPost = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTimeline(); // 初期データ取得
  }

  @override
  void dispose() {
    _controllerPost.dispose(); // コントローラーのリソースを解放
    super.dispose();
  }

  // ページ遷移時にtimelineを取得するリクエストを実行
  Future<void> _fetchTimeline() async {
    final url = Uri.parse('http://localhost:8080/timeline');
    setState(() {
      _isLoading = true; // ローディング状態
    });

    try {
      final response = await http.get(url); // GETリクエストを送信
      if (response.statusCode == 200) {
        //debugPrint(response.body);
        //debugPrint(response.body.isEmpty.toString());
        final data = json.decode(response.body);
        if (data == null || data.isEmpty) {
          setState(() {
            _isLoading = false;
          });
        } else {
          setState(() {
            _postData
                .add("Name: ${data['accountname']}\nText: ${data['text']}");
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _postData.add("Failed to load data: ${response.statusCode}");
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _postData.add("Error occurred: $e");
        _isLoading = false;
      });
    }
  }

  // タイムラインに投稿するリクエスト
  Future<void> _PostedTimeline(String text) async {
    const String url = 'http://localhost:8080/timeline'; // APIエンドポイント
    final Map<String, dynamic> postData = {
      'action': 'Posted',
      'boardId': 1,
      'accountId': 24,
      'text': 'おはようございます。',
      'captionUrl': '',
    };
    postData['accountId'] = widget.accountid;
    postData['text'] = text;

    try {
      // POSTリクエストを送信
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(postData), // データをJSON形式に変換
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        setState(() {
          _response = "Post successful: ${response.body}";
          _postData
              .add("Name: ${data[0]['accountname']}\nText: ${data[0]['text']}");
        });
      } else {
        setState(() {
          _response = "Failed with status code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _response = "Error: $e";
      });
    }
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
              'accountId: ${widget.accountid} accountName: ${widget.accountname} \nresponse: $_response',
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
              onPressed: () => _PostedTimeline(_controllerPost.text),
/*
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
*/
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
