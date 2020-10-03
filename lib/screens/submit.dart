import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helloworld_app/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Submit extends StatefulWidget {
  @override
  _SubmitState createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  File pickedImage;
  bool scanError = false;
  bool isImageloaded = false;
  List text = [];
  List skills = [
    'driver',
    'labourer',
    'maid',
    'guard',
    'carpenter',
    'plumber',
    'electrician'
  ];
  Future sendList() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var response = await http.post('$baseUrl/worker/bulkadd',
        headers: headers,
        body: jsonEncode({
          'workersInfo': text,
        }));
    print(response.body);
    setState(() {
      _isInAsyncCall=false;
    });
    print(response.statusCode);
    return response.statusCode;
  }
  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    int counter = 0;
    Map<String, String> currentObject = {
      "mobile": "",
      "skillIndex": "",
      "pinCode": ""
    };
    setState(() {
      scanError = false;
    });
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        if (counter % 3 == 0) {
          String pattern = r'^\+91[0-9]{10}$';
          RegExp regExp = new RegExp(pattern);
          if (regExp.hasMatch(line.text.trim())) {
            currentObject['mobile'] = line.text.trim();
          } else {
            setState(() {
              scanError = true;
            });
            print("mobile");
          }
        }
        if (counter % 3 == 1) {
          var tempIndex = skills.indexOf(line.text.toLowerCase().trim());
          if (tempIndex >= 0) {
            currentObject['skillIndex'] = (tempIndex + 1).toString();
          } else {
            setState(() {
              scanError = true;
            });
            print("skillIndex");
          }
        }
        if (counter % 3 == 2) {
          String pinPattern = r'^[0-9]{6}$';
          RegExp regExp = new RegExp(pinPattern);
          if (regExp.hasMatch(line.text.trim())) {
            currentObject['pinCode'] = line.text.trim();
          } else {
            setState(() {
              scanError = true;
            });
            print("Pincode");
          }
          text.add(Map.from(currentObject));
        }
        counter++;
//        for(TextElement word in line.elements){
//          print(word.text);}
      }
    }
    print(text);
    print(scanError);
    setState(() {});
  }

  Future pickImage() async {
    File file = await FilePicker.getFile(type: FileType.image);
    setState(() {
      pickedImage = file;
      isImageloaded = true;
    });
  }

  String getSkill(String index) {
    return skills.elementAt(int.parse(index) - 1);
  }

  bool _isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isInAsyncCall,
      opacity: 0.5,
      progressIndicator: SpinKitDoubleBounce(color: Colors.blue),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Create",
                    style: kConstHeadingStyle.copyWith(fontSize: 36),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "One place to add all your workers",
                    style: kConstTextStyle.copyWith(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 350,
                    width: 400,
                    decoration: BoxDecoration(
                        color: kConstBlueColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            height: 220,
                            width: 150,
                            child: pickedImage == null
                                ? Image.asset(
                                    'images/sample.png',
                                    fit: BoxFit.fill,
                                  )
                                : Image.file(
                                    pickedImage,
                                    fit: BoxFit.fill,
                                  ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.blue,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        ButtonTheme(
                            height: 40,
                            minWidth: 200,
                            child: FlatButton(
                              color: kConstBlueColor,
                              onPressed: pickedImage == null
                                  ? null
                                  : () async {
                                      text.clear();
                                      await readText();
                                      if (scanError == true) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Processing Error. Kindly add a better quality image.',
                                            style: kConstTextStyle.copyWith(color: Colors.white),),
                                          backgroundColor: kConstBlueColor,
                                        );
                                        await Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                              child: Text(
                                'Generate List',
                                style: kConstTextStyle.copyWith(
                                    color: Colors.white, fontSize: 16),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  side: BorderSide(color: Colors.white)),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'List of Workers :',
                    style:
                        kConstTextStyle.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                        child: text.length == 0 || scanError == true
                            ? Text(
                                'No list generated',
                                style: kConstTextStyle.copyWith(fontSize: 14),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: text.length,
                                itemBuilder:
                                    (BuildContext context, int index) => Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.person,
                                      ),
                                      title: Text(
                                          getSkill(text[index]['skillIndex']),
                                          style: kConstTextStyle),
                                      isThreeLine: true,
                                      subtitle: Text(
                                        text[index]['pinCode'] +
                                            "            " +
                                            text[index]['mobile'],
                                        style: kConstTextStyle.copyWith(
                                            color: kConstBlueColor,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: kConstBlueColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: ButtonTheme(
                          height: 40,
                          minWidth: 200,
                          child: FlatButton(
                            onPressed: text.length == 0 || scanError == true
                                ? null
                                : () async{
                              setState(() {
                                _isInAsyncCall=true;
                              });
                              if(await sendList()==200){
                                final snackBar = SnackBar(
                                  content: Text(
                                    'Workers have been added to our database',
                                    style: kConstTextStyle.copyWith(color: Colors.white),),
                                  backgroundColor: kConstBlueColor,
                                );
                                await Scaffold.of(context)
                                    .showSnackBar(snackBar);
                              }else{
                                final snackBar = SnackBar(
                                  content: Text(
                                    'Error. Please try again',
                                    style: kConstTextStyle.copyWith(color: Colors.white),),
                                  backgroundColor: kConstBlueColor,
                                );
                                await Scaffold.of(context)
                                    .showSnackBar(snackBar);
                              }

                            },
                            child: Text(
                              'Add Workers',
                              style:
                                  kConstTextStyle.copyWith(color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
