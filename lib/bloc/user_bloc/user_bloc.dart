import 'dart:async';

import 'package:Contacts/model/contact.dart';
import 'package:Contacts/model/user.dart';
import 'package:Contacts/service/contacts_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ContactsManager _service = ContactsManager();
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is Login) {
      yield UserLoggingIn();
      final logged = await _service.testCredentials(event.user);
      yield UserLoggedIn(logged, event.user);
    }
  }
}
