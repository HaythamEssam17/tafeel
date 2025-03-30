abstract class LangState {}

class AppInitialLangState extends LangState {}

class GetLangState extends LangState {}

class UpdateLangState extends LangState {}

class UpdateNewLangState extends LangState {

  UpdateNewLangState();
}
class ErrorLangState extends LangState {
  final String error;

  ErrorLangState(this.error);
}
