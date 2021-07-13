import 'package:flutter/material.dart';
import 'package:s_fam/common/constants/texts_config.dart';

class TextInput extends StatefulWidget {
  final double height;
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final bool? enable;
  final int? maxLength;
  final int? maxLine;

  TextInput(
      {Key? key,
      required this.height,
      this.validator,
      required this.controller,
      this.obscureText = false,
      this.decoration,
      required this.labelText,
      this.keyboardType,
      this.enable,
      this.maxLength,
        this.maxLine
      })
      : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  // TextEditingController _textInput = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isError = false;
    });
  }

  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            _focusNode.requestFocus();
          },
          child: Container(
            height: widget.height,
            child: Container(
              height: widget.height - 7,
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: isError
                        ? Colors.red
                        : _focusNode.hasFocus
                            ? Colors.blue
                            : Color(0xFFD4D7DB)),
              ),
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          obscureText: widget.obscureText!,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: widget.keyboardType ?? null,
          maxLength: widget.maxLength ?? null,
          readOnly: widget.enable ?? false,
          maxLines: widget.maxLine??1,
          validator: (value) {
            if (widget.validator!(value) != null) {
              setState(() {
                isError = true;
              });
            } else {
              setState(() {
                isError = false;
              });
            }

            return widget.validator!(value);
          },
          decoration: widget.decoration ??
              InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10, top: 10),
                suffixIcon: Container(
                  width: 20,
                ),
              ),
        ),
        Container(
            height: 20,
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.only(left: 3, right: 3),
            color: Colors.white,
            child: Text(
              widget.labelText,
              style: isError
                  ? kText14Red
                  : _focusNode.hasFocus
                      ? kText14Blue
                      : kSubText14Black,
            ))
      ],
    );
  }
}
