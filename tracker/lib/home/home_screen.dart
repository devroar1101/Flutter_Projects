import 'package:flutter/material.dart';
import 'package:tracker/admin/entity_type/entity_type_screen.dart';
import 'package:tracker/config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              _buildCard('Org', Icons.business), // Organization icon
              const SizedBox(width: 16), // Space between cards
              _buildCard('Device', Icons.devices), // Device icon
              const SizedBox(width: 16), // Space between cards
              _buildCard('User', Icons.person),
              const SizedBox(width: 16), // Space between cards
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const SettingsScreen(),
                      ),
                    );
                  },
                  child: _buildCard('Setting', Icons.settings)), // User icon
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Configuration.cardColor,
              Configuration.cardColor.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50, // Adjust size as needed
              color: Configuration.appWhite,
            ),
            const SizedBox(height: 16), // Space between icon and text
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Configuration.appWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
