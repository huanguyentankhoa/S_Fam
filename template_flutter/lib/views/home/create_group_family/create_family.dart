import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.only(left: 10, right: 10),
      titlePadding: EdgeInsets.zero,
      content: Stack(
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
      actionsPadding: EdgeInsets.only(bottom: 22),
      actions: [
        InkWell(
          onTap: () {
            _user.createFamily(familyName: _nameFamily.text,success: (code){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateGroupSuccess(codeFamily: code,),
                ),
              );
            });

          },
          child: Container(
            height: 52,
            width: MediaQuery.of(context).size.width - 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryMain,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "Tiếp tục",
              style: kText16WhiteBold,
            ),
          ),
        )
      ],
    );
  }
}
