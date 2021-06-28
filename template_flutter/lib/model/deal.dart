class Deal{
  late int id;
  late int status;
  late String name;
  late String address;
  late double acreage;
  late int numberFollower;
  late String price;
  late String imageSample;
  late List<String> images;
  late bool isExpired;
  late bool isInvestorsMain;
  late String note;

  Deal.formJson(Map<String,dynamic>parsedJson){
    id = parsedJson["id"];
    status = parsedJson["status"];
    name = parsedJson["name"];
    address = parsedJson["address"];
    acreage = double.parse(parsedJson["acreage"].toString());
    numberFollower = parsedJson["numberFollower"];
    price = parsedJson["price"];
    imageSample = parsedJson["imageSample"];
   List<String> list = [];
    parsedJson["images"].forEach((item){
      list.add(item);
    });
    images = list;
    isExpired = parsedJson["isExpired"];
    isInvestorsMain = parsedJson["isInvestorsMain"];
    note =  parsedJson["note"];
  }
}

List<Map<String, dynamic>> listDeals = [
  {
    "id":1,
    "status":1,
    "name": "Biệt thự Canadar",
    "address": "17 Lý Thường Kiệt, P.5, Huyện Củ Chi, TP. Hồ Chí Minh ",
    "price": "7.7 tỷ",
    "acreage": 120,
    "numberFollower": 150,
    "isExpired": false,
    "isInvestorsMain": false,
    "imageSample": "image2.png",
    "images": [
      "/image2.png",
      "/image2.png",
      "/image2.png",
      "image2.png",
    ],
    "note":"",
  },
  {
    "id":2,
    "status":1,
    "name": "Biệt thự Canadar",
    "address": "17 Lý Thường Kiệt, P.5, Huyện Củ Chi, TP. Hồ Chí Minh ",
    "acreage": 120,
    "numberFollower": 150,
    "price": "7.7 tỷ",
    "isExpired": false,
    "isInvestorsMain": false,
    "imageSample": "image2.png",
    "images": [
      "image2.png",
      "image2.png",
      "image2.png",
      "image2.png",
    ],
    "note":"",
  },
  {
    "id":3,
    "status":1,
    "name": "Biệt thự Canadar",
    "address": "17 Lý Thường Kiệt, P.5, Huyện Củ Chi, TP. Hồ Chí Minh ",
    "acreage": 120,
    "numberFollower": 150,
    "price": "7.7 tỷ",
    "isExpired": true,
    "isInvestorsMain": false,
    "imageSample": "image2.png",
    "images": [
      "image2.png",
      "image2.png",
      "image2.png",
      "image2.png",
    ],
    "note":"",
  },
  {
    "id":4,
    "status":1,
    "name": "Biệt thự Canadar",
    "address": "17 Lý Thường Kiệt, P.5, Huyện Củ Chi, TP. Hồ Chí Minh ",
    "acreage": 120,
    "numberFollower": 150,
    "price": "7.7 tỷ",
    "isExpired": true,
    "isInvestorsMain": false,
    "imageSample": "image2.png",
    "images": [
      "image2.png",
      "image2.png",
      "image2.png",
      "image2.png",
    ],
    "note":"",
  },

  {
    "id":5,
    "status":2,
    "name": "Ngôi nhà A",
    "address": "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
    "acreage": 120,
    "numberFollower": 150,
    "price": "3.2 tỷ",
    "isExpired": false,
    "isInvestorsMain": false,
    "imageSample": "image_card.png",
    "images": [
      "image_1.png",
      "image_2.png",
      "image_3.png",
      "image_4.png",
    ],
    "note":"",
  },
  {
    "id":6,
    "status":2,
    "name": "Ngôi nhà B",
    "address": "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
    "acreage": 120,
    "numberFollower": 150,
    "price": "1.7 tỷ",
    "isExpired": false,
    "isInvestorsMain": false,
    "imageSample": "image_card.png",
    "images": [
      "image_1.png",
      "image_2.png",
      "image_3.png",
      "image_4.png",
    ],
    "note":"",
  },
  {
    "id":7,
    "status":2,
    "name": "Ngôi nhà C",
    "address": "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
    "acreage": 120,
    "numberFollower": 150,
    "price": "3.2 tỷ",
    "isExpired": false,
    "isInvestorsMain": false,
    "imageSample": "image_card.png",
    "images": [
      "image_1.png",
      "image_2.png",
      "image_3.png",
      "image_4.png",
    ],
    "note":"",
  },


  {
    "id":8,
    "status":3,
    "name": "Đất nền Quận 7",
    "address": "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
    "acreage": 160,
    "numberFollower": 0,
    "price": "7.7 tỷ",
    "isExpired": false,
    "isInvestorsMain": true,
    "imageSample": "image_card.png",
    "images": [
      "image_1.png",
      "image_2.png",
      "image_3.png",
      "image_4.png",
    ],
    "note":"",
  },
  {
    "id":9,
    "status":3,
    "name": "Đất nền Quận 7",
    "address": "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
    "acreage": 160,
    "numberFollower": 0,
    "price": "7.7 tỷ",
    "isExpired": false,
    "isInvestorsMain": true,
    "imageSample": "image_card.png",
    "images": [
      "image_1.png",
      "image_2.png",
      "image_3.png",
      "image_4.png",
    ],
    "note":"",
  },
  {
    "id":10,
    "status":3,
    "name": "Đất nền Quận 7",
    "address": "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
    "acreage": 160,
    "numberFollower": 0,
    "price": "7.7 tỷ",
    "isExpired": false,
    "isInvestorsMain": true,
    "imageSample": "image_card.png",
    "images": [
      "image_1.png",
      "image_2.png",
      "image_3.png",
      "image_4.png",
    ],
    "note":"",
  },
  {
    "id":11,
    "status":3,
    "name": "Đất nền Quận 7",
    "address": "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
    "acreage": 160,
    "numberFollower": 0,
    "price": "7.7 tỷ",
    "isExpired": false,
    "isInvestorsMain": true,
    "imageSample": "image_card.png",
    "images": [
      "image_1.png",
      "image_2.png",
      "image_3.png",
      "image_4.png",
    ],
    "note":"",
  },


  {
    "id":12,
    "status":4,
    "name": "Chung cư Đông Dương",
    "address": "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
    "acreage": 160,
    "numberFollower": 0,
    "price": "7.7 tỷ",
    "isExpired": false,
    "isInvestorsMain": true,
    "imageSample": "image_card.png",
    "images": [
      "image_1.png",
      "image_2.png",
      "image_3.png",
      "image_4.png",
    ],
    "note":"",
  },
   {
    "id":13,
    "status":4,
    "name": "Chung cư Đông Dương",
    "address": "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
    "acreage": 160,
    "numberFollower": 0,
    "price": "7.7 tỷ",
    "isExpired": false,
    "isInvestorsMain": true,
    "imageSample": "image_card.png",
    "images": [
      "image_1.png",
      "image_2.png",
      "image_3.png",
      "image_4.png",
    ],
    "note":"",
  },
   {
    "id":14,
    "status":4,
    "name": "Chung cư Đông Dương",
    "address": "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
    "acreage": 160,
    "numberFollower": 0,
    "price": "7.7 tỷ",
    "isExpired": false,
    "isInvestorsMain": true,
    "imageSample": "image_card.png",
    "images": [
      "image_1.png",
      "image_2.png",
      "image_3.png",
      "image_4.png",
    ],
    "note":"",
  },
   {
    "id":15,
    "status":4,
    "name": "Chung cư Đông Dương",
    "address": "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
    "acreage": 160,
    "numberFollower": 0,
    "price": "7.7 tỷ",
    "isExpired": false,
    "isInvestorsMain": true,
    "imageSample": "image_card.png",
    "images": [
      "image_1.png",
      "image_2.png",
      "image_3.png",
      "image_4.png",
    ],
    "note":"",
  },

];
