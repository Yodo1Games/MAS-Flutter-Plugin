import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:testmasfluttersdktwo/testmasfluttersdktwo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    Yodo1MAS.instance.init("So8agkD7H7", (successful) {

    });
    Yodo1MAS.instance.showBannerAd();
    initPlatformState();
    Yodo1MAS.instance.showBannerAd();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    Yodo1MAS.instance.showBannerAd();
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(child: Column(children: <Widget>[
        Container(
        margin: EdgeInsets.all(25),
          child: TextButton(
            child: Text('SignUp', style: TextStyle(fontSize: 20.0),),
            onPressed: () {
              Yodo1MAS.instance.showBannerAd();
              Yodo1MAS.instance.showInterstitialAd();
            },
          ),
        ),
        ]
      ),
    ),

      ),
    );
  }
}
