import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// LoginScreen is a stateless widget for the login page
class LoginScreen extends StatelessWidget {
  // Controllers for the email and password text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (query.docs.isNotEmpty) {
        // login success
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login successful!')));
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // login failed
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Invalid email or password.')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter email and password.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with title and actions (⋮ menu)
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert), // ⋮ icon
            onPressed: () {
              // Show a bottom sheet menu when ⋮ is pressed
              showModalBottomSheet(
                context: context,
                builder: (context) => ListView(
                  shrinkWrap: true,
                  children: [
                    // About menu item
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('About'),
                      onTap: () {
                        Navigator.pop(context); // Close the bottom sheet
                        // Show About dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('About'),
                            content: Text(
                              'This is a simple login screen example.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    // Help menu item
                    ListTile(
                      leading: Icon(Icons.help_outline),
                      title: Text('Help'),
                      onTap: () {
                        Navigator.pop(context); // Close the bottom sheet
                        // Show Help dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Help'),
                            content: Text(
                              'Enter your email and password to log in. '
                              'If you do not have an account, tap Register.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      // Main body with login form
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo or image at the top
              Image.asset('assets/uwase.jpg', height: 120),
              SizedBox(height: 24),
              // Email input field
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                textAlign: TextAlign.center,
              ),
              // Password input field
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Login button
              ElevatedButton(
                onPressed: () => login(context),
                child: Text('Login'),
              ),
              // Register button
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
