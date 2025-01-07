import 'package:flutter/material.dart';

class ImageNetworkButton extends StatelessWidget {
  final String imageUrl; // 画像URL
  final VoidCallback onTap; // タップイベントのコールバック

  const ImageNetworkButton({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.network(
        imageUrl,
        width: 150,
        height: 150,
      ),
    );
  }
}

class ImageAssetButton extends StatelessWidget {
  final String imageAsset; // 画像アセットパス
  final VoidCallback onTap; // タップイベントのコールバック

  const ImageAssetButton({
    super.key,
    required this.imageAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        imageAsset,
        width: 150,
        height: 150,
      ),
    );
  }
}
