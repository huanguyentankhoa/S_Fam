

class GroupChat{
  late int id;
  late String name;
  late String message;
  late int numberMessageWait;
  late int numberMember;

  GroupChat.formJson(Map<String, dynamic> parsedJson){
    id = parsedJson["id"];
    name = parsedJson["name"];
    message = parsedJson["message"];
    numberMember = parsedJson["numberMember"];
    numberMessageWait = parsedJson["numberMessageWait"];
  }
}

List<Map<String, dynamic>> listGroupChat = [
  {
    "id":1,
    "name":"Nhóm BDS TP. HCM",
    "message":"Thông tin 1 ",
    "numberMember":10,
    "numberMessageWait":10
  },
  {
    "id":2,
    "name":"Nhóm BDS TP. Hà nội",
    "message":"Thông tin 1 ",
    "numberMember":10,
    "numberMessageWait":10
  },
  {
    "id":3,
    "name":"Nhóm BDS TP. Cần thơ",
    "message":"Thông tin 1 ",
    "numberMember":10,
    "numberMessageWait":10
  },
  {
    "id":4,
    "name":"Nhóm BDS Tỉnh bình dương",
    "message":"Thông tin 1 ",
    "numberMember":10,
    "numberMessageWait":10
  },
  {
    "id":5,
    "name":"Nhóm BDS TP. thủ đức",
    "message":"Thông tin 1 ",
    "numberMember":10,
    "numberMessageWait":10
  },
  {
    "id":6,
    "name":"Nhóm BDS Tỉnh khánh hòa",
    "message":"Thông tin 1 ",
    "numberMember":10,
    "numberMessageWait":10
  },
  {
    "id":7,
    "name":"Nhóm BDS Tỉnh đồng nai",
    "message":"Thông tin 1 ",
    "numberMember":10,
    "numberMessageWait":10
  },
  {
    "id":8,
    "name":"Nhóm BDS chung cư",
    "message":"Thông tin 1 ",
    "numberMember":10,
    "numberMessageWait":10
  },

];
