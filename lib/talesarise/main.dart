import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:first_flutter_project/timeline.dart';
import 'package:first_flutter_project/button.dart';

class PostInformation {
  final int messageUniqueId;
  final int boardId;
  final int accountId;
  final String accountName;
  final String postTime;
  final String text;
  final String captionUrl;

  PostInformation(this.messageUniqueId, this.boardId, this.accountId,
      this.accountName, this.postTime, this.text, this.captionUrl);

/*
  @override
  String toString() => 'User(name: $name, age: $age)';
*/

  // JSONから構造体を生成
  factory PostInformation.fromJson(Map<String, dynamic> json) {
    return PostInformation(
        json['messageuniqueid'],
        json['boardid'],
        json['accountid'],
        json['accountname'],
        json['posttime'],
        json['text'],
        json['captionurl']);
  }

  // UserをJSONに変換
  Map<String, dynamic> toJson() {
    return {
      'messageuniqueid': messageUniqueId,
      'boardid': boardId,
      'accountid': accountId,
      'accountname': accountName,
      'posttime': postTime,
      'text': text,
      'captionurl': captionUrl
    };
  }
}

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
  List<PostInformation> _postData = []; // 空のリストを初期化
  bool _isLoading = false;
  String _response = '';
  final TextEditingController _controllerPost = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 初期データ取得
    //_fetchTimeline();
    _PostedTimeline("acquisition", "");
  }

  @override
  void dispose() {
    _controllerPost.dispose(); // コントローラーのリソースを解放
    super.dispose();
  }

  // 使用しない
  // ページ遷移時にtimelineを取得するリクエストを実行(Get)
  Future<void> _fetchTimeline() async {
    final url = Uri.parse('http://localhost:8080/timeline');
    setState(() {
      _isLoading = true; // ローディング状態
    });

    try {
      final response = await http.get(url); // GETリクエストを送信
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data == null || data.isEmpty) {
          setState(() {
            _isLoading = false;
          });
        } else {
          setState(() {
            PostInformation single = PostInformation.fromJson(data);
            _postData.add(single);
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // タイムラインに投稿するリクエスト
  Future<void> _PostedTimeline(String act, String text) async {
    const String url = 'http://localhost:8080/timeline'; // APIエンドポイント
    final Map<String, dynamic> postData = {
      'action': 'Posted',
      'boardId': 1,
      'accountId': 24,
      'text': 'おはようございます。',
      'captionUrl': '',
    };
    postData['action'] = act;
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
          if (data is List) {
            // List<dynamic>を構造体（Userオブジェクト）に変換
            List<PostInformation> plural =
                data.map((item) => PostInformation.fromJson(item)).toList();
            _postData.add(plural[0]);
            debugPrint(plural.length.toString());
          } else if (data is Map) {
            PostInformation singular =
                PostInformation.fromJson(Map<String, dynamic>.from(data));
            _postData.add(singular);
          }
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
                      caption: postData.messageUniqueId.toString() +
                          " " +
                          postData.postTime,
                      message: postData.text,
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
              onPressed: () => _PostedTimeline("post", _controllerPost.text),
/*
              onPressed: () {
                setState(() {
                  _tempPostData.add(_controllerPost.text);
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
