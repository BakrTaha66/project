import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:full_project/screens/nav_screens/chat_screen.dart';
import 'package:full_project/services/auth.dart';
import 'package:full_project/services/database.dart';
import 'package:full_project/widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = Auth().currentUser;

  final databaseMethods = DatabaseMethods();

  final fireStore = FirebaseFirestore.instance;
  final String collectionName = 'users';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0b021c),
        title: Text(user?.email ?? 'User email'),
      ),
      backgroundColor: Color(0xff170048).withOpacity(1.0),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: fireStore.collection(collectionName).snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? homeData(snapshot.data)
                  : snapshot.hasError
                      ? Text('Error')
                      : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

Widget homeData(dynamic data) {
  return Container(
    child: ListView.builder(
      itemCount: data.docs.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            name: data.docs[index]['name'],
                          )));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff0b021c).withOpacity(0.40),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: ClipOval(
                  child: Image.asset('assets/images/onboarding_one.png'),
                ),
                title: Text(
                  '${data.docs[index]['name']}',
                  style: customTextTile(),
                ),
                subtitle: Text(
                  '${data.docs[index]['email']}',
                  style: customTextTileEmail(),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
