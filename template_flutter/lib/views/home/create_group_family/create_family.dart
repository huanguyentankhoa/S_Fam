import 'package:flutter/material.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/create_group_family/create_group_success.dart';
import 'package:s_fam/widgets/text_input.dart';
class CreateFamily extends StatefulWidget {
  const CreateFamily({Key? key}) : super(key: key);

  @override
  _CreateFamilyState createState() => _CreateFamilyState();
}

class _CreateFamilyState extends State<CreateFamily> {
  TextEditingController _nameFamily = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late UserProvider _user;

  ButtonStatus stateOnlyText = ButtonStatus.idle;


  void onPressedCustomButton() async {
    if (stateOnlyText == ButtonStatus.idle) {
      setState(() {
        stateOnlyText = ButtonStatus.loading;
      });
      Future.delayed(Duration(seconds: 2), () async {
        if (_formKey.currentState!.validate()) {
          _user.createFamily(familyName: _nameFamily.text,success: (code){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateGroupSuccess(codeFamily: code,),
              ),
            );
            setState(() {
              stateOnlyText = ButtonStatus.success;
            });
            setState(() {
              stateOnlyText = ButtonStatus.idle;
            });
          },
            fail: (){
              setState(() {
                stateOnlyText = ButtonStatus.fail;
              });
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  stateOnlyText = ButtonStatus.idle;
                });
              });
            }
          );

        } else {
          setState(() {
            stateOnlyText = ButtonStatus.fail;
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              stateOnlyText = ButtonStatus.idle;
            });
          });
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
     _user = Provider.of<UserProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.only(left: 10, right: 10),
      titlePadding: EdgeInsets.zero,
      content: Form(
        key: _formKey,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                height:
                MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Center(
              child: Container(
                height: 130,
                width: MediaQuery.of(context).size.width -
                    20,
                color: Colors.white,
                padding: EdgeInsets.only(left: 16,right: 16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text("Vui lòng nhập tên để tạo mới",style: kText18BlueBold,),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextInput(
                      height: 48,
                      labelText: "Tên gia đình",
                      validator: (value) {
                        return value!.isEmpty ? "Không được bỏ trống" : null;
                      },
                      controller: _nameFamily,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(bottom: 22),
      actions: [
        Container(
          height: 52,
          width: MediaQuery.of(context).size.width - 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ProgressButtonAnimation(
            onPressed: onPressedCustomButton,
            state: stateOnlyText,
            height: 52,
            maxWidth: MediaQuery.of(context).size.width,
            stateWidgets: {
              ButtonStatus.idle: Text(
                "Tiếp tục",
                style: kText16WhiteBold,
              ),
              ButtonStatus.fail: Text(
                "Xảy ra lỗi",
                style: kText14White,
              ),
              ButtonStatus.success: Text(
                "Tiếp tục",
                style: kText14White,
              ),
            },
            stateColors: {
              ButtonStatus.idle: primaryMain,
              ButtonStatus.loading: primaryMain,
              ButtonStatus.fail: Colors.red,
              ButtonStatus.success: Colors.green,
            },
          ),
        )
      ],
    );
  }
}
