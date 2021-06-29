class StorageAccount{
  late int id;
  late String name;
  late String detail;
  StorageAccount.formJson(Map<String, dynamic> parsedJson){
    try{
      id = parsedJson["id"];
      name = parsedJson["name"];
      detail = parsedJson["detail"];
    }catch(e){

    }
  }
}