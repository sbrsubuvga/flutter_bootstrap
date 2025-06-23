import 'package:flutter/material.dart';



extension BootstrapButtonStyleExtension on ButtonStyle {
  ButtonStyle primary() {
    return copyWith(
      backgroundColor: WidgetStateProperty.all(Color(0xff007bff)), // Bootstrap primary blue
      foregroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0), // Bootstrap default radius
        ),
      ),
    );
  }

  ButtonStyle secondary() {
    return copyWith(
      backgroundColor: WidgetStateProperty.all(Color(0xFF6c757d)), // Bootstrap secondary gray
      foregroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }

  ButtonStyle success() {
    return copyWith(
      backgroundColor: WidgetStateProperty.all(Color(0xFF28a745)), // Bootstrap success green
      foregroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }

  ButtonStyle danger() {
    return copyWith(
      backgroundColor: WidgetStateProperty.all(Color(0xFFdc3545)), // Bootstrap danger red
      foregroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }

  ButtonStyle warning() {
    return copyWith(
      backgroundColor: WidgetStateProperty.all(Color(0xFFffc107)), // Bootstrap warning yellow
      foregroundColor: WidgetStateProperty.all(Color(0xFF212529)), // Bootstrap dark text
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }

  ButtonStyle info() {
    return copyWith(
      backgroundColor: WidgetStateProperty.all(Color(0xFF17a2b8)), // Bootstrap info cyan
      foregroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }

  ButtonStyle light() {
    return copyWith(
      backgroundColor: WidgetStateProperty.all(Color(0xFFf8f9fa)), // Bootstrap light gray
      foregroundColor: WidgetStateProperty.all(Colors.black), // Bootstrap dark text
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }

  ButtonStyle dark() {
    return copyWith(
      backgroundColor: WidgetStateProperty.all(Color(0xFF343a40)), // Bootstrap dark black
      foregroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }

  ButtonStyle link() {
    return copyWith(
      foregroundColor: WidgetStateProperty.all(Color(0xFF007bff)), // Bootstrap link blue
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      textStyle: WidgetStateProperty.all(
        TextStyle(decoration: TextDecoration.underline), // Underline effect
      ),
    );
  }
}

