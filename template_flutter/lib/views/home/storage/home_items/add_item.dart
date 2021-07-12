import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/app_provider.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/widgets/text_input.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameItem = TextEditingController();
  TextEditingController note = TextEditingController();
  ButtonStatus stateOnlyText = ButtonStatus.idle;
  late UserProvider user;
  String? _imagePath;

  getImageCameraSuccess(String? path) {
    if (path != null) {
      setState(() {
        _imagePath = path;
      });
    }
  }

  getImageGallerySuccess(List<Asset> resultList) async {
    await FlutterAbsolutePath.getAbsolutePath(resultList.first.identifier!)
        .then((value) async {
      setState(() {
        _imagePath = value;
      });
    });
  }

  FocusNode focusNode = FocusNode();

  void onPressedCustomButton() async {
    Map<String, dynamic> data = {
      "name": nameItem.text,
      "detail": note.text,
    };
    if (stateOnlyText == ButtonStatus.idle) {
      setState(() {
        stateOnlyText = ButtonStatus.loading;
      });
      Future.delayed(Duration(seconds: 2), () async {
        if (_formKey.currentState!.validate()) {
          user.createListStorageItem(
              data: data,
              email: user.userCurrentLogin.email,
              success: (item) {
                print(item);
                setState(() {
                  stateOnlyText = ButtonStatus.success;
                });
                Future.delayed(Duration(seconds: 2), () {
                  if (mounted)
                    setState(() {
                      stateOnlyText = ButtonStatus.idle;
                    });
                });
                user.uploadImageItem(
                    idItem: item["id"].toString(),
                    imagePath: _imagePath!,
                    success: () {},
                    fail: () {});
                Navigator.pop(context);
              },
              fail: () {
                setState(() {
                  stateOnlyText = ButtonStatus.fail;
                });
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    stateOnlyText = ButtonStatus.idle;
                  });
                });
              });
        } else {
          setState(() {
            stateOnlyText = ButtonStatus.fail;
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              stateOnlyText = ButtonStatus.idle;
            });
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _app = Provider.of<AppProvider>(context);
    user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
                _appBarBuild(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(
                    height: 48,
                    labelText: "Tên vật dụng",
                    validator: (value) {
                      return value!.isEmpty ? "Không được bỏ trống" : null;
                    },
                    controller: nameItem,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(
                    height: 223,
                    labelText: "Mô tả",
                    validator: (value) {
                      return value!.isEmpty ? "Không được bỏ trống" : null;
                    },
                    controller: note,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    _app.showPicker(
                        context: context,
                        successCamera: getImageCameraSuccess,
                        successGallery: (result) {});
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Thêm hình ảnh",
                          style: kText14Black,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 224,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: _imagePath != null
                          ? null
                          : Border.all(color: primaryMain)),
                  child: _imagePath != null
                      ? Image.file(File(_imagePath!))
                      : InkWell(
                          onTap: () {
                            _app.showPicker(
                                context: context,
                                successCamera: getImageCameraSuccess,
                                successGallery: (result) {
                                  getImageGallerySuccess(result);
                                });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: primaryMain,
                              ),
                              Text(
                                "Thêm ảnh",
                                style: kText16Blue,
                              )
                            ],
                          ),
                        ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  height: 52,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  alignment: Alignment.center,
                  child: ProgressButtonAnimation(
                    onPressed: onPressedCustomButton,
                    state: stateOnlyText,
                    height: 52,
                    maxWidth: MediaQuery.of(context).size.width,
                    stateWidgets: {
                      ButtonStatus.idle: Text(
                        "Hoàn tất",
                        style: kText16WhiteBold,
                      ),
                      ButtonStatus.fail: Text(
                        "Xảy ra lỗi",
                        style: kText14White,
                      ),
                      ButtonStatus.success: Text(
                        "Tạo ghi chú thành công",
                        style: kText14White,
                      ),
                    },
                    stateColors: {
                      ButtonStatus.idle: primaryMain,
                      ButtonStatus.loading: primaryMain,
                      ButtonStatus.fail: Colors.red,
                      ButtonStatus.success: Colors.green,
                    },
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBarBuild() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 90,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/back.svg",
                  color: Colors.black,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Thêm ghi chú vật dụng mới",
                  style: kText20BlackBold,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
