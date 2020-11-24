import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instaApp/widgets/HeaderWidget.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  final _ScaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String userName;

  submitUserName(){
      final form = _formKey.currentState;
      if(form.validate()){
        form.save();

        SnackBar snackBar = SnackBar(content:Text("Welcome "+ userName) );
        _ScaffoldKey.currentState.showSnackBar(snackBar);
        Timer(Duration(seconds: 4),(){
          Navigator.pop(context,userName);
        });

      }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _ScaffoldKey,
      appBar: header(context,strTitle: "Settings",disappearedBackButton: true),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 26.0),
                  child: Center(
                    child: Text("Set Up a UserName", style: TextStyle(fontSize: 26.0),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(17.0),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      autovalidate: true,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (val){
                          if(val.trim().length<5 || val.isEmpty){
                                return "user name is very Short";
                          } else if(val.trim().length<15 || val.isEmpty) {
                            return "user name is very long";
                          }else{
                            return null;
                          }
                      },
                       onSaved: (val) => userName=val,
                        decoration: InputDecoration(
                          enabledBorder:UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white
                            )
                          ) ,
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 16.0),
                          hintText: "must be atleast 5 characters",
                          hintStyle: TextStyle(color: Colors.grey)
                        ),

                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: submitUserName,
                  child: Container(
                    height: 55.0,
                    width: 360.0,
                    decoration: BoxDecoration(
                      color: Colors.lightGreenAccent,
                      borderRadius: BorderRadius.circular(8.0),

                    ),
                    child: Container(
                      child: Center(
                        child: Text(
                          "Submit" ,
                          style: TextStyle(
                            color:Colors.white ,
                            fontSize: 16.0,
                            fontWeight:FontWeight.bold
                        ),
                        ),

                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
