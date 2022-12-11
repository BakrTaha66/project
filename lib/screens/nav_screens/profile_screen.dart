import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final _picker = ImagePicker();
  var imgValue;

  Future getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    final File image = File(pickedFile!.path);

    setState(() {
      _image = image;
    });
  }

  Future uploadImageToFirebase() async {
    String fileName = basename(_image!.path);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference ref = firebaseStorage
        .ref()
        .child('upload/$fileName' + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image!);

    uploadTask.then((res) {
      res.ref.getDownloadURL().then((value) => imgValue = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff170048),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: _image != null
                        ? ClipOval(
                            child: Image.file(
                              _image!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        // ? Text('error')
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 200,
                            height: 200,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Gallery'),
                  onTap: () {
                    getImageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ));
        });
  }
}
