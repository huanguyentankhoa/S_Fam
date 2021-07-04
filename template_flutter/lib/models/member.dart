class Member {
  int? id;
  String? name;
  String? dob;
  String? email;
  String? phoneNumber;
  String? avatarUrl;
  String? gender;
  String? pinCode;
  String? codeFamily;
  Member.fromJson(Map<String, dynamic> parsedJson) {
    try {
      id = parsedJson["id"];
      name = parsedJson["fullName"];
      dob = parsedJson["dob"];
      email = parsedJson["email"];
      gender = parsedJson["gender"] ?? "";
      avatarUrl = parsedJson["imgUrl"] ;
      phoneNumber = parsedJson["phoneNumber"].toString();
      pinCode = parsedJson["pinCode"] ?? "";
     // codeFamily = parsedJson[""];
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "gender":gender,
      "dob":dob,
      "fullName":name,
      "phoneNumber":phoneNumber
    };
  }
}
