import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/models/member.dart';
import 'package:s_fam/view_models/events/event_provider.dart';
import 'package:s_fam/view_models/user_provider.dart';

class AddMember extends StatefulWidget {
  const AddMember({Key? key}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;

  List<Member> _listMemberAdd = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EventProvider _event = Provider.of<EventProvider>(context);
    final _user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              _appBarBuild(),
              SizedBox(
                height: 32,
              ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _user.groupOfUser!.listMembers.length,
                    itemBuilder: (context, index) {
                      var member =  _user.groupOfUser!.listMembers[index];
                      return CardMember(
                          name:member.name!,
                          id: member.id.toString(),
                          onCheck: (value) {
                            if (value) {
                              _listMemberAdd.add(member);
                            } else {
                              int i = _listMemberAdd
                                  .indexOf(member);
                              _listMemberAdd.removeAt(i);
                            }
                          });
                    }),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: _listMemberAdd.isEmpty?null:() {
                    _event.listMemberAdd = _listMemberAdd;
                    Navigator.pop(context, _listMemberAdd);
                  },
                  child: Container(
                    height: 52,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _listMemberAdd.isEmpty?textSecondary:primaryMain,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Thêm thành viên",
                      style: kText16WhiteBold,
                    ),
                  ),
                ),
              ))
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
                SvgPicture.asset("assets/icons/back.svg",color: Colors.black,),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Thêm thành viên",
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

class CardMember extends StatefulWidget {
  final String name;
  final String id;
  final Function(bool) onCheck;

  const CardMember({
    Key? key,
    required this.name,
    required this.id,
    required this.onCheck,
  }) : super(key: key);

  @override
  _CardMemberState createState() => _CardMemberState();
}

class _CardMemberState extends State<CardMember> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: textSecondary),
      ),
      child: Row(
        children: [
          Container(
            height: 28,
            width: 28,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.asset("assets/images/Ellipse10.png"),
          ),
          Text(
            widget.name,
            style: kText14Black,
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 8),
            child: Checkbox(
              value: isCheck,
              onChanged: (value) {
                setState(() {
                  isCheck = value!;
                });
                widget.onCheck(value!);
              },
              splashRadius: 8,
            ),
          ))
        ],
      ),
    );
  }
}
