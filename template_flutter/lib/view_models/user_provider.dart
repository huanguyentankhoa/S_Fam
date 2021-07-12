import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

//import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:s_fam/common/constants/general.dart';
import 'package:s_fam/models/album.dart';
import 'package:s_fam/models/event.dart';
import 'package:s_fam/models/group.dart';
import 'package:s_fam/models/member.dart';
import 'package:s_fam/models/storage_account.dart';
import 'package:s_fam/models/storage_item.dart';
import 'package:s_fam/models/work.dart';
import 'package:s_fam/services/services_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class UserProvider with ChangeNotifier {
  late Member _userCurrentLogin;

  Member get userCurrentLogin => _userCurrentLogin;

  set userCurrentLogin(Member value) {
    _userCurrentLogin = value;
    notifyListeners();
  }

  String token = "";
  String codeFamily = "";

  //Group? groupOfUser;
  List<Member> listMemberOfGroup = [];
  List<EventModel> listEvent = [];
  List<Work> listWork = [];
  List<StorageAccount> listStorageAccount = [];
  List<StorageItem> listStorageItem = [];
  List<Album> listAlbum = [];

  UserProvider() {
    getLoggedInState();
  }

  bool loading = false;

  bool loggedIn = false;
  bool joinedGroup = false;

  APIServices _services = APIServices();

  Future<void> login(
      {required email,
      required password,
      Function? success,
      Function(String)? fail}) async {
    try {
      printLog("[LOGIN] Login start");
      notifyListeners();
      await _services.login(
        email.toString(),
        password.toString(),
        success: (_token) {
          token = _token;
          loggedIn = true;
          saveLoginState(loggedIn);
          saveUser(email, password);
          getUserInfo(email);
          success!();

          notifyListeners();
        },
        fail: (e) {
          fail!(e);
        },
      );
      printLog("[LOGIN] Login end");
      return;
    } catch (e) {
      loggedIn = false;
      saveLoginState(loggedIn);
      fail!(e.toString());
      notifyListeners();
    }
  }

  Future<void> getUserInfo(_email) async {
    try {
      printLog("Get info user");
      await _services.getMemberByEmail(_email, success: (_member) {
        _userCurrentLogin = _member;
        notifyListeners();
        print("allo");
      }, fail: (statusCode) {
        loggedIn = false;
        saveLoginState(loggedIn);
        notifyListeners();
      });
    } catch (e) {
      loggedIn = false;
      saveLoginState(loggedIn);
      notifyListeners();
    }
  }

  Future<Group?> getDataMyGroup({email}) async {
    var groupOfUser =
        await _services.getDataMyGroup(email ?? _userCurrentLogin.email!);
    notifyListeners();
    return groupOfUser;
  }

  Future<void> checkEmail(email,
      {Function(String)? success, Function? fail}) async {
    try {
      await _services.checkEmail(email, success: (code) {
        success!(code);
      }, fail: fail);
    } catch (e) {
      //print(e);
    }
  }

  Future<bool> confirmEmail(token) async {
    try {
      return await _services.confirmEmail(token);
    } catch (e) {
      //print(e);
    }
    return false;
  }

  Future<void> checkEmailForgot(email,
      {Function(String)? success, Function? fail}) async {
    try {
      await _services.checkEmailForgot(email, success: (code) {
        success!(code);
      }, fail: fail);
    } catch (e) {
      //print(e);
    }
  }

  Future<bool> confirmEmailForgot(token) async {
    try {
      return await _services.confirmEmailForgot(token);
    } catch (e) {
      //print(e);
    }
    return false;
  }

  Future<bool> resetPassword(email, pass) async {
    try {
      return await _services.resetPassword(email: email, pass: pass);
    } catch (e) {
      return false;
    }
  }

  Future<bool> editInfoUser({
    required email,
    required dob,
    required fullName,
  }) async {
    try {
      return await _services.editInfoUser(
        email: email,
        dob: dob,
        fullName: fullName,
      );
    } catch (e) {
      //print(e);
    }
    return false;
  }

  Future<void> registration(
      {infoUser, saveLogin, Function? success, Function? fail}) async {
    try {
      //printLog("[REGISTER] register start");
      loading = true;
      notifyListeners();
      bool result = (await _services.registration(infoUser));
      if (result == true) {
        printLog("[REGISTER] register end");
        loggedIn = true;
      }
      notifyListeners();
      success!();
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      print('[ERROR] $e');
      loggedIn = false;
      fail!(e.toString());
      notifyListeners();
    }
  }

  void saveLoginState(bool loggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("LoggedIn", loggedIn);
  }

  void saveCodeFamily(bool joinedGroup) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool("joinedGroup", joinedGroup);
    if (joinedGroup) prefs.setString("codeFamily", codeFamily);
  }

  void getLoggedInState() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      loggedIn = prefs.getBool("LoggedIn")!;
      if (loggedIn) {
        var data = convert.jsonDecode(prefs.getString("account")!);
        await getUserInfo(data["email"]);
        notifyListeners();
      } else {
        loggedIn = false;
        saveLoginState(loggedIn);
        notifyListeners();
      }
    } catch (e) {
      loggedIn = false;
      saveLoginState(loggedIn);
      notifyListeners();
    }
  }

  Future<void> saveUser(email, password) async {
    final prefs = await SharedPreferences.getInstance();
    var data = {"email": email, "password": password};
    prefs.setString("account", convert.jsonEncode(data));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    loggedIn = false;
    joinedGroup = false;
    saveLoginState(loggedIn);
    saveCodeFamily(joinedGroup);
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var _group = await getDataMyGroup(email: userCurrentLogin.email);

    prefs.setBool("${_group!.idGroup}_EnablePosition", false);
    sendLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        isEnablePosition: false);
    notifyListeners();
  }

  Future<void> createFamily(
      {required familyName, required Function? success, Function? fail}) async {
    var result = await _services.createGroup(
        familyName: familyName,
        email: _userCurrentLogin.email!,
        success: (_code) {
          codeFamily = _code;
          notifyListeners();
          success!(codeFamily);
        });
    if (!result) fail!();
  }

  Future<void> joinFamily(
      {required key, Function? success, Function(int)? fail}) async {
    try {
      await _services.joinGroup(
          key: key,
          email: _userCurrentLogin.email!,
          success: () {
            codeFamily = key;
            joinedGroup = true;
            success!();
            saveCodeFamily(joinedGroup);
            notifyListeners();
          },
          fail: (statusCode) {
            joinedGroup = false;
            saveCodeFamily(joinedGroup);
            fail!(statusCode);
          });
    } catch (e) {
      fail!(0);
    }
  }

  Future<List<EventModel>?> getListEvent() async {
    listEvent = (await _services.getListEvent(email: _userCurrentLogin.email))!;
    listEvent.sort((a, b) => b.id.toString().compareTo(a.id.toString()));
    notifyListeners();
    return listEvent;
  }

  Future<List<EventModel>?> getListEventByEmail(email) async {
    List<EventModel> e = (await _services.getListEvent(email: email))!;
    e.sort((a, b) => b.id.toString().compareTo(a.id.toString()));
    return e;
  }

  Future<void> createEvent(
      {required Map<String, dynamic> data,
      Function? success,
      Function? fail}) async {
    try {
      await _services.createEvent(
        data: data,
        success: success,
        fail: fail,
      );

      notifyListeners();
    } catch (e) {}
  }

  Future<void> editEvent(
      {required EventModel event, Function? success, Function? fail}) async {
    await _services.editEvent(
      event: event,
      success: success,
      fail: fail,
    );
    notifyListeners();
  }

  Future<void> deleteEvent(id, {Function? success, Function? fail}) async {
    await _services.deleteEvent(id: id, success: success, fail: fail);
    //printLog("Get list event");
    notifyListeners();
  }

  Future<EventModel?> getEventById(id) async {
    EventModel? _event;
    _event = (await _services.getEventById(id))!;
    notifyListeners();
    return _event;
  }

  Future<List<Work>?> getListWork() async {
    listWork = (await _services.getListWork(email: userCurrentLogin.email))!;
    listWork.sort((a, b) => b.id.toString().compareTo(a.id.toString()));
    notifyListeners();
    return listWork;
  }

  Future<List<Work>?> getListWorkByEmail(email) async {
    List<Work> _w = (await _services.getListWork(email: email))!;
    _w.sort((a, b) => b.id.toString().compareTo(a.id.toString()));
    notifyListeners();
    return _w;
  }

  Future<void> createWork(
      {required Map<String, dynamic> data,
      required email,
      Function? success,
      Function? fail}) async {
    await _services.createWork(
      email: email,
      data: data,
      success: success,
      fail: fail,
    );
    notifyListeners();
  }

  Future<void> editWork(
      {required Work work,
      required email,
      Function? success,
      Function? fail}) async {
    await _services.editWork(
      work: work,
      email: email,
      success: success,
      fail: fail,
    );
    notifyListeners();
  }

  Future<void> deleteWork(id, {Function? success, Function? fail}) async {
    await _services.deleteWork(id: id, success: success, fail: fail);
    //printLog("Get list event");
    notifyListeners();
  }

  Future<Work?> getWWorkById(id) async {
    Work? _work;
    _work = (await _services.getWorkById(id))!;
    notifyListeners();
    return _work;
  }

  Future<List<Work>?> getWWorkByEmail(email) async {
    List<Work> _works = [];
    _works = (await _services.getWorkByEmail(email))!;
    notifyListeners();
    return _works;
  }

  Future<List<StorageItem>?> getListStorageItem({Function? success}) async {
    try {
      listStorageItem =
          (await _services.getListStorageItem(email: userCurrentLogin.email))!;
      success!(listStorageItem);
      notifyListeners();
      return listStorageItem;
    } catch (e) {}
  }

  Future<void> getListStorageAccount({Function? success}) async {
    try {
      listStorageAccount = (await _services.getListStorageAccount(
          email: userCurrentLogin.email))!;
      success!(listStorageAccount);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> createListStorageItem(
      {required Map<String, dynamic> data,
      required email,
      Function(Map<String, dynamic>)? success,
      Function? fail}) async {
    await _services.createStorageItem(
      email: email,
      data: data,
      success: (item) {
        success!(item);
      },
      fail: fail,
    );
    notifyListeners();
  }

  Future<void> createListStorageAccount(
      {required Map<String, dynamic> data,
      required email,
      Function? success,
      Function? fail}) async {
    await _services.createStorageAccount(
      email: email,
      data: data,
      success: success,
      fail: fail,
    );
    notifyListeners();
  }

  Future<void> getListAlbums({Function? success}) async {
    try {
      listAlbum =
          (await _services.getListAlbum(email: userCurrentLogin.email))!;
      notifyListeners();
      success!(listAlbum);
    } catch (e) {}
  }

  Future<Album?> getAlbumById(String id) async {
    try {
      Album album;
      album = (await _services.getAlbumById(id))!;
      notifyListeners();
      return album;
    } catch (e) {}
  }

  Future<void> createAlbum(
      {required String name,
      required email,
      Function? success,
      Function? fail}) async {
    await _services.createAlbum(
      email: email,
      name: name,
      success: success,
      fail: fail,
    );
    notifyListeners();
  }

  Future<void> uploadAlbum(
      {required String idAlbum,
      required FormData data,
      Function? success,
      Function? fail}) async {
    await _services.uploadImageAlbum(
      idAlbum: idAlbum,
      data: data,
      success: success,
      fail: fail,
    );
    notifyListeners();
  }

  Future<void> uploadImageItem(
      {required String idItem,
      required String imagePath,
      Function? success,
      Function? fail}) async {
    await _services.uploadImageItem(
      idItem: idItem,
      imagePath: imagePath,
      success: success,
      fail: fail,
    );
    notifyListeners();
  }

  Future<void> uploadAvtUser(
      {required String imagePath, Function? success, Function? fail}) async {
    await _services.uploadAvtUser(
      email: userCurrentLogin.email!,
      imagePath: imagePath,
      success: success,
      fail: fail,
    );
    notifyListeners();
  }

  Future<void> sendNotification({required title, required body}) async {
    final prefs = await SharedPreferences.getInstance();
    var tokenFirebase = prefs.getString("TokenFirebase");
    try {
      await _services.sendNotification(tokenFirebase, title: title, body: body);
    } catch (e) {
      //print(e);
    }
  }

  Future<void> sendLocation(
      {required latitude,
      required longitude,
      required isEnablePosition}) async {
    try {
      await _services.sendLocation(
          email: _userCurrentLogin.email!,
          latitude: latitude,
          longitude: longitude,
          isEnablePosition: isEnablePosition);
    } catch (e) {
      //print(e);
    }
  }

  Future<Map<String, dynamic>?> getLocation({required email}) async {
    try {
      var location = await _services.getLocation(email: email);
      return location;
    } catch (e) {
      return null;
      //print(e);
    }
  }

  Future<void> sendWarning() async {
    try {
      await _services.sendWarning(email: _userCurrentLogin.email);
    } catch (e) {
      //print(e);
    }
  }

  Future<bool> createPinCode({required pinCode}) async {
    var result = await _services.createPinCode(
        email: _userCurrentLogin.email, pinCode: pinCode);
    if (result) getUserInfo(_userCurrentLogin.email);
    return result;
  }
}
