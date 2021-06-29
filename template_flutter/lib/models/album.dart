class Album{
  late int id;
  late String name;
  late List<String> listImage = [];


  Album.formJson(Map<String, dynamic> parsedJson){
    try{
      id = parsedJson["id"];
      name = parsedJson["name"];
      List<String> list = [];
     parsedJson["setImg"].forEach((img){
       list.add(img);
     });
     listImage = list;
    }catch(e){

    }
  }
}