import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onTap;

  Search(this.controller, this.onTap);

  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.widget.controller,
      decoration: InputDecoration(
        hintText: "검색",
        filled: true,
        fillColor: Color(0xfff3f5fa),
        prefixIcon: Icon(
          Icons.search,
          color: Color(0xff6666cc),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(7.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(7.5)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(7.5)),
        ),
      ),
      onSubmitted: this.widget.onTap,
    );
  }
}