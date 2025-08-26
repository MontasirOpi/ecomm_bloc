import 'package:ecomm_bloc/presentation/auth/login/ui/login_screen.dart';
import 'package:ecomm_bloc/presentation/profile/bloc/profile_bloc.dart';
import 'package:ecomm_bloc/presentation/profile/bloc/profile_event.dart';
import 'package:ecomm_bloc/presentation/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfile());
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
          ElevatedButton(
            onPressed: () {
              final newPass = _passController.text.trim();
              if (newPass.isNotEmpty) {
                context.read<ProfileBloc>().add(ChangePassword(newPass));
                Navigator.pop(context);
                _passController.clear();
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // if (state.message != null) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text(state.message!)),
        //   );
        // }
      },
      builder: (context, state) {
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

                    Text(
                      "User ID: ${state.userId}",
                      style: const TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Password: ${state.password}",
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: _showChangePasswordDialog,
                      child: const Text("Change Password"),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(Logout());
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
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
      },
    );
  }
}
