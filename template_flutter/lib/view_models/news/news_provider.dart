import 'package:flutter/cupertino.dart';
import 'package:youreal/model/news.dart';
import 'package:youreal/services/services_api.dart';

class NewsProvider with ChangeNotifier{

  List<News>listHotNews = [];
  List<News>listOtherNews = [];
  APIServices _services = APIServices();

  Future<void> getListHotNews()async{
    listHotNews  =(await _services.getListHotNews())!;
    notifyListeners();
  }

  Future<void> getListOtherNews()async{
    listOtherNews  =(await _services.getListOtherNews())!;
    notifyListeners();
  }
}