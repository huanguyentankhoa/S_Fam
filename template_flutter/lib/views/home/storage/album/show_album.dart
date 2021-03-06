import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/config.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/general.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/models/album.dart';
import 'package:s_fam/view_models/app_provider.dart';
import 'package:s_fam/view_models/user_provider.dart';

class ShowAlbum extends StatefulWidget {
  final int idAlbum;

  const ShowAlbum({Key? key, required this.idAlbum}) : super(key: key);

  @override
  _ShowAlbumState createState() => _ShowAlbumState();
}

class _ShowAlbumState extends State<ShowAlbum> {
  late UserProvider user;
  List<Widget> listImage = [];
  Album? _album;
  File? file;

  bool _permissionReady = false;

  Future<void> pickImagesFromGallery(List<Asset> resultList) async {
    resultList.forEach((img) async {
      await FlutterAbsolutePath.getAbsolutePath(img.identifier!)
          .then((value) async {
        var fileImg = await MultipartFile.fromFile(value!, filename: img.name);
        FormData data = FormData.fromMap({"files": fileImg});

        user.uploadAlbum(
          idAlbum: widget.idAlbum.toString(),
          data: data,
          success: () async {
            _album = await user.getAlbumById(widget.idAlbum.toString());
            loadListImage();
            setState(() {});
          },
          fail: () {},
        );
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadListImage();
  }

  loadListImage() async {
    _album = (await Provider.of<UserProvider>(context, listen: false)
        .getAlbumById(widget.idAlbum.toString()))!;

    List<Widget> _list = [];
    _album!.listImage.forEach((img) {
      var path = "${serverConfig["url"]}" +
          "api/v1/image/download?path=album/${_album!.id}&name=$img";
      _list.add(itemImage(path));
    });
    setState(() {
      listImage = _list;
    });
  }
  //
  // Future<bool> _checkPermission() async {
  //   if (Platform.isAndroid) {
  //     final status = await Permission.storage.status;
  //     if (status != PermissionStatus.granted) {
  //       final result = await Permission.storage.request();
  //       if (result == PermissionStatus.granted) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return true;
  //     }
  //   } else if (Platform.isIOS) {
  //     final status = await Permission.photos.status;
  //     if (status != PermissionStatus.granted) {
  //       final result = await Permission.photos.request();
  //       if (result == PermissionStatus.granted) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return true;
  //     }
  //   }
  //   return false;
  // }
  //
  // Future<String> getStorageDirectory() async {
  //   if (Platform.isAndroid) {
  //     return (await getExternalStorageDirectory())!.path;
  //   } else {
  //     return (await getApplicationDocumentsDirectory()).path;
  //   }
  // }
  //
  // _downloadImage(var url) async {
  //   String? pathImage = await ExtStorage.getExternalStoragePublicDirectory(
  //       ExtStorage.DIRECTORY_PICTURES);
  //   try {
  //     if (url != null) {
  //       await FlutterDownloader.enqueue(
  //           url: url,
  //           savedDir: pathImage != null && pathImage != ""
  //               ? pathImage
  //               : await getStorageDirectory());
  //     }
  //   } catch (error) {
  //     printLog(error);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppProvider>(context);
    user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              _appBarBuild(),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  _album == null ? "" : _album!.name,
                  style: kText14BlackBold,
                ),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: listImage.length + 1,
                    itemBuilder: (_, index) {
                      if (index == 0) {
                        return InkWell(
                          onTap: () {
                            appModel.showMultiPicker(
                                context: context,
                                successFromGallery: (resultList) {
                                  pickImagesFromGallery(resultList);
                                },
                                successFromCamera: (img) {},
                                numberImageMaxUpload: 50);
                          },
                          child: Container(
                            height: 75,
                            width: 105,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xFFC4C4C4),
                                borderRadius: BorderRadius.circular(15)),
                            child: Icon(
                              Icons.add,
                              color: primaryMain,
                              size: 30,
                            ),
                          ),
                        );
                      }
                      return listImage[index - 1];
                    }),
              ),
            ],
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
                  "Album ???nh",
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

  Widget itemImage(link) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.all(5),
            titlePadding: EdgeInsets.zero,
            content: Stack(
              children: [
                Positioned(
                    left: 10,
                    top: 20,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white,
                        size: 25,
                      ),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Tools().getImage(link),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     height: 30,
                //     color: Colors.transparent,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         InkWell(
                //           onTap: () async {
                //             await _checkPermission().then((hasGranted) {
                //               setState(() {
                //                 _permissionReady = hasGranted;
                //               });
                //             });
                //             if (_permissionReady) {
                //               await _downloadImage(link);
                //               const snackBar = SnackBar(
                //                 content: Text("???? t???i ???nh xu???ng"),
                //                 duration: Duration(seconds: 3),
                //               );
                //               ScaffoldMessenger.of(context)
                //                   .showSnackBar(snackBar);
                //             } else {
                //               await _checkPermission().then((hasGranted) {
                //                 setState(() {
                //                   _permissionReady = hasGranted;
                //                 });
                //               });
                //             }
                //           },
                //           child: Container(
                //             child: Row(
                //               children: [
                //                 Icon(
                //                   Icons.download_rounded,
                //                   color: Colors.white,
                //                   size: 20,
                //                 ),
                //                 Text(
                //                   "T???i v???",
                //                   style: kText14White,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 75,
          width: 105,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xFFC4C4C4),
              borderRadius: BorderRadius.circular(15)),
          child: Tools().getImage(link, fit: BoxFit.fill) ?? Container(),
        ),
      ),
    );
  }
}
