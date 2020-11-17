import 'package:deepvoice/model/user.dart';
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

  Widget _buildBody(BuildContext context){
    return StreamBuilder(
        //stream: User,
        builder: (context, found){
          if (!found.hasData) return /*allUsers()*/null;
          return null;
            //_buildList(context, found.data.documnets);
        },
    );
  }
  //
  // Widget _buildList(BuildContext context, List<User> found){
  //   List<User> searchResults = [];
  //   for (User result in found){
  //     if (result.data.toString().contains(_searchText)){
  //       searchResults.add(result);
  //     }
  //   }
  //   return Expanded(
  //     child: GridView.count(
  //       crossAxisCount: 3,
  //       childAspectRatio: 1 / 1.5,
  //       padding: EdgeInsets.all(3),
  //       children: searchResults
  //         .map((data) => _buildListItem(context, data))
  //         .toList()
  //     ),
  //   );
  // }
  //
  // Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  //   final movie = Movie.fromSnapshot(data);
  //   return InkWell(
  //     child: Image.network(movie.poster),
  //     onTap: () {
  //       Navigator.of(context).push(MaterialPageRoute<Null>(
  //           fullscreenDialog: true,
  //           builder: (BuildContext context) {
  //             return DetailScreen(movie: movie);
  //           }));
  //     },
  //   );
  // }
  //
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        //controller: _searchingText,
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
                                color: Color(0x6666cc),
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