import 'package:flutter/material.dart';

import 'package:flutter_music/pages/others/loading_page.dart';
import 'package:flutter_music/pages/index_page.dart';
import 'package:flutter_music/pages/others/message_center_page.dart';
import 'package:flutter_music/pages/others/config_page.dart';
import 'package:flutter_music/pages/others/search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: MaterialApp(
        title: "音乐屋",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        initialRoute: "index_loading",
        routes: {

          'index_loading' :  (context) => LoadingPage(),   //入口跳转页面
          '/': (context) => IndexPage(),  //主页
          'message_center': (context) => MessageCenterPage(),  //消息中心
          'config_page': (context) => ConfigPage(),  //设置页面
          'search_page': (context) => SearchPage(),  //搜索页面
        },
      ),

    );
  }
}