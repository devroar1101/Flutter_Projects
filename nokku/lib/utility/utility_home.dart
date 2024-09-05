import 'package:flutter/material.dart';
import 'package:nokku/utility/chosen_colors.dart';
import 'package:nokku/utility/library.dart';

class UtilityHome extends StatelessWidget {
  UtilityHome({super.key});

  @override
  Widget build(BuildContext context) {
    final bool bigScreen = MediaQuery.sizeOf(context).width > 600;
    final double iconSize = bigScreen ? 80 : 50;
    final double containerSize = bigScreen ? 220 : 140;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Utility'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 30,
          runSpacing: 30,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.start, // Start alignment instead of center
          children: [
            _buildUtilityCard(
              context,
              icon: Icons.color_lens,
              color: Colors.pinkAccent,
              label: 'Colors',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const ChosenColors(),
                  ),
                );
              },
              size: containerSize,
              iconSize: iconSize,
              isBigScreen: bigScreen,
            ),
            _buildUtilityCard(
              context,
              icon: Icons.library_books,
              color: const Color.fromARGB(255, 24, 233, 233),
              label: 'Library',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const LibraryScreen(),
                  ),
                );
              },
              size: containerSize,
              iconSize: iconSize,
              isBigScreen: bigScreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUtilityCard(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
    required double size,
    required double iconSize,
    required bool isBigScreen,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: isBigScreen ? 24 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
