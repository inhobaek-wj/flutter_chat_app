import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,String password,String userName,bool isLogin, BuildContext ctx) async {
    AuthResult _authResult;

    try {
      setState(() {
          _isLoading = true;
      });

      if (isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
          email: email,password: password);
      } else {
        // create user or sign an existing user using firebase.
        _authResult = await _auth.createUserWithEmailAndPassword(
          email: email,password: password);
      }

      await Firestore.instance.collection('users').document(_authResult.user.uid).setData({
          'userName': userName,
          'email': email,
      });

    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials';

      if (err.message != null ) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
      ));

      setState(() {
          _isLoading = false;
      });
    } catch (err) {
      print(err);

      setState(() {
          _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      body: AuthForm(_submitAuthForm,_isLoading),
    );
  }
}
