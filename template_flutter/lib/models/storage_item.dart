import 'member.dart';

class StorageItem{
  late int id;
  late String name;
  late String detail;
  late Member owner;
  String? image;
  StorageItem.formJson(Map<String, dynamic> parsedJson){
    try{
      id = parsedJson["id"];
      name = parsedJson["name"];
      detail = parsedJson["detail"];
      image = parsedJson["imgName"];
      owner = Member.fromJson(parsedJson["appUserItem"]);
    }catch(e){

    }
  }
}