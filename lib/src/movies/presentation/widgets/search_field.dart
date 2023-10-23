import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();
  late FocusNode focusNode;

  @override
  void dispose() {
    _searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 380,
      child: TextFormField(
        controller: _searchController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.search,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          hintText: "Search for movies",
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
