import 'package:api_news_flutter/connect/auth.dart';
import 'package:api_news_flutter/model/httpException.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Register, Login }

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  //We declare the default setting for _authMode with a variable.
  AuthMode _authMode = AuthMode.Login;
  var _isLoading = false;
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  final _checkPassController = TextEditingController();
  var _isObscure = true;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _changeObscureText() {
    if (_isObscure == true) {
      setState(() {
        _isObscure = false;
      });
    } else {
      setState(() {
        _isObscure = true;
      });
    }
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error Occured'),
          content: Text(msg),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('close'))
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      //If not Validate/Succed
      return;
    } //else
    //save the form
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        //Log in User
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email']!,
          _authData['password']!,
        );
      } else if (_authMode == AuthMode.Register) {
        //Register User
        await Provider.of<Auth>(context, listen: false).signUp(
          _authData['email']!,
          _authData['password']!,
        );
        _showErrorDialog('Register Successful');
      }
    } on HttpException catch (e) {
      //error inside the rest_api
      _showErrorDialog(e.toString());
    } catch (error) {
      //error outside the rest_api
    }
    setState(() {
      _isLoading = false;
    });
  }

  //Call the switchAuthMode after the user login/register
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authData.clear();
        _authMode = AuthMode.Register;
      });
    } else {
      setState(() {
        _authData.clear();
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _authMode == AuthMode.Login
        ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 9.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('E-mail:'),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: _userController,
                        onSaved: (newValue) {
                          _authData['email'] = newValue!;
                        },
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Email is not valid';
                          }
                        },
                      ),
                      Text('Password'),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: _isObscure,
                        autofocus: false,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            isDense: true,
                            suffixIcon: IconButton(
                                onPressed: _changeObscureText,
                                icon: Icon(Icons.remove_red_eye_sharp))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is empty';
                          }
                        },
                        onSaved: (newValue) {
                          _authData['password'] = newValue!;
                        },
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            onPressed: _submit, child: Text('Login')),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: _switchAuthMode,
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          )
        : Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 9.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email:'),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: _userController,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Email is not valid';
                          }
                        },
                        onSaved: (newValue) {
                          _authData['email'] = newValue!;
                        },
                      ),
                      Text('Password'),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        autofocus: false,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            isDense: true,
                            suffixIcon: IconButton(
                                onPressed: _changeObscureText,
                                icon: Icon(Icons.remove_red_eye_sharp))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is empty';
                          }
                        },
                        onSaved: (newValue) {
                          _authData['password'] = newValue!;
                        },
                      ),
                      Text('Confirm Password'),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: _isObscure,
                        autofocus: false,
                        controller: _checkPassController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Confirm Password is empty';
                          } else if (value != _passwordController.text) {
                            return 'Confirm Password did not match';
                          }
                        },
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            onPressed: _submit, child: Text('Register')),
                      ),
                      if (_isLoading)
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      else
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(10.0),
                          child: TextButton(
                            onPressed: _switchAuthMode,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ],
                  )),
            ),
          );
  }
}
