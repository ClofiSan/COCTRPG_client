import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/utils/AppConfig.dart';
import 'package:coc_trpg/AppThemeData.dart';
import 'package:coc_trpg/controller/InvestigatorController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'create_occupation_skill_page.dart';

class BaseInfoPage extends StatefulWidget{
  BaseInfoPage({Key key, this.investigator}): super(key: key);
  final Investigator investigator;

  @override
  _BaseInfoPage createState() => _BaseInfoPage();

}


class _BaseInfoPage extends State<BaseInfoPage>{

  GlobalKey<FormState> _formKey= new GlobalKey<FormState>();

  TextEditingController _chineseNameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _internationController = TextEditingController();
  TextEditingController _hometownController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  String _groupValue = "男";
  String _manValue = "男";
  String _womanValue = "女";

  String _chineseName = "";
  String _international = "";
  String _location = "";
  String _hometown = "";
  int _age;
  int _timeIndex = 0;
  String _time = "时代";

  TextStyle _inputTextFormStyle = TextStyle(fontSize: 22,color: Colors.white);
  TextStyle _dialogTextStyle = TextStyle(
      fontSize: 18,
      color: Colors.white
  );

  String _errorToastString = "";


  void _formSubmit(){
    //提交
    var _form = _formKey.currentState;
    if(_form.validate()){
      _form.save();
      widget.investigator.name = _chineseName;
      widget.investigator.location = _location;
      widget.investigator.hometown = _hometown;
      widget.investigator.international = _international;
      widget.investigator.gender = _groupValue;
      widget.investigator.age = _age;
      widget.investigator.time = InvestigatorController.timeDescription[_timeIndex];

    }else{
      _errorToastString = "输入不能为空";
    }
    try {

      Fluttertoast.showToast(
          msg: _errorToastString,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16
      );
    }catch (e){
      print(e);
    }

    Navigator.push(context, new MaterialPageRoute(builder: (context) => CreateOccupationSkillPage(investigator: widget.investigator,)));
  }

  Widget buildLabelContainer(String labelName){
    return Container(
      alignment: Alignment.center,
      height: 50,
      child: Text(labelName,style: TextStyle(fontSize: 22,color: Colors.white),),
      color: AppTheme.investigatorMinorColor,
      padding: EdgeInsets.all(5),
    );
  }

  InputDecoration buildInputDecoration(hintText){
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTheme.createBaseInfoHintStyle,
      border: InputBorder.none,
      fillColor: AppTheme.investigatorMinorColor,
      filled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    showTimeDialog(BuildContext context){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              backgroundColor: AppTheme.investigatorMinorColor,
              title: Text("选择时代",style: _dialogTextStyle,),
              content:
              Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child:Container(
                    child: ListView.builder(
                        itemCount: InvestigatorController.timeDescription.length,
                        itemBuilder:(context,index){
                          return Container(
                            color: index == _timeIndex?AppTheme.investigatorMainColor:null,
                            child: FlatButton(
                                onPressed: (){
                                  setState(() {
                                    _timeIndex = index;
                                    _time = InvestigatorController.timeDescription[index];
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Text(
                                  InvestigatorController.timeDescription[index],
                                  style:_dialogTextStyle,
                                )
                            ),
                          );
                        }
                    ),
                  )
              ),

            );
          }
      );
    }

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xbb20BAC1), Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:  AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("基础信息",style: TextStyle(fontSize: 45),),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child:   Divider(
                      thickness: 3,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child:   Text(
                      "必不可少的调查员基础信息",
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 50,right: 50),
              constraints: BoxConstraints(
                maxWidth: 250,
              ),
              child: Column(
//                  shrinkWrap: true,
                  children:<Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top:20),
                            child: TextFormField(
                              style: _inputTextFormStyle,
                              controller: _chineseNameController,
                              autofocus: false,
                              decoration: buildInputDecoration('姓名'),
                              validator:(v){
                                if(v.isEmpty){
                                  _errorToastString = "输入不能为空";
                                }
                                if(v.length>20){
                                  return "姓名超出限制";
                                }
                              },
                              onSaved: (v){
                                _chineseName = v;
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:20),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: buildLabelContainer('性别')
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child:
                                    RadioListTile(
                                        activeColor: AppTheme.investigatorMainColor,
                                        title: Text("男",style: _inputTextFormStyle),
                                        value: _manValue,
                                        groupValue: _groupValue,
                                        onChanged: (v){
                                          setState(() {
                                            _groupValue = v;
                                          });
                                        }
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child:
                                    RadioListTile(
                                        activeColor: AppTheme.investigatorMainColor,
                                        title: Text("女",style: _inputTextFormStyle),
                                        value: _womanValue,
                                        groupValue: _groupValue,
                                        onChanged: (v){
                                          setState(() {
                                            _groupValue = v;
                                          });
                                        }
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:20),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child:  Container(
                                      height: 50,
                                      child: TextFormField(
                                        style: _inputTextFormStyle,
                                        controller: _ageController,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: '年龄',
                                          hintStyle: AppTheme.createBaseInfoHintStyle,
                                          border: InputBorder.none,
                                          fillColor: AppTheme.investigatorMinorColor,
                                          filled: true,
                                          errorStyle: TextStyle(color: Colors.red[600])
                                        ),
                                        validator:(v){
                                          if(v.isEmpty){
                                            _errorToastString = "输入不能为空";
                                          }
                                          //正则表达式校验数字
                                        },
                                        onSaved: (v){
                                          if(v.isNotEmpty){
                                            _age = int.parse(v);
                                          }
                                        },
                                      ),
                                    ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    margin: EdgeInsets.only(left: 20),
                                    child: FlatButton(
                                        color: AppTheme.investigatorMinorColor,
                                        onPressed: (){
                                          showTimeDialog(context);
                                        },
                                        child:Text(_time,style: _dialogTextStyle,)
                                    ),
                                  )
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:20),
                            child: TextFormField(
                              style: _inputTextFormStyle,
                              controller: _internationController,
                              autofocus: false,
                              decoration: buildInputDecoration('国籍'),
                              validator:(v){
                                if(v.isEmpty){
                                  _errorToastString = "输入不能为空";
                                }
                              },
                              onSaved: (v){
                                _international = v;
                              },

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:20),
                            child: TextFormField(
                              style: _inputTextFormStyle,
                              controller: _locationController,
                              autofocus: false,
                              decoration: buildInputDecoration('住地'),
                              validator:(v){
                                if(v.isEmpty){
                                  _errorToastString = "输入不能为空";
                                }
                              },
                              onSaved: (v){
                                _location = v;
                              },

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:20),
                            child: TextFormField(
                              style: _inputTextFormStyle,
                              controller: _hometownController,
                              autofocus: false,
                              decoration: buildInputDecoration('故乡'),
                              validator:(v){
                                if(v.isEmpty){
                                  _errorToastString = "输入不能为空";
                                }
                              },
                              onSaved: (v){
                                _hometown = v;
                              },

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            width: MediaQuery.of(context).size.width,
                            child:RaisedButton(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                color: Color(0xff20BAC1),
                                child: Text("下一步",style: TextStyle(color: Colors.white,fontSize: 22),),
                                onPressed: _formSubmit
                            ),
                          )

                        ],
                      ),

                    )
                  ],

              ),
            ),

          ]
        ),
      )
    );
  }



}


