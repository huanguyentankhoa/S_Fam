class StorageItem{
  late int id;
  late String name;
  late String detail;

  StorageItem.formJson(Map<String, dynamic> parsedJson){
    try{
      id = parsedJson["id"];
      name = parsedJson["name"];
      detail = parsedJson["detail"];
    }catch(e){

    }
  }
}