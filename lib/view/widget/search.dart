import 'package:deepvoice/api/client.dart';
import 'package:deepvoice/api/exception.dart';
import 'package:deepvoice/api/response.dart';
import 'package:deepvoice/model/user.dart';
import 'package:deepvoice/model/voice.dart';
import 'package:deepvoice/view/widget/alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchingText = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _SearchState() {
    _searchingText.addListener(() {
      setState(() {
        _searchText = _searchingText.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xfff3f5fa),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 6,
                      child: TextField(
                        focusNode: focusNode,
                        style: TextStyle(
                          fontSize: 11,
                        ),
                        autofocus: true,
                        controller: _searchingText,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xfff3f5fa),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xff6666cc),
                              size: 12,
                            ),
                          suffixIcon: focusNode.hasFocus
                            ? IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Color(0xff6666cc),
                                size: 10,
                              ),
                              onPressed: (){
                                setState(() {
                                  _searchingText.clear();
                                  _searchText = "";
                                });
                              },
                            ) : Container(),
                          hintText: '검색',
                          labelStyle: TextStyle(color: Colors.black),
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
                      ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}