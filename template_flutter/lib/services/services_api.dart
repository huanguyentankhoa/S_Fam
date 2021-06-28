import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:youreal/model/chat.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/model/news.dart';
import 'package:youreal/model/user.dart';

const serverConfig = {
  "type": "app",
  // "url": "dev-api.youreal.vn",
  // "urlToken": "dev-auth.youreal.vn",
  "url": "http://171.244.39.37:8000/",
  "urlToken": "http://171.244.39.37:8001/",
};

class APIServices {
  static final APIServices _instance = APIServices._internal();

  APIServices._internal();

  late String url;
  late String urlToken;
  late String accessToken;

  factory APIServices() => _instance;

  void setAppConfig() {
    url = serverConfig["url"]!;
    urlToken = serverConfig["urlToken"]!;
  }

  Future<User?> loginWithPhoneNumber(phoneNumber, password) async {
    User? _user;
    Dio dio = new Dio();
    try {
      Map<String, dynamic> data = {
        "grant_type": "password",
        "scope": "api openid profile",
        "username": phoneNumber,
        "password": password
      };
      dio.options.contentType = Headers.formUrlEncodedContentType;
      dio.options.headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        'Authorization': 'Basic WW91UmVhbDpue244TntUVkY1JChkYi5x'
      };
      Response response =
          await dio.post("$urlToken" + "connect/token", data: data);

      if (response.statusCode == 200) {
        accessToken = response.data["access_token"];
        _user = await getUserInfo(token: accessToken);
        return _user;
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<User?> getUserInfo({token}) async {
    try {
      User? user;
      Dio dio = new Dio();
      dio.options.headers = {'Authorization': 'Bearer $token'};
      Response response = await dio.get("$url" + "account/info");
      if (response.statusCode == 200) {
        user = User.formJason(response.data, token);
        return user;
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<List<Deal>?> getListDealRecently() async {
    List<Deal> _list = [];
    listDeals.forEach((deal) {
      if (deal["status"] == 1) {
        _list.add(Deal.formJson(deal));
      }
    });
    return _list;
  }

  Future<List<Map<String, dynamic>>> getCriteria() async {
    List<Map<String, dynamic>> list = [];
    Dio dio = new Dio();
    try {
      Response response = await dio.get("$url" + "filter/criteria");
      if (response.statusCode == 200) {
        response.data.forEach((item) {
          list.add(item);
        });
      }
      return list;
    } on DioError catch (e) {
      print(e);
      return list;
    }
  }

  Future<bool> sendCriteria({
    required position,
    required soilType,
    required investmentLimit,
  }) async {
    List<Map<String, dynamic>> data = [
      {"criteriaId": 1, "value": position},
      {"criteriaId": 2, "value": soilType},
      {"criteriaId": 3, "value": investmentLimit}
    ];
    Dio dio = new Dio();
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};
    try {
      Response response = await dio.post("$url" + "filter", data: data);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Deal>?> getListDealSuggest() async {
    List<Deal> _list = [];
    listDeals.forEach((deal) {
      if (deal["status"] == 2) {
        _list.add(Deal.formJson(deal));
      }
    });
    return _list;
  }

  Future<List<Deal>?> getListDealInvesting() async {
    List<Deal> _list = [];
    listDeals.forEach((deal) {
      if (deal["status"] == 3) {
        _list.add(Deal.formJson(deal));
      }
    });
    return _list;
  }

  Future<List<Deal>?> getListDealInvested() async {
    List<Deal> _list = [];
    listDeals.forEach((deal) {
      if (deal["status"] == 4) {
        _list.add(Deal.formJson(deal));
      }
    });
    return _list;
  }

  Future<List<News>?> getListHotNews() async {
    List<News> _list = [];
    listNews.forEach((item) {
      if (item["kind"] == 1) {
        _list.add(News.formJson(item));
      }
    });
    return _list;
  }

  Future<List<News>?> getListOtherNews() async {
    List<News> _list = [];
    listNews.forEach((item) {
      if (item["kind"] == 2) {
        _list.add(News.formJson(item));
      }
    });
    return _list;
  }

  Future<List<GroupChat>?> getListGroupChat() async {
    List<GroupChat> _list = [];
    listGroupChat.forEach((item) {
      _list.add(GroupChat.formJson(item));
    });
    return _list;
  }

  Future<void> sendNotification() async {
    Dio dio = new Dio();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAkNZ_-y8:APA91bF_-kRFCNbgNe7SeIxTzaz6ePRJzYa6R2l-gxivuaHg0x1Tb5Cod61eymeCAJuGLLFNP0RKzZwfFL1AmBK-4JrtDpn6TswllPX3nrIzxmmFi-INljqOESmiB6Dd-n0F9dp9gIK7'
    };
    await dio.post(
      "https://fcm.googleapis.com/fcm/send",
      data: {
        "to":
            "dIjxXbtVRG2AH5AW8MBi90:APA91bFQrBA5ldU04L-smbarYxYd4hE0-jRZM6rmp9pC-UZkcj9IZ4e3CwwdCMX9sQI8TjueKS_oR0QllNEoCyE1T3iqg_weqNC8gM7hmV-yuIME5xi4DQHzu7P-0HPvHJvbJb9w35SF",
        "notification": {"title": "This is a test title", "body": "OK HELLO"},
        "data": {"title": "This is a test title", "body": "OK HELLO"}
      },
    );
  }
}
