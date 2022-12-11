import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:full_project/helper/date_time.dart';
import 'package:full_project/services/auth.dart';
import 'package:full_project/services/database.dart';
import 'package:full_project/widgets/widget.dart';
import 'package:path/path.dart';

class ChatScreen extends StatefulWidget {
  final String? name;
  ChatScreen({
    this.name,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final fireStore = FirebaseFirestore.instance;
  final User? user = Auth().currentUser;
  final databaseMethods = DatabaseMethods();
  final String collectionChat = 'chat';
  final String collectionUser = 'users';
  TextEditingController msgController = TextEditingController();

  addMsg() {
    fireStore.collection(collectionChat).add({
      'msg': msgController.text,
      'senderID': widget.name,
      'time': FieldValue.serverTimestamp(),
    });
    msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0b021c),
        title: Text('${widget.name}'),
      ),
      backgroundColor: Color(0xff170048),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            fireStore.collection(collectionChat).orderBy('time').snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? chatBody(snapshot.data)
              : snapshot.hasError
                  ? Text('Error')
                  : CircularProgressIndicator();
        },
      ),
    );
  }

  Widget chatBody(dynamic data) {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: ListView.builder(
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: widget.name == data.docs[index]['senderID']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xff0b021c).withOpacity(0.40),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Container(
                              width: 150,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 6, top: 6),
                                child: Text(
                                  data.docs[index]['msg'] ?? '',
                                  style: customTextTile(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 4),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                  formattedDate(data.docs[index]['time']),
                                  style: customTextTileEmail()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(color: Color(0xff0b021c)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: TextFormField(
                          decoration: customTextFieldChat('Enter your message'),
                          controller: msgController,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundColor: Color(0xff170048),
                      radius: 25,
                      child: IconButton(
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          addMsg();
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
