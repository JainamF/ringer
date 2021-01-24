// // import 'package:artist/helpers/common.dart';
// import 'package:artist/helpers/style.dart';
// // import 'package:artist/provider/user.dart';
// import 'package:artist/screens/Authenticate/login.dart';
// import 'package:artist/services/auth.dart';
// // import 'package:artist/widgets/loading.dart';
// import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// import 'package:artist/screens/Authenticate/signup.dart';

// class ArtistSignUp extends StatefulWidget {
//   @override
//   _ArtistSignUpState createState() => _ArtistSignUpState();
// }

// class _ArtistSignUpState extends State<ArtistSignUp> {
//   final AuthService _auth = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   final _key = GlobalKey<ScaffoldState>();

//   TextEditingController _email = TextEditingController();
//   TextEditingController _password = TextEditingController();
//   TextEditingController _name = TextEditingController();
//   bool hidePass = true;

//   @override
//   Widget build(BuildContext context) {
//     // CUser user = Provider.of<CUser>(context);

//     return Scaffold(
//       key: _key,
//       body: Stack(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey[350],
//                     blurRadius: 20.0, // has the effect of softening the shadow
//                   )
//                 ],
//               ),
//               child: Form(
//                   key: _formKey,
//                   child: ListView(
//                     children: <Widget>[
//                       SizedBox(
//                         height: 40,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Container(
//                             alignment: Alignment.topCenter,
//                             child: Image.asset(
//                               'assets/images/care1.png',
//                               width: 260.0,
//                             )),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                         child: Material(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: Colors.grey.withOpacity(0.3),
//                           elevation: 0.0,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 12.0),
//                             child: ListTile(
//                               title: TextFormField(
//                                 controller: _name,
//                                 decoration: InputDecoration(
//                                     hintText: "Full name",
//                                     icon: Icon(Icons.person_outline),
//                                     border: InputBorder.none),
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return "The name field cannot be empty";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                         child: Material(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: Colors.grey.withOpacity(0.2),
//                           elevation: 0.0,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 12.0),
//                             child: ListTile(
//                               title: TextFormField(
//                                 controller: _email,
//                                 decoration: InputDecoration(
//                                     hintText: "Email",
//                                     icon: Icon(Icons.alternate_email),
//                                     border: InputBorder.none),
//                                 // ignore: missing_return
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     Pattern pattern =
//                                         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                                     RegExp regex = new RegExp(pattern);
//                                     if (!regex.hasMatch(value))
//                                       return 'Please make sure your email address is valid';
//                                     else
//                                       return null;
//                                   }
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                         child: Material(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: Colors.grey.withOpacity(0.3),
//                           elevation: 0.0,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 12.0),
//                             child: ListTile(
//                               title: TextFormField(
//                                 controller: _password,
//                                 obscureText: hidePass,
//                                 decoration: InputDecoration(
//                                     hintText: "Password",
//                                     icon: Icon(Icons.lock_outline),
//                                     border: InputBorder.none),
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return "The password field cannot be empty";
//                                   } else if (value.length < 6) {
//                                     return "the password has to be at least 6 characters long";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               trailing: IconButton(
//                                   icon: Icon(Icons.remove_red_eye),
//                                   onPressed: () {
//                                     setState(() {
//                                       hidePass = !hidePass;
//                                     });
//                                   }),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                         child: Material(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: Colors.black,
//                             elevation: 0.0,
//                             child: MaterialButton(
//                               // _name.text,
//                               onPressed: () async {
//                                 if (_formKey.currentState.validate()) {
//                                   dynamic result = await _auth
//                                       .artistregisterWithEmailAndPassword(
//                                           _name.text,
//                                           _email.text,
//                                           _password.text);
//                                   if (result == null) {
//                                     _key.currentState.showSnackBar(SnackBar(
//                                         content: Text("Sign up failed")));
//                                   } else {
//                                     _key.currentState.showSnackBar(SnackBar(
//                                         content: Text(
//                                             "Email has been Sent, Verify your Email!!!!!")));
//                                     Navigator.of(context).pushAndRemoveUntil(
//                                         MaterialPageRoute(
//                                             builder: (context) => Login()),
//                                         (Route<dynamic> route) => false);
//                                   }
//                                 }
//                               },
//                               minWidth: MediaQuery.of(context).size.width,
//                               child: Text(
//                                 "Sign Up",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20.0),
//                               ),
//                             )),
//                       ),
//                       Row(
//                         children: [
//                           Padding(
//                             padding:
//                                 const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
//                             child: Material(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 color: Colors.black,
//                                 elevation: 0.0,
//                                 child: MaterialButton(
//                                   // _name.text,
//                                   onPressed: () async {
//                                     Navigator.of(context).pushAndRemoveUntil(
//                                         MaterialPageRoute(
//                                             builder: (context) => Login()),
//                                         (Route<dynamic> route) => false);
//                                   },
//                                   minWidth:
//                                       MediaQuery.of(context).size.width / 2,
//                                   child: Text(
//                                     "Already have an Account?",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         color: white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15.0),
//                                   ),
//                                 )),
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
//                             child: Material(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 color: Colors.black,
//                                 elevation: 0.0,
//                                 child: MaterialButton(
//                                   // _name.text,
//                                   onPressed: () async {
//                                     Navigator.of(context).pushAndRemoveUntil(
//                                         MaterialPageRoute(
//                                             builder: (context) => SignUp()),
//                                         (Route<dynamic> route) => false);
//                                   },

//                                   minWidth:
//                                       MediaQuery.of(context).size.width / 3,
//                                   child: Text(
//                                     "User SignUp",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         color: white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15.0),
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       Container(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Center(
//                             child: Text(
//                                 "Note:   After SignUp email will be sent to you,\n            After email is verified you will be able to SignIn"),
//                           ),
//                         ),
//                       )
//                       // Row(
//                       //   children: [
//                       //     Padding(
//                       //         padding: const EdgeInsets.all(8.0),
//                       //         child: InkWell(
//                       //             onTap: () {
//                       //               Navigator.of(context).pushAndRemoveUntil(
//                       //                   MaterialPageRoute(
//                       //                       builder: (context) => Login()),
//                       //                   (Route<dynamic> route) => false);
//                       //             },
//                       //             child: Text(
//                       //               "I already have an account",
//                       //               textAlign: TextAlign.center,
//                       //               style: TextStyle(
//                       //                   color: Colors.black, fontSize: 16),
//                       //             ))),
//                       //     Padding(
//                       //         padding: const EdgeInsets.all(8.0),
//                       //         child: InkWell(
//                       //             onTap: () {
//                       //               Navigator.of(context).pushAndRemoveUntil(
//                       //                   MaterialPageRoute(
//                       //                       builder: (context) => SignUp()),
//                       //                   (Route<dynamic> route) => false);
//                       //             },
//                       //             child: Text(
//                       //               "user signup",
//                       //               textAlign: TextAlign.center,
//                       //               style: TextStyle(
//                       //                   color: Colors.black, fontSize: 16),
//                       //             ))),
//                       //   ],
//                       // ),
//                     ],
//                   )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }