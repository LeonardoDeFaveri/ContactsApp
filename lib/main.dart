import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/user.dart';
import 'pages/contacts_page.dart';
import 'pages/login_page.dart';
import 'routes/routes.dart';
import 'service/contacts_manager.dart';
import 'util/prefs_keys.dart';
import 'translations_managament/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ContactsApp());
}

class ContactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = 'Contacts';
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('it', 'IT'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routes: {
        RoutesNames.LOGIN: (context) => LoginPage(),
        RoutesNames.CONTACTS: (context) => ContactsPage(),
      },
      home: Scaffold(
        body: MyHomePage(title: title),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<SharedPreferences> loadPrefs() async {
    return await SharedPreferences.getInstance();
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
    return FutureBuilder(
      future: loadPrefs(),
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.data == null) return _buildLoading();

        if (snapshot.data.getString(PrefsKeys.USER) == null) return LoginPage();

        User user =
            User.fromJson(jsonDecode(snapshot.data.getString(PrefsKeys.USER)));
        final ContactsManager _service = ContactsManager();
        return FutureBuilder(
          future: _service.testCredentials(user),
          builder: (context, snapshot) {
            if (snapshot.data == null) return _buildLoading();

            if (snapshot.data) return ContactsPage();

            return LoginPage(changedCredentials: true);
          },
        );
      },
    );
  }
}
