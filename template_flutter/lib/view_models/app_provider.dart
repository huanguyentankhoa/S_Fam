import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:s_fam/services/services_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:s_fam/common/constants/general.dart';

class AppProvider extends ChangeNotifier {
  String locale = kAdvanceConfig['DefaultLanguage'].toString();
  bool darkTheme = false;
  bool isInit = false;
  Map<String, dynamic> appConfig = {};
  late File _image;

  int _tabMainSelected = 0;
  int _tabStorageSelected = 0;
  bool _fromMenu = false;

  bool get fromMenu => _fromMenu;

  set fromMenu(bool value) {
    _fromMenu = value;
    notifyListeners();
  }

  int get tabStorageSelected => _tabStorageSelected;

  set tabStorageSelected(int value) {
    _tabStorageSelected = value;
    notifyListeners();
  }

  int get tabMainSelected => _tabMainSelected;

  set tabMainSelected(int value) {
    _tabMainSelected = value;
    notifyListeners();
  }

  APIServices service = APIServices();

  AppModel() {
    getConfig();
  }

  Future<bool> getConfig() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      locale = prefs.getString("language") ??
          kAdvanceConfig['DefaultLanguage'].toString();
      darkTheme = prefs.getBool("darkTheme") ?? false;
      isInit = true;
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> changeLanguage(String country, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      locale = country;
      await prefs.setString("language", country);

      notifyListeners();
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<void> updateTheme(bool theme) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      darkTheme = theme;
      await prefs.setBool("darkTheme", theme);
      notifyListeners();
    } catch (error) {}
  }

  final picker = ImagePicker();

  _imgFromCamera(Function success) async {
    PickedFile pickedFile =
        (await picker.getImage(source: ImageSource.camera, imageQuality: 50))!;
    success(pickedFile.path);
    notifyListeners();
  }

  // _imgFromGallery(Function success) async {
  //   final pickedFile = await picker.getImage(
  //       source: ImageSource.gallery, imageQuality: 50
  //   ).catchError((onError){
  //     print(onError);
  //   });
  //   print(pickedFile);
  //   // _image = File(pickedFile!.path);
  //   // success(_image);
  //   notifyListeners();
  // }
  void showPicker({required BuildContext context, required Function(List<Asset>) successGallery,required Function successCamera}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Chọn từ thư viện'),
                      onTap: () {
                        _multiImgFromGallery(
                            numberImageMaxUpload: 1,
                            success: (result) async {
                              if (result.isNotEmpty) {
                                successGallery(result);
                                // await FlutterAbsolutePath.getAbsolutePath(
                                //         result.first.identifier!)
                                //     .then((value) async {
                                //
                                // });
                              }
                            });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Chụp ảnh mới'),
                    onTap: () {
                      _imgFromCamera(successCamera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _multiImgFromGallery({
    numberImageMaxUpload,
    Function(List<Asset>)? success,
  }) async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: numberImageMaxUpload,
          enableCamera: false,
          selectedAssets: resultList,
          materialOptions: MaterialOptions(
              autoCloseOnSelectionLimit: true));
      success!(resultList);
    } on Exception catch (e) {
      printLog(e);
    }

    notifyListeners();
  }

  void showMultiPicker(
      {required BuildContext context,
      required Function(List<Asset>) successFromGallery,
      required Function(List<String>) successFromCamera,
      required numberImageMaxUpload}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Tải ảnh lên từ thư viện'),
                      onTap: () {
                        _multiImgFromGallery(
                            numberImageMaxUpload: numberImageMaxUpload,
                            success: successFromGallery);
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }
}
