import 'package:flutter/material.dart';

import 'package:first_flutter_project/button.dart';

class TimelinePostWidget extends StatelessWidget {
  final String message; // テキストタイトル
  final List<ImageAssetButton> buttons; // ボタンリスト

  const TimelinePostWidget({
    super.key,
    required this.message,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttons
              .map((button) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: button.onTap,
                      child: Image.asset(
                        button.imageAsset,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
