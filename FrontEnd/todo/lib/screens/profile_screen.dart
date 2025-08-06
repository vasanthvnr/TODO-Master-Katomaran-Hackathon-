import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String imageUrl;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Profile image
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),

          const SizedBox(height: 20),

          // User details
          Text(
            name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(email, style: TextStyle(color: Colors.grey[600])),
          Text(phone, style: TextStyle(color: Colors.grey[600])),

          const SizedBox(height: 30),

          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Profile"),
                  onPressed: () {
                    // TODO: Add navigation to Edit Profile screen if needed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/login'));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
