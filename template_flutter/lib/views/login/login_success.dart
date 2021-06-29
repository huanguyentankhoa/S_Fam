import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/views/home/create_group_family/create_family.dart';
import 'package:s_fam/views/home/join_group/join_group.dart';

class LoginSuccess extends StatefulWidget {
  const LoginSuccess({Key? key}) : super(key: key);

  @override
  _LoginSuccessState createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {


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
                  "Chào mừng bạn đến với S-Fam",
                  style: kText20BlueBold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Bạn vui lòng tạo gia đình mới hoặc nhập code để tham gia vào gia đình",
                  textAlign: TextAlign.center,
                  style: kSubText16Black,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            var result = await showDialog(
                              context: context,
                              builder: (context) => CreateFamily(),
                            );
                          },
                          child: Container(
                            height: 52,
                            width: 152,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: primaryMain)),
                            child: Text(
                              "Tạo mới",
                              style: kText16BlueBold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var result = await showDialog(
                              context: context,
                              builder: (context) => JoinGroup(
                                onBack: (){},
                              ),
                            );
                          },
                          child: Container(
                            height: 52,
                            width: 152,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryMain,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              "Tham gia",
                              style: kText16WhiteBold,
                            ),
                          ),
                        ),
                      ],
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
