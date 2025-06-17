abstract class UserStates {}

class UserInit extends UserStates {}

class UserLoading extends UserStates {}

class UserLoadingMoreDateState extends UserStates {}

class UserEmptyState extends UserStates {}

class UserSuccess extends UserStates {}

class UserSuccessMoreDateState extends UserStates {}

class UserFailedMoreDateState extends UserStates {
  final String error;

  UserFailedMoreDateState(this.error);
}

class UserFailed extends UserStates {
  final String error;

  UserFailed(this.error);
}
