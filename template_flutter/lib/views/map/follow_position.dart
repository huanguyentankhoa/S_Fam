import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/models/group.dart';
import 'package:s_fam/models/member.dart';
import 'package:s_fam/view_models/notification/notification_handler.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/widgets/animation_bell.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../menu.dart';

class FollowPosition extends StatefulWidget {
  const FollowPosition({Key? key}) : super(key: key);

  @override
  _FollowPositionState createState() => _FollowPositionState();
}

class _FollowPositionState extends State<FollowPosition> {
  var _position = LatLng(10.8468936, 106.6408852);
  late GoogleMapController _controller;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  late Timer _timer;
  List<Marker> listMarkers = [];
  Group? _group;
  static CameraPosition _kGoogle = CameraPosition(
    target: LatLng(10.8468936, 106.6408852),
    zoom: 14.4746,
  );
  bool _enablePosition = false;

  List<Member> membersOfGroup = [];

  _getCurrentPosition() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final GoogleMapController controller = _controller;
    final CameraPosition _kCurrentPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 19.151926040649414);
    if (mounted) {
      setState(() {
        _kGoogle = _kCurrentPosition;
      });
    }
    controller.animateCamera(CameraUpdate.newCameraPosition(_kCurrentPosition));
    setState(() {
      _position = LatLng(position.latitude, position.longitude);
    });
    await Provider.of<UserProvider>(context, listen: false).sendLocation(
        latitude: _position.latitude,
        longitude: _position.longitude,
        isEnablePosition: _enablePosition);
  }

  _moveCurrentPosition() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final GoogleMapController controller = _controller;
    final CameraPosition _kCurrentPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 19.151926040649414);
    controller.animateCamera(CameraUpdate.newCameraPosition(_kCurrentPosition));
    setState(() {
      _position = LatLng(position.latitude, position.longitude);
    });
    await Provider.of<UserProvider>(context, listen: false).sendLocation(
      latitude: _position.latitude,
      longitude: _position.longitude,
      isEnablePosition: _enablePosition,
    );
  }

  loadInit() async {
    _group = await Provider.of<UserProvider>(context, listen: false)
        .getDataMyGroup();
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool("${_group!.idGroup}_EnablePosition");
    if (result != null) {
      setState(() {
        _enablePosition = result;
      });
    } else {
      setState(() {
        _enablePosition = false;
      });
    }
    _group!.listMembers.forEach((m) async {
      Map<String, dynamic>? location =
          await Provider.of<UserProvider>(context, listen: false)
              .getLocation(email: m.email);
      if (location != null) {
        if (location["latitude"] != null && location["longitude"] != null) {
          double lat = double.parse(location["latitude"].toString());
          double long = double.parse(location["longitude"].toString());
          if (location["isEnablePosition"] != null &&
              location["isEnablePosition"] == true) {
            listMarkers.add(
              Marker(
                  markerId: MarkerId(m.id.toString()),
                  position: LatLng(lat, long),
                  anchor: Offset(0.2, 0.2),
                  icon: BitmapDescriptor.defaultMarker,
                  infoWindow: InfoWindow(title: m.name)),
            );
          }
        }
      }

      if (Provider.of<UserProvider>(context, listen: false).haveWarning) {
        //setPolyline();
      }
      if (mounted) setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   // polylinePoints = PolylinePoints();

    loadInit();
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      if (mounted) if (_enablePosition) {
        _getCurrentPosition();
      }
    });
  }

  saveEnablePosition(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("${_group!.idGroup}_EnablePosition", value);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(),
        title: Text(
          "Vị trí",
          style: kText24BlackBold,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Menu(),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            markers: Set<Marker>.of(listMarkers),
            initialCameraPosition: _kGoogle,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _enablePosition = !_enablePosition;
                      });
                      saveEnablePosition(_enablePosition);
                      if (_enablePosition) _moveCurrentPosition();
                    },
                    child: Container(
                      height: 48,
                      width: MediaQuery.of(context).size.width - 100,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                        color: _enablePosition ? Colors.red : primaryMain,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _enablePosition ? "TẮT VỊ TRÍ" : "BẬT VỊ TRÍ",
                        style: kText16WhiteBold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10, left: 10),
                    child: AnimationBell(
                      onTap: (result) async {
                        if (result) {
                          user.sendNotification(
                              title: "Yêu cầu trợ giúp",
                              body: "Bạn đang phát tín hiệu trợ giúp");
                          var pos = await Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high);
                           _getCurrentPosition();
                          user.sendLocation(
                              latitude: pos.latitude,
                              longitude: pos.longitude,
                              isEnablePosition: false);

                          user.sendWarning();
                        } else {
                          NotificationHandler.flutterLocalNotificationPlugin
                              .cancelAll();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          if(user.haveWarning)
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black45,
            child: Center(
              child:   InkWell(
                onTap: () {
                  setState(() {
                    user.haveWarning = false;
                  });
                  FlutterRingtonePlayer.stop();
                  NotificationHandler.flutterLocalNotificationPlugin
                      .cancelAll();
                },
                child: Container(
                  height: 100,
                  child: Column(
                    children: [
                      Text(
                        "Bạn đang có thông báo khẩn cấp",
                        style: kText16WhiteBold,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width - 100,
                        margin: EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Đã nhận thông báo",
                          style: kText16WhiteBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
