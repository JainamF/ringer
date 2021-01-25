import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MainPage extends StatefulWidget {
  final String docid;
  MainPage(this.docid);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FlutterLocalNotificationsPlugin fltrNotification =
      FlutterLocalNotificationsPlugin();
  TextEditingController _emailController = TextEditingController();
  String _email;
  String _uid;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    var androidInitilize =
        new AndroidInitializationSettings("@mipmap/ic_launcher");
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
    User user = auth.currentUser;
    _uid = user.uid;
    getEmail();
  }

  Future<void> getEmail() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(_uid)
        .get()
        .then((documentSnapshot) {
      _email = documentSnapshot.data()['email'].toString();
    });
  }

  Future<void> _sendNotification() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Notify");
    if (_emailController.text != null) {
      await collectionReference
          .add({'from': '$_email', 'to': '${_emailController.text}'});
    }
  }

  Future<void> _showNotification(String from) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fltrNotification.show(
        0, '$from', 'has triggered notification', platformChannelSpecifics,
        payload: '$from');
  }

  Future<void> notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("$payload"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Hello"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Notify").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> qdslist = querySnapshot.docs;
            qdslist.forEach((qdsElement) {
              if (_email == qdsElement.data()['to']) {
                _showNotification('${qdsElement.data()['from']}');
                FirebaseFirestore.instance
                    .collection("Notify")
                    .doc(qdsElement.id)
                    .delete();
              }
            });
          }
          return new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendNotification,
        tooltip: 'Send Notification',
        child: new Icon(Icons.notifications),
      ),
    );
  }
}
