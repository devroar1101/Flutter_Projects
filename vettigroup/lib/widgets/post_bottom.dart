import 'package:flutter/material.dart';
import 'package:vettigroup/config/palette.dart';

class PostBottom extends StatelessWidget {
  const PostBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 30, // Set both height and width for a circle
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.vettiGroupColor, // Define your custom color here
              ),
              child: const Icon(
                Icons.thumb_up_alt_rounded,
                size: 16.0, // Increase icon size
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                '1101',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Text(
              '8 comments',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PostButton(
                icon: Icon(
                  Icons.thumb_up,
                  color: Colors.grey[700],
                ),
                onTap: () {},
                label: 'likes'),
            PostButton(
                icon: Icon(Icons.comment_bank_sharp, color: Colors.grey[700]),
                onTap: () {},
                label: 'Comments'),
          ],
        )
      ],
    );
  }
}

class PostButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTap;
  final String label;

  const PostButton(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          height: 20.0,
          child: Row(
            children: [
              icon,
              const SizedBox(
                width: 4.0,
              ),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
