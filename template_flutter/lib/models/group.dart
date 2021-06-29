import 'package:s_fam/models/member.dart';

class Group{
  late int idGroup;
  late String key;
  late String name;
  late List<Member> listMembers;

  Group.fromJason(Map<String, dynamic> parsedJson){

   idGroup = parsedJson["id"]??0;
   idGroup = parsedJson["id"]!=null?parsedJson["id"]:0;


   name = parsedJson["name"];

   List<Member> members = [];

   parsedJson["memberSet"].forEach((m){
     Member _m = Member.fromJson(m);
     members.add(_m);
   });

   listMembers = members;
  }
}

