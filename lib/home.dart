import 'package:flutter/material.dart';
import 'package:flutter_mlkit/detectors/label.dart';
import 'package:flutter_mlkit/models/page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Page> pages = <Page>[
    Page(page: LabelDetectionPage(), title: 'Label Dectection'),
  ];
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Label Detection'),
        elevation: 0.0,
      ),
      body: pages[currentPageIndex].page,
    );
  }
}
