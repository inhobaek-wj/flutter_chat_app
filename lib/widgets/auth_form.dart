import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = false;
  String _email = '';
  String _name = '';
  String _password = '';

  void _trySubmin() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (value) {
                      _email = value;
                    },
                  ),

                  if (!_isLogin)
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Password must be at least 4 characters.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'User name',
                    ),
                    onSaved: (value) {
                      _name = value;
                    },
                  ),

                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _password = value;
                  },                  ),

                  SizedBox(height: 12,),

                  RaisedButton(
                    child: Text(_isLogin?'Login':'Signup'),
                    onPressed: () {},
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin ? 'Create new account':'I already have an account'),
                    onPressed: () {
                      setState(() {
                          _isLogin = !_isLogin;
                      });
                    },
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}
