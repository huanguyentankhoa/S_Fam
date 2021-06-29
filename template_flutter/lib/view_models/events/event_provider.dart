import 'package:flutter/material.dart';
import 'package:s_fam/models/member.dart';

class EventProvider with ChangeNotifier{
  List<Member> _listMemberAdd = [];

  List<Member> get listMemberAdd => _listMemberAdd;

  set listMemberAdd(List<Member> value) {
    _listMemberAdd = value;
    notifyListeners();
  }

}