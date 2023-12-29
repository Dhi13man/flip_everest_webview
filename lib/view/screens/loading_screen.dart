import 'package:flutter/material.dart';

/// Items shown in initial Loading screen with logo.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key, required this.loadingScreenBackgroundColor})
      : super(key: key);

  final Color loadingScreenBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      alignment: Alignment.center,
      color: loadingScreenBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image(
                height: 150,
                width: 250,
                image: AssetImage('assets/logobg.png')),
          ),
          CircularProgressIndicator(color: Colors.white),
        ],
      ),
    );
  }
}
