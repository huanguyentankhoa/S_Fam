class News {
  late int id;
  late String name;
  late String content;
  late String createDate;
  late int kind;
  late String image;

  News.formJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
    name = parsedJson["name"];
    content = parsedJson["content"];
    createDate = parsedJson["createDate"];
    kind = parsedJson["kind"];
    image = parsedJson["image"];
  }
}

List<Map<String, dynamic>> listNews = [
  {
    "id": 1,
    "name": "XUNG QUANH",
    "content": "Dịch Covid ảnh hưởng tới các ngành công nghiệp như thế nào?",
    "createDate": "Thứ 2, 26/04/2021",
    "image": "iamge4.png",
    "kind": 1,
  },
  {
    "id": 2,
    "name": "XUNG QUANH",
    "content": "Dịch Covid ảnh hưởng tới các ngành công nghiệp như thế nào?",
    "createDate": "Thứ 2, 26/04/2021",
    "image": "catagory2.png",
    "kind": 1,
  },
  {
    "id": 3,
    "name": "XUNG QUANH",
    "content": "Dịch Covid ảnh hưởng tới các ngành công nghiệp như thế nào?",
    "createDate": "Thứ 2, 26/04/2021",
    "image": "catagory.png",
    "kind": 1,
  },
  {
    "id": 4,
    "name": "BẤT ĐỘNG SẢN",
    "content": "Lorem Ipsum Dolor Amet",
    "createDate": "Thứ 2, 26/04/2021",
    "image": "catagory.png",
    "kind": 2,
  },
  {
    "id": 5,
    "name": "KINH TẾ",
    "content": "Dịch Covid ảnh hưởng tới các ngành kinh tế như thế nào?",
    "createDate": "Thứ 2, 26/04/2021",
    "image": "catagory2.png",
    "kind": 2,
  },
  {
    "id": 6,
    "name": "PHÁP LUẬT",
    "content": "Lorem Ipsum Dolor Amet",
    "createDate": "Thứ 2, 26/04/2021",
    "image": "catagory1.png",
    "kind": 2,
  },
  {
    "id": 7,
    "name": "XÃ HỘI",
    "content": "Dịch Covid ảnh hưởng tới xã như thế nào?",
    "createDate": "Thứ 2, 26/04/2021",
    "image": "catagory.png",
    "kind": 2,
  },
];
