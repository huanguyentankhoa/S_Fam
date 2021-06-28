import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/model/news.dart';
import 'package:youreal/view_models/news/news_provider.dart';
import 'package:youreal/views/menu/menu.dart';
import 'package:youreal/views/news/news_item.dart';



class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final _key = GlobalKey<ScaffoldState>();
  int _currentItem = 0;
  List<Widget> _hotNewsSliders = [];
  List<Widget> _listOtherNews = [];
  List<News> listHotNews = [];
  List<News> listOtherNews = [];
  _loadHotNewSliders() {
    listHotNews.forEach((_item) {
      _hotNewsSliders.add(
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.h),
              child: Container(
                height: 280.h,
                width: double.infinity,
                child: getImage(
                  _item.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 106.h,
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                      width: 270.w,
                      margin: EdgeInsets.only(left: 35.w,bottom: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom:5.h),
                            child: Text(_item.name,style: kText10Bold_11,),
                          ),
                          Container(
                            child: Text(_item.content,style: kText18_3,),
                          ),
                          Expanded(child:Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              child: Text(_item.createDate,style: kText14Italic_4,),
                            ),
                          ))
                        ],
                      )),
                  Expanded(child: Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h,right: 8.w),
                     child: Icon(Icons.ios_share,color: yrColor4,size: 25.w,),
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  _loadOtherNewBuild(){
    listOtherNews.forEach((item) {
      _listOtherNews.add(NewsItem(news: item));
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listHotNews =   Provider.of<NewsProvider>(context, listen: false).listHotNews;
    listOtherNews =   Provider.of<NewsProvider>(context, listen: false).listOtherNews;
    _loadHotNewSliders();
    _loadOtherNewBuild();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: yrColor1,
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: yrColor1,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            _key.currentState!.openDrawer();
          },
          child: Container(
            child: Icon(
              Icons.menu,
              color: yrColor4,
              size: 38.w,
            ),
          ),
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            "Tin tức",
            style: kText18Bold_3,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [

              ///Slide hot news
              Column(
                children: [
                  Container(
                    height: 280.h,
                    child: CarouselSlider(
                      items: _hotNewsSliders,
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentItem = index;
                            });
                          }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:listHotNews.map((url) {
                      int index = listHotNews.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                             horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentItem == index ? yrColor14 : yrColor3,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 50.h,),

              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Các tin tức khác",style: kText20Bold_4,),
                    ),
                    ..._listOtherNews,
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
