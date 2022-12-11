// uploadImage() async {
//   final _firebaseStorage = FirebaseStorage.instance;
//   final _imagePicker = ImagePicker();
//   PickedFile? image;
//
//   // check permissions
//   await Permission.photos.request();
//   var permissionStatus = await Permission.photos.status;
//
//   if (permissionStatus.isGranted) {
//     // Select Image
//     image = await _imagePicker.getImage(source: ImageSource.gallery);
//     var file = File(image!.path);
//
//     if (image != null) {
//       // Upload to Firebase
//
//       var snapshot = await _firebaseStorage
//           .ref()
//           .child('images/imageName')
//           .putFile(file);
//       var downloadUrl = await snapshot.ref.getDownloadURL();
//       setState(() {
//         imageUrl = downloadUrl;
//       });
//     } else {
//       print('No Image Path Received');
//     }
//   } else {
//     print('Permission not granted. Try Again with permission');
//   }
// }

// late User user;
//
// @override
// void initState() {
//   super.initState();
//
//   user = UserPreferences.getUser();
// }
// String? imageUrl;
// final User? user = Auth().currentUser;
//
// final databaseMethods = DatabaseMethods();
//
// final fireStore = FirebaseFirestore.instance;
// final String collectionName = 'users';
//
// final _firebaseStorage = FirebaseStorage.instance;
// File? photo;
// final ImagePicker _picker = ImagePicker();
//
// Future imgFromGallery() async {
//   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//
//   setState(() {
//     if (pickedFile != null) {
//       photo = File(pickedFile.path);
//       uploadFile();
//     } else {
//       print('No image selected');
//     }
//   });
// }
//
// Future imgFromCamera() async {
//   final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//
//   setState(() {
//     if (pickedFile != null) {
//       photo = File(pickedFile.path);
//       uploadFile();
//     } else {
//       print('No image selected');
//     }
//   });
// }
//
// Future uploadFile() async {
//   if (photo == null) return;
//   final fileName = basename(photo!.path);
//   final destination = 'files/$fileName';
//
//   try {
//     final ref = FirebaseStorage.instance.ref(destination).child('file/');
//     await ref.putFile(photo!);
//   } catch (e) {
//     print('error occured');
//   }
// }

// appBar: AppBar(
//   title: Text(
//     'Upload Image',
//     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//   ),
//   centerTitle: true,
//   elevation: 0.0,
//   backgroundColor: Colors.white,
// ),
// body: Container(
//   color: Colors.white,
//   child: Column(
//     children: <Widget>[
//       Container(
//         margin: EdgeInsets.all(15),
//         padding: EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(
//             Radius.circular(15),
//           ),
//           border: Border.all(color: Colors.white),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               offset: Offset(2, 2),
//               spreadRadius: 2,
//               blurRadius: 1,
//             ),
//           ],
//         ),
//         child: (imageUrl != null)
//             ? Image.network(imageUrl!)
//             : Image.network('https://i.imgur.com/sUFH1Aq.png'),
//       ),
//       SizedBox(
//         height: 20,
//       ),
//       ElevatedButton(
//         onPressed: () {
//           // uploadImage();
//         },
//         child: Text(
//           'Upload Image',
//           style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 20),
//         ),
//         style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18.0),
//                 side: BorderSide(color: Colors.blue)),
//             elevation: 5.0,
//             padding: EdgeInsets.fromLTRB(15, 15, 15, 15)),
//       ),
//     ],
//   ),
// ),

// void _showPicker(context) {
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return SafeArea(
//             child: Container(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Gallery'),
//                 onTap: () {
//                   imgFromGallery();
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_camera),
//                 title: Text('Camera'),
//                 onTap: () {
//                   imgFromCamera();
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           ),
//         ));
//       });
// }

// Widget infoBody(dynamic data) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             _showPicker(context);
//           },
//           child: CircleAvatar(
//               radius: 55,
//               backgroundColor: Colors.white,
//               child: photo != null
//                   ? ClipRRect(
//                       borderRadius: BorderRadius.circular(50),
//                       child: Image.file(
//                         photo!,
//                         width: 200,
//                         height: 200,
//                         fit: BoxFit.fitHeight,
//                       ),
//                     )
//                   // ? Text('error')
//                   : Container(
//                       decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(50)),
//                       width: 100,
//                       height: 100,
//                       child: Icon(
//                         Icons.camera_alt,
//                         color: Colors.grey[800],
//                       ),
//                     )),
//         ),
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: data.docs.length,
//                   itemBuilder: (context, index) {
//                     return Text(
//                       '${data.docs[index]['name']}',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }

//   appBar: AppBar(),
//   body: Padding(
//   padding: const EdgeInsets.only(top: 40),
//   child: ListView(
//   padding: EdgeInsets.symmetric(horizontal: 32),
//   physics: BouncingScrollPhysics(),
//   children: [
//   ProfileWidget(
//   imagePath: user.imagePath,
//   isEdit: true,
//   onClicked: () async {
//   final image =
//       await ImagePicker().getImage(source: ImageSource.gallery);
//
//   if (image == null) return;
//
//   final directory = await getApplicationDocumentsDirectory();
//   final name = basename(image.path);
//   final imageFile = File('${directory.path}/$name');
//   final newImage = await File(image.path).copy(imageFile.path);
//
//   setState(() => user = user.copy(imagePath: newImage.path));
// },
// ),
// ],
// ),
// ),
