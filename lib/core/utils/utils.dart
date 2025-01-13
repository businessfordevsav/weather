
import 'package:flutter/material.dart';

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

String getUVLevel(double uvIndex) {
  if (uvIndex >= 0 && uvIndex <= 19) {
    return 'Low';
  } else if (uvIndex >= 20 && uvIndex <= 39) {
    return 'Moderate';
  } else if (uvIndex >= 40 && uvIndex <= 59) {
    return 'High';
  } else if (uvIndex >= 60 && uvIndex <= 79) {
    return 'Very High';
  } else if (uvIndex >= 80 && uvIndex <= 100) {
    return 'Extreme';
  } else {
    return 'Invalid UV Index';
  }
}

// Function to get background color based on UV level
Color getUVColor(double uvIndex) {
  if (uvIndex >= 0 && uvIndex <= 19) {
    return Colors.green; // Low - Green
  } else if (uvIndex >= 20 && uvIndex <= 39) {
    return Colors.yellow; // Moderate - Yellow
  } else if (uvIndex >= 40 && uvIndex <= 59) {
    return Colors.orange; // High - Orange
  } else if (uvIndex >= 60 && uvIndex <= 79) {
    return Colors.red; // Very High - Red
  } else if (uvIndex >= 80 && uvIndex <= 100) {
    return Colors.purple; // Extreme - Purple
  } else {
    return Colors.grey; // Invalid - Grey
  }
}
