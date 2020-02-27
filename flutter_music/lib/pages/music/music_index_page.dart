import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music/components/banner_component.dart';
import 'package:flutter_music/datas/music_data.dart';

import 'package:audioplayers/audioplayers.dart';

class MusicIndexPage extends StatefulWidget {
  @override
  _MusicIndexPageState createState() => _MusicIndexPageState();
}

class _MusicIndexPageState extends State<MusicIndexPage> {

  List ad_data_list = [
    {
      'id':'1',
      'name':'音乐屋火爆消息',
      'desc':'周杰伦发新专辑了',
      'image': 'images/singers/jay2.jpg',
    },
    {
      'id':'2',
      'name':'演唱会爆料',
      'desc':'李宗盛-有歌之年正在火爆销售',
      'image': 'images/singers/lee3.jpg',
    },
    {
      'id':'3',
      'name':'邓紫棋-娱乐头条',
      'desc':'邓紫棋独家爆料-神秘男友是谁呢？？',
      'image': 'images/singers/deng1.jpg',
    },
  ];

  var now_ad_index = 0;
  var now_ad;

  var new_song_list;
  AudioPlayer audioPlayer;

  var playObj;

  @override
  void initState() {
    super.initState();

    now_ad = ad_data_list[now_ad_index];

    Timer.periodic(const Duration(milliseconds: 5000), (timer){

      setState(() {
        if(now_ad_index >= 2){
          now_ad_index = 0;
          now_ad = ad_data_list[now_ad_index];
        }else{
          now_ad_index +=1;
          now_ad = ad_data_list[now_ad_index];
        }
      });

    });

    new_song_list = MusicData.leeSongs();

    audioPlayer = AudioPlayer();

    playObj = {
      'play_or_stop':'stop',
      'src':'',
    };

  }

  @override
  void deactivate() async{
    print('结束');
    int result = await audioPlayer.release();
    if (result == 1) {
      print('release success');
    } else {
      print('release failed');
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            _searchBox(),

            // banner
            BannerComponent(),

            _categoryBox(),

            _adBox(),  //广告

            _recommendBox(), //推荐歌单

            _newSongListBox(),  //新歌速递


          ],
        ),
      ),
    );
  }

  Widget _searchBox(){
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 3),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setWidth(80),
      padding: EdgeInsets.fromLTRB(120, 3, 20, 3),
      decoration: BoxDecoration(
        color: Color.fromRGBO(233, 233, 233, 1),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushNamed('search_page');
        },
        child:Row(
          children: <Widget>[

            Icon(Icons.search),

            Container(
              child: Text('搜你想听的',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14,color: Colors.blue,fontWeight: FontWeight.w300),
                overflow: TextOverflow.ellipsis,),
            ),

          ],
        )
      ),
    );
  }


  Widget _categoryBox(){
    List _catlist = [
      {
        'id':'1',
        'name':'歌单',
        'image':"images/music_menu.jpg",
      },
      {
        'id':'2',
        'name':'歌手',
        'image':"images/singers/jay1.jpg",
      },
      {
        'id':'3',
        'name':'新歌',
        'image':"images/new_song.jpg",
      },
      {
        'id':'4',
        'name':'排行榜',
        'image':"images/rank.jpg",
      },
    ];


    return Container(
      height: ScreenUtil().setHeight(170),
      padding: EdgeInsets.only(left: 10),
      child: ListView.builder(
        itemCount: _catlist.length,
        itemBuilder:(BuildContext context,int index){
          return GestureDetector(
            onTap: (){

            },
            child: Container(
              width: ScreenUtil().setWidth(130),
              margin: EdgeInsets.fromLTRB(10, 3, 10, 10),
              child: Column(
                children: <Widget>[

                  Image.asset(
                    _catlist[index]['image'],
                    fit:BoxFit.cover,
                    width: ScreenUtil().setWidth(90),
                    height: ScreenUtil().setHeight(90),
                  ),

                  Container(
                    margin: EdgeInsets.only(top:10),
                    height: ScreenUtil().setHeight(30),
                    child: Center(
                      child: Text(_catlist[index]['name']),
                    ),
                  ),

                ],
              ),

            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );

  }



  Widget _adBox(){
    return Container(
      height: ScreenUtil().setHeight(100),
      decoration: BoxDecoration(
        color:Colors.grey,
        borderRadius:BorderRadius.circular(5),
      ),
      child: Row(
        children: <Widget>[
          
          Image.asset(now_ad['image'],fit: BoxFit.cover,width: ScreenUtil().setWidth(200),),

          Column(
            children: <Widget>[
              Text(now_ad['name'],style: TextStyle(fontSize: 16,color: Colors.white),overflow:TextOverflow.ellipsis,textAlign: TextAlign.left,),
              Text(now_ad['desc'],style: TextStyle(fontSize: 14,color: Colors.white),overflow:TextOverflow.ellipsis,),
            ],
          ),

        ],
      ),
    );
  }


  Widget _recommendBox(){

    List recommendlist = [
      {
        'id':'1',
        'name':'周杰伦金曲',
        'image':'images/singers/jay2.jpg',
      },
      {
        'id':'2',
        'name':'jay专辑',
        'image':'images/singers/jay3.jpg',
      },
      {
        'id':'6',
        'name':'lee专辑',
        'image':'images/singers/lee3.jpg',
      },
      {
        'id':'3',
        'name':'邓紫棋金曲',
        'image':'images/singers/deng1.jpg',
      },
      {
        'id':'4',
        'name':'deng专辑',
        'image':'images/singers/deng2.jpg',
      },
           {
        'id':'5',
        'name':'李宗盛金曲',
        'image':'images/singers/lee4.jpg',
      },

    ];


    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Text(
            '推荐歌单',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Container(
            height: ScreenUtil().setHeight(500),
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(3),
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(6, (index){
                 return Column(
                   children: <Widget>[

                      Image.asset(
                        recommendlist[index]['image'],
                        width: ScreenUtil().setWidth(200),
                        height: ScreenUtil().setHeight(160),
                        fit: BoxFit.cover,
                      ),

                      Text(
                         recommendlist[index]['name'],
                      ),
                   ],
                 );
              }),
            ),

          ),


        ],
      ),
    );
  }



  Widget _newSongListBox(){
    return Container(
      margin: EdgeInsets.only(top:10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Text(
            '新歌速递',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Container(
            height: ScreenUtil().setHeight(700),
            child: ListView.builder(
              itemBuilder: (BuildContext context,int index){
                return new Container(
                  child: ListTile(
                    leading: Image.asset(
                      new_song_list[index]['image'],
                      fit: BoxFit.cover,
                      width: ScreenUtil().setWidth(120),
                      height: ScreenUtil().setHeight(230),
                    ),
                    title: Text(new_song_list[index]['name']),
                    subtitle: Row(
                      children: <Widget>[
                        Text("${new_song_list[index]['singer']}-"),
                        Text("${new_song_list[index]['box']}"),
                      ],
                    ),
                    trailing: Text(new_song_list[index]['time']),
                    onTap: (){
                      if(playObj['play_or_stop'] == 'stop'){
                        play(new_song_list[index]['src']);
                        playObj['play_or_stop'] = 'play';
                        playObj['src'] = new_song_list[index]['src'];
                      }else{
                        if(playObj['src'] == new_song_list[index]['src']){
                          pause();
                          playObj['play_or_stop'] = 'stop';
                        }else{
                          pause();
                          play(new_song_list[index]['src']);
                          playObj['play_or_stop'] = 'play';
                          playObj['src'] = new_song_list[index]['src'];
                        }
                      }
                    },
                  ),
                );
              },
              itemCount: new_song_list.length,
//              itemExtent: 100.0,
            ),
          ),

        ],
      ),
    );
  }

  //播放
  play(src) async {
    int result = await audioPlayer.play(src);
    if (result == 1) {
      // success
      print('play success');
    } else {
      print('play failed');
    }
  }

  //暂停
  pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      // success
      print('pause success');
    } else {
      print('pause failed');
    }
  }



}
