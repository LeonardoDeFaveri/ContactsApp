part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

/// Si è verificato un errore.
class UserError extends UserState {
  final bool serviceUnreachable;
  final bool timeoutExceded;

  UserError({this.serviceUnreachable = false, this.timeoutExceded = false});

  @override
  List<Object> get props => [this.serviceUnreachable, this.timeoutExceded];
}

/// L'utente sta eseguendo il processo di accesso.
class UserLoggingIn extends UserState {
  @override
  List<Object> get props => [];
}

/// Il processo di accesso è terminato o con un successo o con un fallimento.
class UserLoggedIn extends UserState {
  final bool logged;
  final User user;

  UserLoggedIn(this.logged, this.user);

  @override
  List<Object> get props => [user.props, logged];
}
