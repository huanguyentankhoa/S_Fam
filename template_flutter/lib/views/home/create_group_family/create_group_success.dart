import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/user_provider.dart';
class CreateGroupSuccess extends StatefulWidget {
  final codeFamily;
  const CreateGroupSuccess({Key? key, this.codeFamily}) : super(key: key);

  @override
  _CreateGroupSuccessState createState() => _CreateGroupSuccessState();
}

class _CreateGroupSuccessState extends State<CreateGroupSuccess> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Container(
                height: 287,

                child: Image.asset(
                  "assets/images/signin_success.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Mã gia đình của bạn là",
                  style: kText20BlueBold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Vui lòng copy và gửi cho thành viên để tham gia vào gia đình của bạn",
                  textAlign: TextAlign.center,
                  style: kSubText16Black,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                height: 58,
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color:Color(0xFFE8EAED),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(child: Container(
                      alignment: AlignmentDirectional.center,
                      child: Text(widget.codeFamily,style: kText16Black,),
                    ),),
                    InkWell(
                      onTap: (){
                        FlutterClipboard.copy(
                            widget.codeFamily)
                            .then((value) {
                          const snackBar = SnackBar(
                            content: Text("Đã sao chép mã gia đình"),
                            duration: Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        });
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        margin: EdgeInsets.only(right: 16),
                        child: Icon(Icons.copy,color: Color(0xFF272729),),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primaryMain,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          "Hoàn tất",
                          style: kText16WhiteBold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}