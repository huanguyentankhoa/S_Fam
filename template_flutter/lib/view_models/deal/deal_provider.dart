import 'package:flutter/cupertino.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/services/services_api.dart';

class DealProvider extends ChangeNotifier{

  List<Deal> listDealRecently = [];
  List<Deal> listDealSuggest = [];
  List<Deal> listDealInvesting = [];
  List<Deal> listDealInvested = [];


  APIServices _services = APIServices();


  Future<void> getListDealRecently()async{
   listDealRecently = (await _services.getListDealRecently())!;
   notifyListeners();
  }
  Future<void> getListDealSuggest()async{
    listDealSuggest = (await _services.getListDealSuggest())!;
    notifyListeners();
  }
  Future<void> getListDealInvesting()async{
    listDealInvesting = (await _services.getListDealInvesting())!;
    notifyListeners();
  }
  Future<void> getListDealInvested()async{
    listDealInvested = (await _services.getListDealInvested())!;
    notifyListeners();
  }
}
































// import 'dart:async';

// class ListenBloc {
  
//   bool showListSearch = false;
//   final eventController = StreamController<bool>();
  
//   // 1 cái quản lý state, đảm nhận nhiệm vụ truyền state đến UI
//   final stateController = StreamController<bool>();

//   ListenBloc() {
//     // lắng nghe khi eventController push event mới  
//     eventController.stream.listen((bool isShow) {
    
//       showListSearch = isShow;
//       // add state mới vào stateController để bên UI nhận được
//       stateController.sink.add(showListSearch);
//     });
//   }

//   // khi không cần thiết thì close tất cả controller
//   void dispose() {
//     stateController.close();
//     eventController.close();
//   }
// }