import 'package:flutter/material.dart';

class ExploreTextField extends StatelessWidget {
  const ExploreTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(12));
    return TextField(
      controller: TextEditingController(),
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: 'Search',
        filled: true,
        fillColor: const Color(0xFF383838),
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        contentPadding: const EdgeInsets.all(12),
        border: inputBorder,
        errorBorder: inputBorder,
        disabledBorder: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        focusedErrorBorder: inputBorder,
        prefixIcon: const SizedBox(
          height: 24,
          width: 24,
          child: Center(
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
