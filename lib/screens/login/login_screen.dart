import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../utility/constants.dart';
import '../../widgets/custom_text_field.dart';
import 'provider/login_provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(defaultPadding),
          child: Card(
            color: secondaryColor,
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // App Logo or Title
                      Icon(
                        Icons.admin_panel_settings,
                        size: 60,
                        color: primaryColor,
                      ),
                      SizedBox(height: defaultPadding),
                      Text(
                        'Admin Login',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                      ),
                      SizedBox(height: defaultPadding * 2),

                      // Email Field
                      CustomTextField(
                        labelText: 'Email',
                        controller: provider.emailController,
                        inputType: TextInputType.emailAddress,
                        onSave: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),

                      // Password Field
                      CustomTextField(
                        labelText: 'Password',
                        controller: provider.passwordController,
                        inputType: TextInputType.visiblePassword,
                        onSave: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      // Error Message
                      if (provider.errorMessage.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            provider.errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),

                      SizedBox(height: defaultPadding),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: provider.isLoading
                              ? null
                              : () async {
                                  // Perform login
                                  final email =
                                      provider.emailController.text.trim();
                                  final password =
                                      provider.passwordController.text.trim();

                                  final success =
                                      await provider.login(email, password);
                                  if (success) {
                                    // Navigate to main screen
                                    Get.offAllNamed('/');
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: provider.isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: defaultPadding),

                      // Forgot Password (optional)
                      TextButton(
                        onPressed: () {
                          // Handle forgot password
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
