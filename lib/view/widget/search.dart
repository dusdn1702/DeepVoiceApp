import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchingText = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText;

  void dispose() { _searchingText.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      autofocus: false,
      controller: _searchingText,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Color(0xfff3f5fa),
        prefixIcon: Icon(
          Icons.search,
          color: Color(0xff6666cc),
        ),
        suffixIcon: focusNode.hasFocus
            ? IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            Icons.close,
            color: Color(0xff6666cc),
          ),
          onPressed: () {
            setState(() {
              _searchingText.clear();
            });
          },
        ) : Container(),
        contentPadding: EdgeInsets.all(20.0),
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
      onSubmitted: (_searchState) {
        _searchingText.addListener(() {
          setState(() {
            _searchText = _searchingText.text;
          });
        });
        print(_searchText);
        _searchingText.clear();
      },
    );
  }
}