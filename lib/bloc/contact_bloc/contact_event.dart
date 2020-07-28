part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class GetContact extends ContactEvent {
  final int id;

  GetContact(this.id);

  @override
  List<Object> get props => [id];
}
