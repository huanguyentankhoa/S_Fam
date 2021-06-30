import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
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

class _FollowPositionState extends State<FollowPosition>
    with AutomaticKeepAliveClientMixin {
  var _position = LatLng(10.8468936, 106.6408852);
  Completer<GoogleMapController> _controller = Completer();
  GlobalKey<ScaffoldState> _key = GlobalKey();
  late Timer _timer;
  static final CameraPosition _kGoogle = CameraPosition(
    target: LatLng(10.8468936, 106.6408852),
    zoom: 14.4746,
  );
  bool _enablePosition = false;

  _getCurrentPosition() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final GoogleMapController controller = await _controller.future;
    final CameraPosition _kCurrentPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 19.151926040649414);
    controller.animateCamera(CameraUpdate.newCameraPosition(_kCurrentPosition));
    setState(() {
      _position = LatLng(position.latitude, position.longitude);
    });
  }

  loadInit() async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool("EnablePosition");
    if (result != null) {
      setState(() {
        _enablePosition = result;
      });
    } else {
      setState(() {
        _enablePosition = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInit();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (mounted) if (_enablePosition) {
        _getCurrentPosition();
      }
    });
  }

  saveEnablePosition(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("EnablePosition", value);
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
        leading: InkWell(
          onTap: () {
            _key.currentState!.openDrawer();
          },
          child: Container(
            child: Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
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
            onTap: (LatLng _latLng) async {},
            markers: Set.of([
              Marker(
                markerId: MarkerId("home"),
                draggable: true,
                position: _position,
                zIndex: 2,
                flat: true,
                anchor: Offset(0.5, 0.5),
              ),
            ]),
            initialCameraPosition: _kGoogle,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
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
                      if (_enablePosition) _getCurrentPosition();
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
                      onTap: (result) {

                        if (result) {
                          user.sendNotification(title: "Yêu cầu trợ giúp",body: "Bạn đang phát tín hiệu trợ giúp");
                        }
                        else {
                          NotificationHandler.flutterLocalNotificationPlugin.cancelAll();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
