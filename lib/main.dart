import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WebViewController controller;

  num position = 1;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GBK SPM',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WillPopScope(
        onWillPop: () async {
          String url = await controller.currentUrl();
          if (url == "https://sites.google.com/view/gbkspm") {
            exit(0);
          } else {
            controller.goBack();
            return false;
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: position,
              children: [
                WebView(
                  initialUrl: "https://sites.google.com/view/gbkspm",
                  javascriptMode: JavascriptMode.unrestricted,
                  key: key,
                  onPageFinished: doneLoading,
                  onPageStarted: startLoading,
                  onWebViewCreated: (WebViewController wc) {
                    controller = wc;
                  },
                ),
                Container(
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
