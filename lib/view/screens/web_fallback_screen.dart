import 'package:flutter/material.dart';

class WebFallbackScreen extends StatelessWidget {
  const WebFallbackScreen({
    Key? key,
    required String homePageURL,
    required Color backgroundColor,
  })  : _homePageURL = homePageURL,
        _backgroundColor = backgroundColor,
        super(key: key);

  final String _homePageURL;

  final Color _backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Center(
        child: Text(
          "Not available on Web yet! Please visit: " + _homePageURL + " 🤪",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
