import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mlkit/models/label.dart';
import 'package:image_picker/image_picker.dart';

class LabelDetectionPage extends StatefulWidget {
  @override
  _LabelDetectionPageState createState() => _LabelDetectionPageState();
}

class _LabelDetectionPageState extends State<LabelDetectionPage> {
  File _image;
  List<MLKitLabel> mlkitLabels = List<MLKitLabel>();

  Widget _labelList() {
    return new ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: mlkitLabels.length,
      itemBuilder: (_, int index) {
        var _ = mlkitLabels[index];
        return ListTile(
          title: Text(_.text),
          subtitle: Text('${_.confidence}'),
        );
      },
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
    LabelDetector labelDetector = FirebaseVision.instance.labelDetector();
    List<Label> labels = await labelDetector.detectInImage(visionImage);
    var _mlkitLabels = List<MLKitLabel>();
    for (Label label in labels) {
      final MLKitLabel mlKitLabel = MLKitLabel(
        text: label.label,
        entityId: label.entityId,
        confidence: label.confidence,
      );

      _mlkitLabels.add(mlKitLabel);
    }

    setState(() {
      _image = image;
      mlkitLabels = _mlkitLabels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _image == null
          ? Center(
              child: Text(
                'No image selected.',
                style: TextStyle(fontSize: 24.0),
              ),
            )
          : Column(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Image.file(
                    _image,
                    height: 350.0,
                  ),
                ),
                Expanded(child: _labelList()),
              ],
            ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
