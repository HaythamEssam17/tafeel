abstract class UserDetailsStates {}

class UserDetailsInit extends UserDetailsStates {}

class UserDetailsLoading extends UserDetailsStates {}

class UserDetailsSuccess extends UserDetailsStates {}

class UserDetailsFailed extends UserDetailsStates {
  final String error;

  UserDetailsFailed(this.error);
}
