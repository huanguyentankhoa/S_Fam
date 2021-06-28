import 'package:flutter/cupertino.dart';
import 'package:youreal/model/chat.dart';
import 'package:youreal/services/services_api.dart';

class ChatProvider with ChangeNotifier{
  List<GroupChat> listGroupChat = [];

  APIServices _services = APIServices();


  Future<void> getListGroupChat()async{
    listGroupChat = (await _services.getListGroupChat())!;
    notifyListeners();
  }
}