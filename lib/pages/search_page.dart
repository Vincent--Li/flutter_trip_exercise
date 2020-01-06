import 'package:flutter/material.dart';
import 'package:flutter_app/widget/search_bar.dart';

class SearchPage extends StatefulWidget{
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(
            '临时把搜索框顶下去',
            style: TextStyle(color: Colors.blue, fontSize: 20 ),
          ),
          SearchBar(
            hideLeft: true,
            defaultText: 'xixi',
            hint: '123',
            leftButtonClick: (){
              Navigator.pop(context);
            },
            onChanged: _onTextChange,
          )
        ],
      )
    );
  }


  _onTextChange(String text) {
  }
}