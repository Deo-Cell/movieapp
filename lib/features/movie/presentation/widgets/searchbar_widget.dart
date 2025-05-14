import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Color(0xFF767680).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Search Icon
          Icon(
            Icons.search,
            color: Colors.white.withValues(alpha: 0.60),
            size: 24,
          ),
          const SizedBox(width: 12),

          // "Search" Text
          Expanded(
            child: Text(
              "Search",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.60),
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // Microphone Icon
          Icon(
            Icons.mic,
            color: Colors.white.withValues(alpha: 0.60),
            size: 24,
          ),
        ],
      ),
    );
  }
}
