import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/utils/config.dart';
import 'package:coc_trpg/app_theme_data.dart';
import 'create_age_page.dart';
class BaseInfoPage extends StatefulWidget{
  BaseInfoPage({Key key, this.investigator}): super(key: key);
  final Investigator investigator;

  @override
  _BaseInfoPage createState() => _BaseInfoPage();

}


class _BaseInfoPage extends State<BaseInfoPage>{

  GlobalKey<FormState> _formKey= new GlobalKey<FormState>();

  TextEditingController _chineseNameController = TextEditingController();
  TextEditingController _foreignNameController = TextEditingController();
  TextEditingController _internationController = TextEditingController();
  TextEditingController _languageController = TextEditingController();

  String _groupValue = "男";
  String _manValue = "男";
  String _womanValue = "女";

  String _chineseName = "";
  String _international = "";
  String _language = "";
  String _foreignName = "";

  void _formSubmit(){
    //提交
    var _form = _formKey.currentState;
    if(_form.validate()){
      _form.save();
      widget.investigator.name = _chineseName;
      widget.investigator.language = _language;
      widget.investigator.international = _international;
      widget.investigator.foreignName = _foreignName;
      widget.investigator.gender = _groupValue;
    }
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new CreateAgePage(investigator: widget.investigator,)));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                maxHeight: 500
              ),
              child: Form(
                 key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top:20),
                        child: TextFormField(
                          controller: _chineseNameController,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: "中文姓名",
                              hintStyle: AppTheme.createBaseInfoHintStyle,
                              border: InputBorder.none,
                              fillColor: AppTheme.investigatorMinorColor,
                              filled: true
                          ),
                          validator:(v){
                            if(v.isEmpty){
                              return "姓名不能为空";
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
                        child: TextFormField(
                          controller: _foreignNameController,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: "外文姓名(可选)",
                              hintStyle: AppTheme.createBaseInfoHintStyle,
                              border: InputBorder.none,
                              fillColor: AppTheme.investigatorMinorColor,
                              filled: true
                          ),
                          validator:(v){

                            if(v.length>20){
                              return "姓名超出限制";
                            }
                          },
                          onSaved: (v){
                            _foreignName = v;
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
                              child: Container(
                                alignment: Alignment.center,
                                child: Text("性别",style: TextStyle(fontSize: 22,color: Colors.white),),
                                color: AppTheme.investigatorMinorColor,
                                padding: EdgeInsets.all(5),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child:
                                RadioListTile(
                                    activeColor: AppTheme.investigatorMainColor,
                                    title: Text("男",style: TextStyle(fontSize: 22,color: Colors.white)),
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
                                    title: Text("女",style: TextStyle(fontSize: 22,color: Colors.white)),
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
                        child: TextFormField(
                          controller: _internationController,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: "国籍",
                              hintStyle: AppTheme.createBaseInfoHintStyle,
                              border: InputBorder.none,
                              fillColor: AppTheme.investigatorMinorColor,
                              filled: true
                          ),
                          validator:(v){
                            if(v.isEmpty){
                              return "国籍不能为空";
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
                          controller: _languageController,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: "母语(可选)",
                              hintStyle: AppTheme.createBaseInfoHintStyle,
                              border: InputBorder.none,
                              fillColor: AppTheme.investigatorMinorColor,
                              filled: true
                          ),
                          validator:(v){

                          },
                          onSaved: (v){
                            _language = v;
                          },

                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width,
                        child:RaisedButton(
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            color: Color(0xff20BAC1),
                            child: Text("下一步",style: TextStyle(color: Colors.white,fontSize: 22),),
                            onPressed: _formSubmit
                        ),
                      )

                    ],
                  )
              ),
            ),

          ]
        ),
      )
    );
  }



}


