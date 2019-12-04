import 'package:flutter/material.dart';
import 'package:flutter_app/dao/home_dao.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/model/grid_nav_model.dart';
import 'package:flutter_app/model/home_model.dart';
import 'package:flutter_app/widget/grid_nav.dart';
import 'package:flutter_app/widget/local_nav.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

const APPBAR_SCROLL_OFFSET = 100;
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List _imageUrls = [
    'https://dimg04.c-ctrip.com/images/3005190000015mw1n7799_C_200_150.jpg',
    'https://dimg03.c-ctrip.com/images/fd/tg/g2/M0A/89/ED/CghzgFWwxoaAB2jnABsQ9aZOizI872_C_200_150.jpg',
    'https://dimg04.c-ctrip.com/images/300b0v000000k60bdA235_C_200_150.jpg'
  ];

  double appBarAlpha = 0;
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2 ),
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(removeTop: true, context: context,
              child: NotificationListener(
                onNotification: (scrollNotification){
                  if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0){
                    //滚动且是列表滚动的时候
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                  return true;
                },
                child: ListView(

                  children: <Widget>[
                    Container(
                      height: 160,
                      child: Swiper(
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        itemBuilder: ( BuildContext context, int index){
                          return Image.network(
                              _imageUrls[index],
                              fit: BoxFit.fill
                          );
                        },
                        pagination: SwiperPagination(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                      child:  LocalNav(localNavList: localNavList,),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                      child: GridNav(gridNavModel: gridNavModel,),
                    ),
                    Container(
                      height: 800,
                      child: ListTile(
                        title: Text('test'),
                      ),
                    ),
                  ],
                ),
              )
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  _onScroll(offset) {
    double alpha = offset/APPBAR_SCROLL_OFFSET;
    if(alpha < 0){
      alpha = 0;
    }else if (alpha > 1){
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });

    print(alpha);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

//  loadData() {
//    HomeDao.fetch().then((result) {
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((e){
//      setState(() {
//        resultString = e.toString();
//      });
//    });
//  }
  loadData() async {
    try{
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
      });
    }catch(e){
      print(e);
    }
  }


}