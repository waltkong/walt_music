import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BannerComponentBox();
  }
}


class BannerComponentBox extends StatefulWidget {
  @override
  _BannerComponentBoxState createState() => _BannerComponentBoxState();
}


class _BannerComponentBoxState extends State<BannerComponentBox> {

  List list;

  @override
  void initState() {
    super.initState();
    this.list = [
      {'image':'images/singers/deng3.jpg'},
      {'image':'images/singers/jay3.jpg'},
      {'image':'images/singers/lee1.jpg'},
      {'image':'images/singers/deng1.jpg'},
      {'image':'images/singers/jay2.jpg'},
      {'image':'images/singers/lee3.jpg'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
      width: ScreenUtil().setWidth(730),
      height: ScreenUtil().setHeight(230),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Swiper(
        itemCount: list.length,
        itemBuilder: (BuildContext context,int index){
          return Image.asset(
            list[index]['image'],
            width: ScreenUtil().setWidth(730),
            height: ScreenUtil().setHeight(230),
            fit: BoxFit.cover,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }

}

