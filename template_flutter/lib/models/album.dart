import 'member.dart';

class Album{
  late int id;
  late String name;
  late List<String> listImage = [];
  late Member owner;

  Album.formJson(Map<String, dynamic> parsedJson){
    try{
      id = parsedJson["id"];
      name = parsedJson["name"];
      owner = Member.fromJson(parsedJson["appUserAlbum"]);
      List<String> list = [];
     parsedJson["setImg"].forEach((img){
       list.add(img);
     });
     listImage = list;
    }catch(e){

    }
  }
}