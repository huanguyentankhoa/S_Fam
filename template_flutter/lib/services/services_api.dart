import 'package:dio/dio.dart';

// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:s_fam/common/constants/general.dart';
import 'package:s_fam/models/album.dart';
import 'package:s_fam/models/event.dart';
import 'package:s_fam/models/group.dart';
import 'package:s_fam/models/member.dart';
import 'package:s_fam/models/storage_account.dart';
import 'package:s_fam/models/storage_item.dart';
import 'package:s_fam/models/work.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

class APIServices {
  static final APIServices _instance = APIServices._internal();

  APIServices._internal();

  late String url;

  factory APIServices() => _instance;
  Dio dio = new Dio();

  void setAppConfig(appConfig) {
    ConfigServices().setConfig(appConfig);
    url = appConfig["url"];
  }

  ///Đăng nhập
  Future<void> login(String email, String password,
      {Function? success, Function(String)? fail}) async {
    try {
      Map<String, dynamic> data = {"username": email, "password": password};
      Response response = await dio.post("$url" + "login", data: data);
      if (response.statusCode == 200) {
        success!(response.headers.map["authorization"]!.first);
      } else
        fail!("Có lỗi xảy ra");
    } on DioError catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> checkEmail(email,
      {Function(String)? success, Function? fail}) async {
    try {
      Response result = await dio.get(
        "$url" + "api/v1/registration/?email=$email",
      );
      if (result.data != null) {
        if (result.statusCode == 200) {
          success!(result.data);
        }
      } else {
        fail!();
      }
    } catch (e) {
      fail!();
      print(e);
    }
  }

  Future<bool> confirmEmail(token) async {
    try {
      Response result = await dio.get(
        "$url" + "api/v1/registration/confirm?token=$token",
      );
      if (result.data != null) {
        if (result.statusCode == 200) {
          if (result.data == "confirmed")
            return true;
          else
            return false;
        }
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  ///Đăng ký
  Future<bool> registration(userInfo) async {
    try {
      Map<String, dynamic> data = userInfo;
      dio.options.headers = {
        "Content-Type": "application/json",
      };
      Response response =
          await dio.post("$url" + "api/v1/registration", data: data);

      if (response.statusCode == 200) {
        if (response.data == "register success")
          return true;
        else
          return false;
      }
      return false;
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> createGroup(
      {required familyName, required email, required Function? success}) async {
    try {
      Map<String, dynamic> data = {"familyName": familyName, "userName": email};
      Response response =
          await dio.post("$url" + "api/v1/family/create", data: data);
      if (response.statusCode == 200) {
        if (response.data != "family name exits" &&
            response.data != "user not exits") {
          success!(response.data);
          return true;
        } else
          return false;
      }
      return false;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<void> joinGroup(
      {required key,
      required email,
      Function? success,
      Function(int)? fail}) async {
    try {
      Map<String, dynamic> data = {
        "userName": email,
        "key": key,
      };
      Response response =
          await dio.post("$url" + "api/v1/family/join", data: data);
      if (response.statusCode == 200) {
        if (response.data == "join success") {
          success!();
        } else
          fail!(response.statusCode!);
      } else {
        fail!(response.statusCode!);
      }
    } on DioError catch (e) {
      print(e);
      fail!(e.response!.statusCode!);
    }
  }

  Future<void> getMemberByEmail(String email,
      {Function(int)? fail, Function(Member)? success}) async {
    Member? _member;
    try {
      Response response = await dio.get("$url" + "api/v1/user/$email");
      if (response.statusCode == 200) {
        _member = Member.fromJson(response.data);
        success!(_member);
      } else {
        fail!(response.statusCode!);
      }
    } on DioError catch (e) {
      print(e);
      fail!(e.response!.statusCode!);
    }
  }

  Future<Group?> getDataMyGroup(String email) async {
    Group? _group;
    try {
      Response response = await dio.get("$url" + "api/v1/user/$email");
      if (response.statusCode == 200) {
        _group = Group.fromJason(response.data["family"]);
      }
      return _group;
    } catch (e) {
      print(e);
    }
  }

  Future<List<EventModel>?> getListEvent({required email}) async {
    List<EventModel>? events = [];
    try {
      Response response = await dio.get("$url" + "api/v1/event/email/$email");

      if (response.statusCode == 200) {
        response.data.forEach((item) {
          events.add(EventModel.formJson(item));
        });
      }
      return events;
    } catch (e) {
      print(e);
    }
  }

  Future<void> createEvent(
      {required Map<String, dynamic> data,
      Function? success,
      Function? fail}) async {
    try {
      Response response =
          await dio.post("$url" + "api/v1/event/create", data: data);
      if (response.statusCode == 200) {
        success!();
      } else
        fail!();
    } catch (e) {
      print(e);
      fail!();
    }
  }

  Future<void> editEvent(
      {required EventModel event, Function? success, Function? fail}) async {
    try {
      var data = event.toJson();
      Response response =
          await dio.put("$url" + "api/v1/event/edit/${event.id}", data: data);
      if (response.statusCode == 200) {
        success!();
      } else
        fail!();
    } catch (e) {
      print(e);
      fail!();
    }
  }

  Future<void> deleteEvent({id, Function? success, Function? fail}) async {
    try {
      Response response = await dio.get("$url" + "api/v1/event/delete/$id");
      if (response.statusCode == 200) {
        success!();
      } else
        fail!();
    } catch (e) {
      print(e);
      fail!();
    }
  }

  Future<EventModel?> getEventById(id) async {
    try {
      EventModel? _event;

      Response response = await dio.get("$url" + "api/v1/event/$id");
      if (response.statusCode == 200 && response.data != null) {
        _event = EventModel.formJson(response.data);
      }
      return _event;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Work>?> getListWork({required email}) async {
    try {
      List<Work>? works = [];
      Response response = await dio.get("$url" + "api/v1/schedule/email/$email");
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((item) {
          works.add(Work.formJson(item));
        });
      }
      return works;
    } catch (e) {
      print(e);
    }
  }

  Future<void> createWork(
      {required email,
      required Map<String, dynamic> data,
      Function? success,
      Function? fail}) async {
    try {
      Response response =
          await dio.post("$url" + "api/v1/schedule/$email/create", data: data);
      if (response.statusCode == 200) {
        success!();
      } else
        fail!();
    } catch (e) {
      print(e);
      fail!();
    }
  }

  Future<void> editWork(
      {required email,
      required Work work,
      Function? success,
      Function? fail}) async {
    try {
      var data = work.toJson();
      Response response = await dio
          .put("$url" + "api/v1/schedule/$email/edit/${work.id}", data: data);
      if (response.statusCode == 200) {
        success!();
      } else
        fail!();
    } catch (e) {
      print(e);
      fail!();
    }
  }

  Future<void> deleteWork({id, Function? success, Function? fail}) async {
    try {
      Response response = await dio.get("$url" + "api/v1/schedule/delete/$id");
      if (response.statusCode == 200) {
        success!();
      } else
        fail!();
    } catch (e) {
      print(e);
      fail!();
    }
  }

  Future<Work?> getWorkById(id) async {
    try {
      Work? _work;

      Response response = await dio.get("$url" + "api/v1/schedule/$id");
      if (response.statusCode == 200 && response.data != null) {
        _work = Work.formJson(response.data);
      }
      return _work;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Work>?> getWorkByEmail(email) async {
    try {
      List<Work> _works = [];

      Response response =
          await dio.get("$url" + "api/v1/schedule/get?email=$email");
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((item) {
          _works.add(Work.formJson(item));
        });
      }
      return _works;
    } catch (e) {
      print(e);
    }
  }

  Future<List<StorageItem>?> getListStorageItem({required email}) async {
    try {
      List<StorageItem> _listItems = [];
      Response response = await dio.get("$url" + "api/v1/item/email/$email");
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((item) {
          _listItems.add(StorageItem.formJson(item));
        });
      }
      return _listItems;
    } catch (e) {
      print(e);
    }
  }

  Future<void> createStorageItem(
      {required email,
      required Map<String, dynamic> data,
      Function? success,
      Function? fail}) async {
    try {
      Response response =
          await dio.post("$url" + "api/v1/item/$email/create", data: data);
      if (response.statusCode == 200) {
        success!();
      } else
        fail!();
    } catch (e) {
      print(e);
      fail!();
    }
  }

  Future<List<StorageAccount>?> getListStorageAccount({required email}) async {
    try {
      List<StorageAccount> _listAccounts = [];
      Response response = await dio.get("$url" + "api/v1/note/email/$email");
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((item) {
          _listAccounts.add(StorageAccount.formJson(item));
        });
      }
      return _listAccounts;
    } catch (e) {
      print(e);
    }
  }

  Future<void> createStorageAccount(
      {required email,
      required Map<String, dynamic> data,
      Function? success,
      Function? fail}) async {
    try {
      Response response =
          await dio.post("$url" + "api/v1/note/$email/create", data: data);
      if (response.statusCode == 200) {
        success!();
      } else
        fail!();
    } catch (e) {
      print(e);
      fail!();
    }
  }

  Future<List<Album>?> getListAlbum({required email}) async {
    try {
      List<Album> _listAlbums = [];
      Response response = await dio.get("$url" + "api/v1/album/email/$email");
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((item) {
          _listAlbums.add(Album.formJson(item));
        });
      }
      return _listAlbums;
    } catch (e) {
      print(e);
    }
  }

  Future<Album?> getAlbumById(String id) async {
    try {
      Album? album;
      Response response = await dio.get("$url" + "api/v1/album/$id");
      if (response.statusCode == 200 && response.data != null) {
        album = Album.formJson(response.data);
      }
      return album;
    } catch (e) {
      print(e);
    }
  }

  Future<void> createAlbum(
      {required email,
      required String name,
      Function? success,
      Function? fail}) async {
    try {
      Response response =
          await dio.post("$url" + "api/v1/album/$email/create?name=$name");
      if (response.statusCode == 200) {
        success!();
      } else
        fail!();
    } catch (e) {
      print(e);
      fail!();
    }
  }

  Future<void> uploadImageAlbum({
    required String idAlbum,
    required FormData data,
    Function? success,
    Function? fail,
  }) async {
    try {
      Response response = await dio
          .post("$url" + "api/v1/image/album/$idAlbum/upload", data: data);
      if (response.statusCode == 200) {
        success!();
      } else
        fail!();
    } catch (e) {
      print(e);
      fail!();
    }
  }

  Future<StorageItem?> getItemById(String id) async {
    try {
      StorageItem? item;
      Response response = await dio.get("$url" + "api/v1/item/$id");
      if (response.statusCode == 200 && response.data != null) {
        item = StorageItem.formJson(response.data);
      }
      return item;
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadImageItem({
    required String idItem,
    required FormData data,
    Function? success,
    Function? fail,
  }) async {
    try {
      Response response = await dio
          .post("$url" + "api/v1/image/item/$idItem/upload", data: data);
      if (response.statusCode == 200) {
        success!();
      } else
        fail!();
    } catch (e) {
      print(e);
      print(e);
    }
  }

  Future<void> uploadAvtUser({
    required String email,
    required FormData data,
    Function? success,
    Function? fail,
  }) async {
    try {
      Response response =
          await dio.post("$url" + "api/v1/image/$email/avt/upload", data: data);
      if (response.statusCode == 200) {
        success!();
      } else
        fail!();
    } catch (e) {
      print(e);
      fail!();
    }
  }

  Future<void> sendFirebaseToken({required email, required token}) async {
    try {
      await dio.put("$url" + "api/v1/user/$email/edittoken/?fbtoken=$token");
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<void> sendLocation({required email, required latitude, required longitude })async{
    try{
      Map<String, dynamic> data = {
        "latitude": latitude,
        "longitude": longitude
      };
     await dio.put("$url" + "api/v1/location/$email/update",data: data);
    }on DioError catch(e){
      print(e);
    }
  }

  Future<dynamic> getLocation({required email})async{
    try{
      Response response = await dio.get("$url" + "api/v1/location/$email/update");
      if(response.statusCode==200){
        return response.data;
      }
      return null;
    }on DioError catch(e){
      print(e);
      return null;
    }
  }


  Future<void> sendNotification(token, {title, body}) async {
    try {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAfmCFdRE:APA91bH1ArkQbJRicOkff9sy-gUAebGeUPZYT2DWIzvu9bFOqbTXvkRwoy61cW6F_OGv3mdNLCGjkRlbL83k5r1ru-X8CJh3EmuSvses1Y_KaIANYfL7EyXO9S2IBYNRYWtMxhfOvp9c'
      };
      await dio.post(
        "https://fcm.googleapis.com/fcm/send",
        data: {
          "to": token,
          "data": {
            "title": title == "" ? "Thông báo" : title,
            "body": body == "" ? "Bạn có thông báo mới" : body
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
