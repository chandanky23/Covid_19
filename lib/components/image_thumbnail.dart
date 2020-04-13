import 'package:flutter/material.dart';

class ImageThumbnail extends StatelessWidget {
  final String _imageUrl;
  ImageThumbnail(this._imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: 30.0, width: 50.0),
        child: _imageUrl != 'null'
            ? FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading_fingers.gif',
                image: _imageUrl,
                fit: BoxFit.cover,
              )
            : Image.asset('assets/images/notfound.png', fit: BoxFit.cover));
  }
}
