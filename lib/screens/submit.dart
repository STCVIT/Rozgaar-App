import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class Submit extends StatefulWidget {
  @override
  _SubmitState createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  File pickedImage;
  bool scanError=false;
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
      scanError=false;
    });
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        if (counter % 3 == 0) {
          String pattern = r'^\+91[0-9]{10}$';
          RegExp regExp = new RegExp(pattern);
          if(regExp.hasMatch(line.text.trim())){
            currentObject['mobile'] =line.text.trim();
          }
          else{
            setState(() {
              scanError=true;
            });
          }
        }
        if (counter % 3 == 1) {
          var tempIndex=skills.indexOf(line.text.toLowerCase().trim());
          if(tempIndex>=0){
            currentObject['skillIndex'] =
                (tempIndex+ 1).toString();
          }
          else{
            setState(() {
              scanError=true;
            });
          }
        }
        if (counter % 3 == 2) {
          String pinPattern=r'^[0-9]{6}$';
          RegExp regExp = new RegExp(pinPattern);
          if(regExp.hasMatch(line.text.trim())){
            currentObject['pinCode'] = line.text.trim();
          }
          else{
            setState(() {
              scanError=true;
            });
          }
          text.add(Map.from(currentObject));
        }
        counter++;
//        for(TextElement word in line.elements){
//          print(word.text);}
      }
    }
    print(text);
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
  bool _isInAsyncCall=false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isInAsyncCall,
      opacity: 0.5,
      progressIndicator: SpinKitDoubleBounce(color: Colors.blue),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
                'Add Workers',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
              )),
        ),
        body: SafeArea(
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        height: 350,
                        width: 250,
                        child: pickedImage == null
                            ? Image.asset('images/sample.png',fit: BoxFit.fill,)
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ButtonTheme(
                        height: 40,
                        minWidth: 200,
                        child: FlatButton(
                          color: pickedImage == null
                              ? Colors.white
                              : Colors.blue,
                          onPressed: pickedImage ==null?null:() async {
                            text.clear();
                            await readText();
                            if(scanError==true){
                              final snackBar = SnackBar(
                                content: Text(
                                  'Processing Error. Kindly add a better quality image.',style: TextStyle(color: Colors.white,fontFamily: 'Eina'),
                                ),
                                backgroundColor:Colors.blue ,
                              );
                              await Scaffold.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: Text(
                            'Generate List',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Eina',
                                color: pickedImage == null
                                    ? Colors.blue
                                    : Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                              side: BorderSide(color: Colors.blue)),
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'List of Workers :',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                      child: text.length == 0 || scanError == true
                          ? Text(
                        'No list generated',
                        style: TextStyle(fontSize: 14),
                      )
                          : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: text.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.person,
                                    color: Colors.blue,
                                  ),
                                  title: Text(
                                    getSkill(text[index]['skillIndex']),
                                    style: TextStyle(
                                        fontFamily: 'Eina',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue),
                                  ),
                                  isThreeLine: true,
                                  subtitle: Text(text[index]['pinCode'] +
                                      "            " +
                                      text[index]['mobile']),
                                ),
                                Divider(),
                              ],
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: ButtonTheme(
                        height: 40,
                        minWidth: 200,
                        child: FlatButton(
                          color: text.length == 0 ||scanError==true
                              ? Colors.white
                              : Colors.blue,
                          onPressed: text.length == 0 || scanError==true
                              ? null
                              : (){},
                          child: Text(
                            'Add Workers',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Eina',
                                color: text.length == 0 || scanError==true
                                    ? Colors.blue
                                    : Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                              side: BorderSide(color: Colors.blue)),
                        )),
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

