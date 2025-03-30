import 'package:flutter/material.dart';

class LoginForm {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
  }

  void clear() {
    phoneController.clear();
    passwordController.clear();
  }
}
