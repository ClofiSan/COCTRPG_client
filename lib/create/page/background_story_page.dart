import 'package:flutter/material.dart';
import 'package:coc_trpg/create/widget/create_title_widget.dart';
import 'package:coc_trpg/create/widget/create_item_title_widget.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/model/BackgroundStory.dart';
import 'package:coc_trpg/controller/InvestigatorController.dart';
import 'package:provider/provider.dart';
import 'package:coc_trpg/store/CreateInvestigatorStore.dart';
import 'package:coc_trpg/create/widget/next_step_button.dart';
import 'package:coc_trpg/create/widget/normal_input_field.dart';
import 'dart:convert';
import 'package:coc_trpg/model/Storage.dart';
import 'package:coc_trpg/panel/page/home_page.dart';

class BackgroundStoryPage extends StatefulWidget{
  BackgroundStoryPage({Key key}): super(key: key);

  @override
  _BackgroundStoryPage createState() => _BackgroundStoryPage();

}


class _BackgroundStoryPage extends State<BackgroundStoryPage>{

  Investigator _investigator;
  List<String> _backgroundStoryTitleList;
  BackgroundStory _backgroundStory;

  String _personalDescription;
  String _faith;
  String _importantPeople;
  String _extraPlace;
  String _precious;
  String _features;
  String _wound;
  String _mentalIllness;
  String _background;

  TextEditingController _personalDescriptionController;
  TextEditingController _faithController;
  TextEditingController _importantPeopleController;
  TextEditingController _extraPlaceController;
  TextEditingController _preciousController;
  TextEditingController _featuresController;
  TextEditingController _woundController;
  TextEditingController _mentalIllnessController;
  TextEditingController _backgroundController;

  GlobalKey<FormState> _formKey= new GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _investigator = Provider
        .of<CreateInvestigatorStore>(context,listen: false)
        .investigator;
    _backgroundStory = BackgroundStory();
    _backgroundStoryTitleList = List();
    _backgroundStoryTitleList = InvestigatorController.backgroundStoryList;
    _personalDescriptionController = TextEditingController();
    _faithController = TextEditingController();
    _importantPeopleController = TextEditingController();
    _extraPlaceController = TextEditingController();
    _preciousController = TextEditingController();
    _featuresController = TextEditingController();
    _woundController = TextEditingController();
    _mentalIllnessController = TextEditingController();
    _backgroundController = TextEditingController();
  }

  void _formSubmit(){
    var _form = _formKey.currentState;
    if(_form.validate()){
      _form.save();
      print(_personalDescription);
      _backgroundStory.personalDescription = _personalDescription;
//      _backgroundStory.personalDescription = "1";
      _backgroundStory.faith = _faith;
      _backgroundStory.importantPeople = _importantPeople;
      _backgroundStory.extraPlace = _extraPlace;
      _backgroundStory.precious = _precious;
      _backgroundStory.features = _features;
      _backgroundStory.wound = _wound;
      _backgroundStory.mentalIllness = _mentalIllness;
      _backgroundStory.background = _background;
      _investigator.backgroundStory = _backgroundStory;

      Provider
          .of<CreateInvestigatorStore>(context,listen: false)
          .investigator = _investigator;
      print(_backgroundStory.personalDescription);
    }
  }


  Widget buildInputContainer(Widget inputWidget){
    return Container(
      margin: EdgeInsets.only(top:10),
      child: inputWidget,
    );
  }

  Widget buildItemTitle(String itemTitle,double width){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top:20),
      color: Colors.black54,
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      constraints: BoxConstraints(
        maxWidth: width,
      ),
      child:Text(
        itemTitle,
        style: TextStyle(
            fontSize:20,
            color: Colors.white
        ),
      ) ,
    );
  }

  Widget buildMainListWidget(){
    return Container(
      child: ListView(
          children: <Widget>[
            CreateTitleWidget(
              title: "背景故事",
              description: "希望你们的调查员是个正常人",
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
//                      color: Colors.red,
              alignment: Alignment.center,
              constraints: BoxConstraints(
                  maxWidth: 100
              ),
              child: Form(
                key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildItemTitle("个人描述",140,),
                      buildInputContainer(
                          NormalInputField(
                            hintText: "外貌描述",

                            controller: _personalDescriptionController,
                            validatorFunction: (v){

                            },
                            onSavedFunction: (v){
                              _personalDescription = v;
                            },
                          )
                      ),
                      buildItemTitle("思想/信念",150),
                      buildInputContainer(
                          NormalInputField(
                            hintText: "神祇、思想、信念",
                            controller: _faithController,
                            validatorFunction: (v){

                            },
                            onSavedFunction: (v){
                              _faith = v;
                            },
                          )
                      ),
                      buildItemTitle("重要之人",140),
                      buildInputContainer(
                          NormalInputField(
                            hintText: "家人、爱人、朋友或敌人",
                            controller: _importantPeopleController,
                            validatorFunction: (v){

                            },
                            onSavedFunction: (v){
                              _importantPeople = v;
                            },
                          )
                      ),
                      buildItemTitle("意义非凡之地",180),
                      buildInputContainer(
                          NormalInputField(
                            hintText: "人生转折点/相约之处",
                            controller: _extraPlaceController,
                            validatorFunction: (v){

                            },
                            onSavedFunction: (v){
                              _extraPlace = v;
                            },
                          )
                      ),
                      buildItemTitle("宝贵之物",140),
                      buildInputContainer(
                          NormalInputField(
                            hintText: "听说你有一个神秘护符？",
                            controller: _preciousController,
                            validatorFunction: (v){

                            },
                            onSavedFunction: (v){
                              _precious = v;
                            },
                          )
                      ),
                      buildItemTitle("特点",140),
                      buildInputContainer(
                          NormalInputField(
                            hintText: "特点不只有外貌吧",
                            controller: _featuresController,
                            validatorFunction: (v){

                            },
                            onSavedFunction: (v){
                              _features = v;
                            },
                          )
                      ),
                      buildItemTitle("伤疤",140),
                      buildInputContainer(
                          NormalInputField(
                            hintText: "有的人说伤疤是勋章",
                            controller: _woundController,
                            validatorFunction: (v){

                            },
                            onSavedFunction: (v){
                              _wound = v;
                            },
                          )
                      ),
                      buildItemTitle("恐惧症/狂躁症",200),
                      buildInputContainer(
                          NormalInputField(
                            hintText: "请出示诊断书",
                            controller: _mentalIllnessController,
                            validatorFunction: (v){

                            },
                            onSavedFunction: (v){
                              _mentalIllness = v;
                            },
                          )
                      ),
                      buildItemTitle("背景故事",140),
                      buildInputContainer(
                          NormalInputField(
                            hintText: "写下调查员的经历吧",
                            maxLine: 6,
                            controller:_backgroundController,
                            validatorFunction: (v){

                            },
                            onSavedFunction: (v){
                              _background = v;
                            },
                          )
                      ),

                      Container(
                        margin: EdgeInsets.only(top:20,bottom: 20),
                        child: NextStepButton(
                          text: "完成创建",
                          onPressFunction:() {

                            _formSubmit();
                           var data = Provider
                               .of<CreateInvestigatorStore>(context,listen: false).investigator;
                           var jsonData = data.dataToJson();
                           Storage storage = Storage("/"+data.name+".json");
                           storage.writeFile(json.encode(jsonData));
                           print(jsonData);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>HomePage()
                                )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
              ),
            ),
          ]
      ),
    );
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
            body:buildMainListWidget()
        )
    );
  }
  
}


