import 'dart:convert';
import 'dart:io';

import 'package:Contacts/model/contact.dart';
import 'package:Contacts/model/user.dart';
import 'package:http/http.dart';

/// Gestisce la comunicazione con il web service ContactsAPI.
class ContactsManager {
  final Client _client = Client();
  final String _endPoint = 'http://truecloud.ddns.net:9000/contacts/api';

  /// Controlla che le credenziali dell'utente siano corrette.
  ///
  /// Restituisce true se le credenziali sono valide, altrimenti false
  Future<bool> testCredentials(User user) async {
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader:
          'Basic ${_prepareAuthorizationHeader(user)}',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    String data = jsonEncode({
      "justLogin": true,
    });
    final response = await _client.post(
      '$_endPoint/users/',
      headers: headers,
      body: data,
    );

    return response.statusCode == 200;
  }

  /// Estrae un contatto in base al suo [id].
  ///
  /// Restituisce il contatto se è stato trovato, altrimenti null
  Future<Contact> getContact(int id, User user) async {
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader:
          'Basic ${_prepareAuthorizationHeader(user)}',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final response = await _client.get(
      '$_endPoint/contacts/$id',
      headers: headers,
    );

    if (response.statusCode == 200) {
      String body = response.body;
      return Contact.fromJson(json.decode(body));
    } else {
      return null;
    }
  }

  String _prepareAuthorizationHeader(User user) {
    return base64Encode(utf8.encode('${user.email}:${user.password}'));
  }
}
