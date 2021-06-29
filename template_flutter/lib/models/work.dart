class Work{
  late int id;
  late String name;
  late String detail;
  late String startDay;
  late String endDay;
  late String startTime;
  late String endTime;
  late List<String> repeatType;
  Work.formJson(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"].toString();
    detail = data["detail"].toString();
    startDay = data["startDay"].toString();
    endDay = data["endDay"].toString();
    startTime = data["startTime"].toString();
    endTime = data["endTime"].toString();
    List<String> list = [];
    data["repeatType"].forEach((item){
      list.add(item.toString());
    });
    repeatType = list;
  }
  Map<String, dynamic> toJson(){
    return {
      "name":name,
      "startDay":startDay,
      "endDay":endDay,
      "startTime":startTime,
      "endTime":endTime,
      "repeatType":repeatType,
      "detail":detail
    };
  }
}

