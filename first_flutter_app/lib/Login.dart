import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
  final Function (bool) onLoginSuccess;

  const LoginScreen({super.key, required this.onLoginSuccess});

}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final String correctUsername = "arda";
  final String correctPassword = "123";


  void _validateLogin() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (_usernameController.text == correctUsername && _passwordController.text == correctPassword) {
      widget.onLoginSuccess(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid username or password')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.login, size: 100, color: Colors.blueAccent),
                SizedBox(height: 24),
                Text('Welcome Back!', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 16),
                _buildTextField('Username', _usernameController, Icons.person),
                SizedBox(height: 16),
                _buildTextField('Password', _passwordController, Icons.lock, obscureText: true),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _validateLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: Icon(icon),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Successful'), backgroundColor: Colors.green),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text('Login Successful!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: EdgeInsets.symmetric(vertical: 14)),
              child: Text('Go Back', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
