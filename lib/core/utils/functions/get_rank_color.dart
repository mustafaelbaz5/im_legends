import 'package:flutter/material.dart';

Color getRankColor(final int rank) {
  switch (rank) {
    case 1:
      return Colors.amber.shade600; // Gold for Rank 1
    case 2:
      return const Color(0xFFC0C0C0); // Silver for Rank 2
    case 3:
      return Colors.orange.shade900; // Bronze for Rank 3
    default:
      return Colors.grey.shade800; // Normal color for other ranks
  }
}
