import 'package:ecomm_bloc/presentation/profile/bloc/profile_bloc.dart';
import 'package:ecomm_bloc/presentation/profile/bloc/profile_event.dart';
import 'package:ecomm_bloc/presentation/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Change Password", style: theme.textTheme.titleMedium),
        content: TextField(
          controller: _passController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "New Password",
            labelStyle: theme.textTheme.bodyMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: theme.textTheme.bodyMedium),
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: theme.colorScheme.primary.withOpacity(
                        0.2,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      "User ID: ${state.userId}",
                      style: textTheme.titleMedium,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Password: ${state.password}",
                      style: textTheme.bodyMedium?.copyWith(
                        color: theme.hintColor,
                      ),
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
                        context.go("/login"); // ✅ GoRouter
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                        foregroundColor: theme.colorScheme.onError,
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
