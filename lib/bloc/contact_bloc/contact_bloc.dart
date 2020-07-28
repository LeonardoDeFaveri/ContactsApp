import 'dart:async';

import 'package:Contacts/model/contact.dart';
import 'package:Contacts/service/contacts_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactsManager _service = ContactsManager();
  ContactBloc() : super(ContactInitial());

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    if (event is GetContact) {
      yield ContactLoading();
      final contact = await _service.getContact(event.id, null);
      yield ContactLoaded(contact);
    }
  }
}
