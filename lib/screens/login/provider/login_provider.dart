import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    setLoading(true);
    setErrorMessage('');

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // For demo purposes, accept the test credentials
      if (email == 'admin@gmail.com' && password == '1234567890') {
        setLoading(false);
        return true;
      } else {
        setErrorMessage(
            'Invalid credentials. Use admin@gmail.com / password1234567890 for testing.');
        setLoading(false);
        return false;
      }
    } catch (e) {
      setErrorMessage('Login failed. Please try again.');
      setLoading(false);
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
