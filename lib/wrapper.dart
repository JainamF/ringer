import 'package:ringer/provider/user.dart';
// import 'package:artist/screens/Authenticate/authenticate.dart';
import 'package:ringer/screens/Authenticate/login.dart';
import 'package:ringer/screens/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CUser>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Login();
    } else {
      return MainPage(user.uid);
    }
  }
}
