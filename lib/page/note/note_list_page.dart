import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/model/Note.dart';
import 'package:coc_trpg/utils/config.dart';

class NoteListPage extends StatefulWidget{
  NoteListPage({Key key}): super(key: key);

  @override
  _NoteListPage createState() => _NoteListPage();

}


class _NoteListPage extends State<NoteListPage>{

  //获得note的方法是investigator的HTTP请求
  List<Investigator> _investigatorList = List();
  List<Widget> _noteWidgetList = List();

  @override
  void initState(){
    super.initState();
    buildTestData();
  }

  void buildTestData(){
    for(int i=0;i<3;i++){
      Investigator investigator = Investigator();
      investigator.name = "空调承太郎$i";
      Note note = Note();
      note.name = "杜王町的杀人魔";
      investigator.noteList.add(note);
      _investigatorList.add(investigator);

    }
    for(var investigator in _investigatorList){
      for(var note in investigator.noteList){
        _noteWidgetList.add(buildNoteWidget(investigator.name, note));
      }
    }
  }

  Widget buildNoteWidget(String investigatorName,Note note){
    return  Container(
      margin: EdgeInsets.fromLTRB(15,15,15,0),
      constraints: BoxConstraints(
          maxWidth:180,
          maxHeight: 400
      ),
      decoration: BoxDecoration(
          color: Color(0x22000000)
      ),
      child: ListTile(
        title: Text(note.name,style: TextStyle(fontSize: 25),),
        subtitle: Text(investigatorName,style: TextStyle(fontSize: 20),),
        onTap: (){
          print("hell");
        },
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
      child:Scaffold(
        backgroundColor: Colors.transparent,
        appBar:  AppBar(
          title: Container(
            alignment: Alignment.center,
            child: Text("调查笔记"),
          ),
          backgroundColor: Color(0x22000000),
          elevation: 0,
        ),
        body: ListView(
          shrinkWrap: true,
          children: _noteWidgetList,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:FloatingActionButton(
          backgroundColor: AppConfig.investigatorMainColor,
          child: Icon(Icons.add,color: Colors.white,),
        ) ,
      ) ,
    );
  }

}


