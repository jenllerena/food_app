import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class Schedules extends StatefulWidget {
  @override
  _Schedules createState() => _Schedules();
}

class _Schedules extends State<Schedules>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(15),
        child:Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Container(padding: EdgeInsets.symmetric(horizontal: 5),
              child:Text("SCHEDULES",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700))
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 90,
                    padding: EdgeInsets.fromLTRB(10, 8, 8, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    margin: EdgeInsets.all(10),
                    child: Wrap(children: <Widget>[
                      Text("Job type",style: TextStyle(color: Colors.grey),)
                    ])
                ),
                Container(
                  child: FlatButton(shape:RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15)) ,
                    color: Color(0xffE52897),
                    onPressed: (){showCustomDialog(context);},
                    child: Text("+ ADD NEW SHIFT",style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            )
        ]
        )

    );
  }
  void showCustomDialog(BuildContext context){
    Dialog fancyDialog = Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          height: MediaQuery.of(context).size.height,
          width: 600.0,
          child: Column(mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[700]),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(border: Border.all(),
                                //borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child:  Container(
                                height: 25, width: 80,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5),
                                child: MaterialButton(onPressed: () {Navigator.pop(context);},
                                    elevation: 10,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2),
                                    child: Text("DONE", style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                    color: Color(0xff17AF7E),
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius
                                          .circular(20),
                                    ))
                            )
                        )
                      ],
                    )
                ),
                Container(
                  width: double.maxFinite,
                  height: 290,
                  padding: EdgeInsets.all(20),
                  child:SingleChildScrollView(
                      child: Column(//shrinkWrap: true,
                          children: <Widget>[
                            Row(children: <Widget>[Padding(padding: EdgeInsets.only(bottom: 10),
                                child: Text("ADD SHIF",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700)))],),
                            Row(children: <Widget>[
                              Text("NAME",
                                  style: TextStyle(color: Color(0xffE52897),fontSize: 12,fontWeight: FontWeight.bold))],),

                            Row(children: <Widget>[
                              Container(margin: EdgeInsets.only(top: 10),
                                  child:
                                  Text("SHIFT",
                                      style: TextStyle(color: Color(0xffE52897),fontSize: 12,fontWeight: FontWeight.bold)))
                            ],),

                            Row(
                              children: <Widget>[
                                Container(margin: EdgeInsets.only(top: 10),
                                    child: Text("MODIFIER INFORMATION",
                                        style: TextStyle(color: Color(0xffE52897),fontSize: 12,fontWeight: FontWeight.bold)))
                              ],
                            ),
                          ]
                      )

                  ),

                )
              ]
          ),)
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }
}