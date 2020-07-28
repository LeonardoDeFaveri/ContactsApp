part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

/// L'utente sta accedendo al proprio account.
class Login extends UserEvent {
  final User user;

  Login(this.user);

  @override
  List<Object> get props => user.props;
}

/// L'utente sta cercando di registrare un account.
class Register extends UserEvent {
  final Contact contact;

  Register(this.contact);

  @override
  List<Object> get props => contact.props;
}

/// L'utente vuole eliminare il proprio account.
class Delete extends UserEvent {
  @override
  List<Object> get props => [];
}
