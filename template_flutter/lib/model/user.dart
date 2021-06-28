class User {
  late String id;
  String? firstName;
  String? lastName;
  int? roleId;
  String? roleName;
  String? dateOfBirth;
  String? token;


  User.formJason(Map<String, dynamic> parsedJson, String token) {
    id = parsedJson["userId"];
    roleId = parsedJson["roleId"];
    roleName = parsedJson["roleName"];
    firstName = parsedJson["firstName"];
    lastName = parsedJson["lastName"];
    dateOfBirth = parsedJson["dateOfBirth"];
    this.token = token;
  }
  User.formLocalJason(Map<String, dynamic> parsedJson) {
    id = parsedJson["userId"];
    roleId = parsedJson["roleId"];
    roleName = parsedJson["roleName"];
    firstName = parsedJson["firstName"];
    lastName = parsedJson["lastName"];
    dateOfBirth = parsedJson["dateOfBirth"];
    this.token = parsedJson["token"];
  }
}


List<Map<String, dynamic>> users = [
  {
    "id": 1,
    "name": "NDT",
    "typeUser": 1,
    "isLeader": true,
  },
  {
    "id": 2,
    "name": "Môi giới",
    "typeUser": 2,
  },
  {
    "id": 3,
    "name": "Admin",
    "typeUser": 0,
  },
];
