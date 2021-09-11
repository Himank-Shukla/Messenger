// class ChatScreen extends StatefulWidget {
//   //final User user;
//   final TextEditingController _message = TextEditingController();
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final Map<String, dynamic> userMap;
//   final String chatRoomId;
//   ChatScreen({this.chatRoomId, this.userMap});
//   //ChatScreen({this.user});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _message = TextEditingController();
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   void onSendMessage() async {
//     if (_message.text.isNotEmpty) {
//       Map<String, dynamic> messages = {
//         "sendby": _auth.currentUser.displayName,
//         "message": _message.text,
//         "time": FieldValue.serverTimestamp()
//       };
//
//       await _firestore
//           .collection('chatroom')
//           .doc(chatRoomId)
//           .collection('chats')
//           .add(messages);
//       _message.clear();
//     }
//     else{
//       print("Enter Text");
//     }
//   }
//   _buildMessage(Message message, bool isMe) {
//     final Container msg = Container(
//       margin: isMe
//           ? EdgeInsets.only(
//               top: 8.0,
//               bottom: 8.0,
//               left: 80.0,
//             )
//           : EdgeInsets.only(
//               top: 8.0,
//               bottom: 8.0,
//             ),
//       padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
//       width: MediaQuery.of(context).size.width * 0.75,
//       decoration: BoxDecoration(
//         color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
//         borderRadius: isMe
//             ? BorderRadius.only(
//                 topLeft: Radius.circular(15.0),
//                 bottomLeft: Radius.circular(15.0),
//               )
//             : BorderRadius.only(
//                 topRight: Radius.circular(15.0),
//                 bottomRight: Radius.circular(15.0),
//               ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             message.time,
//             style: TextStyle(
//               color: Colors.blueGrey,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Text(
//             message.text,
//             style: TextStyle(
//               color: Colors.blueGrey,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: _firestore
//                         .collection('chatroom')
//                         .doc(chatRoomId)
//                         .collection('chats')
//                         .snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.data != null) {
//                         return ListView.builder(
//                           itemCount: snapshot.data.docs.length,
//                           itemBuilder: (context, index) {
//                             return Text(snapshot.data.docs[index]['message']);
//                           },
//                         );
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//     if (isMe) {
//       return msg;
//     }
//     return Row(
//       children: <Widget>[
//         msg,
//         IconButton(
//           icon: message.isLiked
//               ? Icon(Icons.favorite)
//               : Icon(Icons.favorite_border),
//           iconSize: 30.0,
//           color: message.isLiked
//               ? Theme.of(context).primaryColor
//               : Colors.blueGrey,
//           onPressed: () {},
//         )
//       ],
//     );
//   }
//
//   _buildMessageComposer() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.0),
//       height: 70.0,
//       color: Colors.white,
//       child: Row(
//         children: <Widget>[
//           IconButton(
//             icon: Icon(Icons.photo),
//             iconSize: 25.0,
//             color: Theme.of(context).primaryColor,
//             onPressed: () {},
//           ),
//           Expanded(
//             child: TextField(
//               controller: _message,
//               textCapitalization: TextCapitalization.sentences,
//               onChanged: (value) {},
//               decoration: InputDecoration.collapsed(
//                 hintText: 'Send a message...',
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             iconSize: 25.0,
//             color: Theme.of(context).primaryColor,
//             onPressed: onSendMessage,
//           ),
//         ],
//       ),
//     );
//   }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     backgroundColor: Theme.of(context).primaryColor,
//   //     appBar: AppBar(
//   //       title: Text(
//   //         userMap['name'],
//   //         //widget.user.name,
//   //         style: TextStyle(
//   //           fontSize: 28.0,
//   //           fontWeight: FontWeight.bold,
//   //         ),
//   //       ),
//   //       elevation: 0.0,
//   //       actions: <Widget>[
//   //         IconButton(
//   //           icon: Icon(Icons.more_horiz),
//   //           iconSize: 30.0,
//   //           color: Colors.white,
//   //           onPressed: () {},
//   //         ),
//   //       ],
//   //     ),
//   //     body: GestureDetector(
//   //       onTap: () => FocusScope.of(context).unfocus(),
//   //       child: Column(
//   //         children: <Widget>[
//   //           Expanded(
//   //             child: Container(
//   //               decoration: BoxDecoration(
//   //                 color: Colors.white,
//   //                 borderRadius: BorderRadius.only(
//   //                   topLeft: Radius.circular(30.0),
//   //                   topRight: Radius.circular(30.0),
//   //                 ),
//   //               ),
//   //               child: ClipRRect(
//   //                 borderRadius: BorderRadius.only(
//   //                   topLeft: Radius.circular(30.0),
//   //                   topRight: Radius.circular(30.0),
//   //                 ),
//   //                 child: ListView.builder(
//   //                   reverse: true,
//   //                   padding: EdgeInsets.only(top: 15.0),
//   //                   itemCount: messages.length,
//   //                   itemBuilder: (BuildContext context, int index) {
//   //                     final Message message = messages[index];
//   //                     final bool isMe = message.sender.id == currentUser.id;
//   //                     return _buildMessage(message, isMe);
//   //                   },
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //           _buildMessageComposer(),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }
////////////////////////////////////////////////////////////////////////////////////////////////
// class ChatScreen extends StatelessWidget {
//   final TextEditingController _message = TextEditingController();
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final Map<String, dynamic> userMap;
//   final String chatRoomId;
//   ChatScreen({this.chatRoomId, this.userMap});
//
//
//
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   void onSendMessage() async {
//     if (_message.text.isNotEmpty) {
//       Map<String, dynamic> messages = {
//         "sendby": _auth.currentUser.displayName,
//         "message": _message.text,
//         "time": FieldValue.serverTimestamp()
//       };
//
//       await _firestore
//           .collection('chatroom')
//           .doc(chatRoomId)
//           .collection('chats')
//           .add(messages);
//       _message.clear();
//     }
//     else{
//       print("Enter Text");
//     }
//   }
//   _buildMessage(Message message, bool isMe) {
//     final Container msg = Container(
//       margin: isMe
//           ? EdgeInsets.only(
//         top: 8.0,
//         bottom: 8.0,
//         left: 80.0,
//       )
//           : EdgeInsets.only(
//         top: 8.0,
//         bottom: 8.0,
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
//       //width: MediaQuery.of(context).size.width * 0.75,
//       decoration: BoxDecoration(
//         color: isMe ? Color(0xFFFEF9EB) : Color(0xFFFFEFEE),
//         borderRadius: isMe
//             ? BorderRadius.only(
//           topLeft: Radius.circular(15.0),
//           bottomLeft: Radius.circular(15.0),
//         )
//             : BorderRadius.only(
//           topRight: Radius.circular(15.0),
//           bottomRight: Radius.circular(15.0),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             message.time,
//             style: TextStyle(
//               color: Colors.blueGrey,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Text(
//             message.text,
//             style: TextStyle(
//               color: Colors.blueGrey,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: _firestore
//                         .collection('chatroom')
//                         .doc(chatRoomId)
//                         .collection('chats')
//                         .snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.data != null) {
//                         return ListView.builder(
//                           itemCount: snapshot.data.docs.length,
//                           itemBuilder: (context, index) {
//                             return Text(snapshot.data.docs[index]['message']);
//                           },
//                         );
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//     if (isMe) {
//       return msg;
//     }
//     return Row(
//       children: <Widget>[
//         msg,
//         IconButton(
//           icon: message.isLiked
//               ? Icon(Icons.favorite)
//               : Icon(Icons.favorite_border),
//           iconSize: 30.0,
//           color: message.isLiked
//               ? Colors.red
//               : Colors.blueGrey,
//           onPressed: () {},
//         )
//       ],
//     );
//   }
//
//   _buildMessageComposer() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.0),
//       height: 70.0,
//       color: Colors.white,
//       child: Row(
//         children: <Widget>[
//           IconButton(
//             icon: Icon(Icons.photo),
//             iconSize: 25.0,
//             color: Colors.red,
//             onPressed: () {},
//           ),
//           Expanded(
//             child: TextField(
//               controller: _message,
//               textCapitalization: TextCapitalization.sentences,
//               onChanged: (value) {},
//               decoration: InputDecoration.collapsed(
//                 hintText: 'Send a message...',
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             iconSize: 25.0,
//             color: Colors.red,
//             onPressed: onSendMessage,
//           ),
//         ],
//       ),
//     );
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       appBar: AppBar(
//         title: Text(
//           userMap['name'],
//           //widget.user.name,
//           style: TextStyle(
//             fontSize: 28.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         elevation: 0.0,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.more_horiz),
//             iconSize: 30.0,
//             color: Colors.white,
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30.0),
//                     topRight: Radius.circular(30.0),
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30.0),
//                     topRight: Radius.circular(30.0),
//                   ),
//                   child: ListView.builder(
//                     reverse: true,
//                     padding: EdgeInsets.only(top: 15.0),
//                     itemCount: messages.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final Message message = messages[index];
//                       final bool isMe = message.sender.id == currentUser.id;
//                       return _buildMessage(message, isMe);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             _buildMessageComposer(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatScreen({this.chatRoomId, this.userMap});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onSendMessage() async {
    DateTime now=DateTime.now();
     print(now.hour.toString()+":"+now.minute.toString());
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser.displayName,
        "message": _message.text,
        "time": FieldValue.serverTimestamp(),
        "timestamp":now.hour.toString()+":"+now.minute.toString(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream:
              _firestore.collection("users").doc(userMap['uid']).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Container(
                child: Column(
                  children: [
                    Text(
                      userMap['name'],
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Text(
                    //   snapshot.data['status'],
                    //   style: TextStyle(fontSize: 14),
                    // ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),

      // AppBar(
//         title: Text(
//           userMap['name'],
//           //widget.user.name,
//           style: TextStyle(
//             fontSize: 28.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         elevation: 0.0,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.more_horiz),
//             iconSize: 30.0,
//             color: Colors.white,
//             onPressed: () {},
//           ),
//         ],
//       ),

      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: size.height / 1.25,
                        width: size.width,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('chatroom')
                              .doc(chatRoomId)
                              .collection('chats')
                              .orderBy("time", descending: true)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.data != null) {
                              return ListView.builder(
                                reverse: true,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> map =
                                      snapshot.data.docs[index].data();
                                  return messages(size, map);
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      Container(
                        height: size.height / 10,
                        width: size.width,
                        alignment: Alignment.center,
                        child: Container(
                          height: size.height / 12,
                          width: size.width / 1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.photo),
                                iconSize: 25.0,
                                color: Colors.red,
                                onPressed: () {},
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _message,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  onChanged: (value) {},
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Send a message...',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.send),
                                iconSize: 25.0,
                                color: Colors.red,
                                onPressed: onSendMessage,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment: map['sendby'] == _auth.currentUser.displayName
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: map['sendby'] == _auth.currentUser.displayName
            ? EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 80.0,
              )
            : EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                right: 80.0,
              ),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        //width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: map['sendby'] == _auth.currentUser.displayName
              ? Color(0xFFFEF9EB)
              : Color(0xFFFFEFEE),
          borderRadius: map['sendby'] == _auth.currentUser.displayName
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                map['timestamp'],
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                map['message'],
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]),
      ),
    );
  }
}

//_buildMessage(Message message, bool isMe) {
//     final Container msg = Container(
//       margin: map['sendby'] == _auth.currentUser.displayName
//           ? EdgeInsets.only(
//         top: 8.0,
//         bottom: 8.0,
//         left: 80.0,
//       )
//           : EdgeInsets.only(
//         top: 8.0,
//         bottom: 8.0,
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
//       //width: MediaQuery.of(context).size.width * 0.75,
//       decoration: BoxDecoration(
//         color: map['sendby'] == _auth.currentUser.displayName ? Color(0xFFFEF9EB) : Color(0xFFFFEFEE),
//         borderRadius: map['sendby'] == _auth.currentUser.displayName
//             ? BorderRadius.only(
//           topLeft: Radius.circular(15.0),
//           bottomLeft: Radius.circular(15.0),
//         )
//             : BorderRadius.only(
//           topRight: Radius.circular(15.0),
//           bottomRight: Radius.circular(15.0),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             map['time'],
//             style: TextStyle(
//               color: Colors.blueGrey,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Text(
//             map['message'],
//             style: TextStyle(
//               color: Colors.blueGrey,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),

//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: _firestore
//                         .collection('chatroom')
//                         .doc(chatRoomId)
//                         .collection('chats')
//                         .snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.data != null) {
//                         return ListView.builder(
//                           itemCount: snapshot.data.docs.length,
//                           itemBuilder: (context, index) {
//                             return Text(snapshot.data.docs[index]['message']);
//                           },
//                         );
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//     if (isMe) {
//       return msg;
//     }
//     return Row(
//       children: <Widget>[
//         msg,
//         IconButton(
//           icon: message.isLiked
//               ? Icon(Icons.favorite)
//               : Icon(Icons.favorite_border),
//           iconSize: 30.0,
//           color: message.isLiked
//               ? Colors.red
//               : Colors.blueGrey,
//           onPressed: () {},
//         )
//       ],
//     );
//   }
//
