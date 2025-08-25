import 'package:ecomm_bloc/presentation/auth/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String fixedUserId = "admin"; // fixed user ID
  String? password;

  final TextEditingController _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPassword();
  }

  void _loadPassword() {
    final box = Hive.box("authBox");
    setState(() {
      password = box.get("password", defaultValue: "1234"); // default pass
    });
  }

  void _changePassword() {
    final newPass = _passController.text.trim();

    if (newPass.isNotEmpty) {
      final box = Hive.box("authBox");
      box.put("password", newPass);

      setState(() {
        password = newPass;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password updated successfully ✅")),
      );

      _passController.clear();
      Navigator.pop(context);
    }
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Change Password"),
        content: TextField(
          controller: _passController,
          obscureText: true,
          decoration: const InputDecoration(labelText: "New Password"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(onPressed: _changePassword, child: const Text("Save")),
        ],
      ),
    );
  }

  /// Logout function
  void _logout() {
    final box = Hive.box("authBox");
    box.put("isLoggedIn", false); // reset login flag

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false, // remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 40),
                ),
                const SizedBox(height: 20),

                // Fixed userId (admin)
                Text(
                  "User ID: $fixedUserId",
                  style: const TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 10),

                // Password (stored / default)
                Text(
                  "Password: ${password ?? ''}",
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: _showChangePasswordDialog,
                  child: const Text("Change Password"),
                ),

                const SizedBox(height: 20),

                /// 🚪 Logout button
                ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Logout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
