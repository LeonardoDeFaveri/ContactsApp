import 'dart:convert';

import 'package:Contacts/bloc/user_bloc/user_bloc.dart';
import 'package:Contacts/model/user.dart';
import 'package:Contacts/routes/routes.dart';
import 'package:Contacts/translations_managament/app_localizations.dart';
import 'package:Contacts/util/prefs_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

class LoginPage extends StatefulWidget {
  final bool changedCredentials;

  LoginPage({this.changedCredentials = false});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserBloc _userBloc = UserBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _formEmpty = true;
  String _email = "";
  String _password = "";

  Widget _buildLoginForm() {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF73AEF5),
                Color(0xFF61A4F1),
                Color(0xFF478DE0),
                Color(0xFF398AE5),
              ],
              stops: [0.1, 0.4, 0.7, 0.9],
            ),
          ),
        ),
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 120.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.instance.translate('sign_in'),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _buildEmailTF(),
                  SizedBox(
                    height: 30.0,
                  ),
                  _buildPasswordTF(),
                  _buildForgotPasswordBtn(),
                  _buildLoginBtn(),
                  _buildSignupBtn(),
                ],
              ),
              onChanged: _onFormChange,
              onWillPop: _onWillPop,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.instance.translate('email'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: AppLocalizations.instance.translate('email_hint'),
              hintStyle: kHintTextStyle,
            ),
            onSaved: (value) => _email = value,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.instance.translate('password'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: AppLocalizations.instance.translate('password_hint'),
              hintStyle: kHintTextStyle,
            ),
            onSaved: (value) => _password = value,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          AppLocalizations.instance.translate('change_password_hint'),
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          AppLocalizations.instance.translate('login').toUpperCase(),
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        onPressed: _formEmpty
            ? null
            : () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  _tryLogin();
                }
              },
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: AppLocalizations.instance.translate('create_new_user_hint'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: " ${AppLocalizations.instance.translate('sign_up')}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 5.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: BlocListener(
          cubit: _userBloc,
          listener: (context, state) async {
            if (state is UserLoggedIn) {
              if (state.logged) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString(
                    PrefsKeys.USER, jsonEncode(state.user.toJson()));
                Navigator.of(context).popAndPushNamed(RoutesNames.CONTACTS);
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: <Widget>[
                        Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        Padding(
                          child: Text(
                            AppLocalizations.instance
                                .translate('wrong_credentials'),
                          ),
                          padding: EdgeInsets.only(left: 5),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          },
          child: BlocProvider(
            create: (context) => _userBloc,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserInitial) {
                    return _buildLoginForm();
                  } else if (state is UserLoggingIn) {
                    return _buildLoading();
                  } else if (state is UserLoggedIn && !state.logged) {
                    return _buildLoginForm();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onFormChange() {
    _formKey.currentState.save();
    setState(() {
      _formEmpty = !(_email.trim().isNotEmpty && _password.isNotEmpty);
    });
  }

  Future<bool> _onWillPop() {
    if (_formEmpty) return Future<bool>.value(true);

    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              AppLocalizations.instance.translate('form_leaving_confirmation'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(AppLocalizations.instance.translate('cancel')),
                textColor: Colors.black,
                onPressed: () => Navigator.pop(context, false),
              ),
              FlatButton(
                child: Text(AppLocalizations.instance.translate('confirm')),
                textColor: Colors.red,
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _userBloc.close();
  }

  void _tryLogin() {
    final user = User.fromClear(_email.trim(), _password.trim());
    _userBloc.add(Login(user));
  }
}
