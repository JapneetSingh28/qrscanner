//import 'package:flutter/material.dart';
//
//import 'Cart/AddToCart.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//        title: 'Flutter Demo',
//        debugShowCheckedModeBanner: false,
//        theme: ThemeData(
//
//          primarySwatch: Colors.blue,
//        ),
//        home: AddToCart());
//  }
//}

//mm

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:qrscanner/ui/home.dart';
//import 'package:qrscanner/ui/login.dart';
//import 'package:qrscanner/ui/splash.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MainScreen(),
//    );
//  }
//}
//
//
//class MainScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return StreamBuilder(
//      stream: FirebaseAuth.instance.onAuthStateChanged,
//      builder: (context,AsyncSnapshot<FirebaseUser> snapshot) {
//        if(snapshot.connectionState == ConnectionState.waiting)
//          return SplashPage();
//        if(!snapshot.hasData || snapshot.data == null)
//          return LoginPage();
//        return HomePage();
//      },
//    );
//  }
//}

//mm

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrscanner/Cart/AddToCart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signing',
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          return AddToCart();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

//class SignInPage extends StatelessWidget {
//
//  Future<void> _signInAnonymously() async {
//    try {
//      await FirebaseAuth.instance.signInAnonymously();
//    } catch (e) {
//      print(e);
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(centerTitle: true,
//        title: Text(
//          'Sign in',
//          style: TextStyle(color: Colors.white),
//        ),
//        backgroundColor: Colors.black54,
//      ),
//      body: WillPopScope(
//        onWillPop: _onBackPressed,
//        child: Center(
//          child: RaisedButton(
//            color: Colors.black54,
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text('Sign in anonymously',style: TextStyle(color: Colors.white,fontSize: 20),),
//            ),
//            onPressed: _signInAnonymously,
//          ),
//        ),
//      ),
//    );
//  }
//}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Do you really want to exit?",
            style: TextStyle(fontFamily: 'OpenSansRegular', fontSize: 18.5),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "No",
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              child: Text(
                "Yes",
              ),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ));
  }

  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text(
          'Sign in',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black54,
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Center(
          child: RaisedButton(
            color: Colors.black54,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Sign in anonymously',style: TextStyle(color: Colors.white,fontSize: 20),),
            ),
            onPressed: _signInAnonymously,
          ),
        ),
      ),
    );
  }
}

