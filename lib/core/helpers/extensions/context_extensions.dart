import 'package:tafeal/core/presentation/routes/route_argument_model.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  /// [hideKeyboard] a function to close the keyboard.
  void hideKeyboard() => FocusScope.of(this).requestFocus(FocusNode());

  /// [theme] is a [ThemeData] that contains information about screen theme.
  ThemeData get theme => Theme.of(this);

  /// [textTheme] is a [TextTheme] that contains information about screen text theme.
  TextTheme get textTheme => Theme.of(this).textTheme;

  Future<Object?> pushNamed(String routeName, [RouteArgument? arguments]) {
    return Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  Future<Object?> pushNamedAndRemoveUntil(String routeName) {
    return Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false);
  }

  Future<Object?> pushReplacementNamed(
    String routeName, [
    RouteArgument? arguments,
  ]) {
    return Navigator.pushReplacementNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  void pop() {
    return Navigator.pop(this);
  }
}
