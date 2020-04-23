import 'package:flutter/material.dart';
import 'package:coc_trpg/AppThemeData.dart';
class NormalInputField extends StatefulWidget{
  NormalInputField({
    Key key,
    this.validatorFunction,
    this.onSavedFunction,
    this.controller,
    this.hintText,
    this.maxLine = 1
  }): super(key: key);
  final validatorFunction;
  final onSavedFunction;
  final TextEditingController controller;
  final String hintText;
  final int maxLine;
  @override
  _NormalInputField createState() => _NormalInputField();

}


class _NormalInputField extends State<NormalInputField>{

  InputDecoration buildInputDecoration(hintText){
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTheme.createBaseInfoHintStyle,
      border: InputBorder.none,
      fillColor: AppTheme.investigatorMinorColor,
      filled: true,
    );
  }

  TextStyle _inputTextFormStyle = TextStyle(
      fontSize: 18,
      color: Colors.white
  );


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      maxLines: widget.maxLine,
      style: _inputTextFormStyle,
      controller: widget.controller,
      autofocus: false,
      decoration: buildInputDecoration(widget.hintText),
      validator:widget.validatorFunction,
      onSaved:widget.onSavedFunction
    );
  }

}


