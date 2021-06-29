class EventModel {
  late int id;
  late String name;
  late String date;
  late String detail;
  late String startTime;
  late String endTime;
  late String repeatType;
  late String eventRemindType;
  late int remindNum;
  List<String> listMemberJoin = [];

  EventModel.formJson(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    date = data["day"];
    detail = data["detail"];
    startTime = data["startTime"];
    endTime = data["endTime"];
    repeatType = data["repeatType"];
    eventRemindType = data["eventRemindType"];
    remindNum = data["remindNum"];

    List<String> list = [];
    if (data["appUserSet"] != null)
      data["appUserSet"].forEach((item) {
        list.add(item);
      });
    listMemberJoin = list;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "day": date,
      "startTime": startTime,
      "endTime": endTime,
      "repeatType": repeatType,
      "eventRemindType": eventRemindType,
      "remindNum": remindNum,
      "appUserSet": listMemberJoin,
      "detail": detail
    };
  }
}
