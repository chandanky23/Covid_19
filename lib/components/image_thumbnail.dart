import 'package:flutter/material.dart';

class ImageThumbnail extends StatelessWidget {
  final String _imageUrl;
  // final String _accessToken = '25156b8f-6d72-4c88-9453-5af8b6b1438f';
  // final String _firebasePath =
  //     'https://firebasestorage.googleapis.com/v0/b/covid-19-tracker-302dd.appspot.com/o/images%2Fflags%2F';
  // final String _flagUrl = 'https://www.countryflags.io/';
  // final String _flagStyle = 'flat';
  // final String _imageSize = '24.png';
  // :country_code/:style/:size.png'

  ImageThumbnail(this._imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: 30.0, width: 50.0),
        child: _imageUrl != 'null'
            ? FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading_fingers.gif',
                // image: '$_flagUrl$_imageCode/$_flagStyle/$_imageSize',
                image: _imageUrl,
                fit: BoxFit.cover,
              )
            : Image.asset('assets/images/notfound.png', fit: BoxFit.cover));
  }
}
