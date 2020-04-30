import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget  {
  TextEditingController menuNameController;
  TextEditingController startTimeController;
  TextEditingController endTimeController;
  String menuName,dates,startTime,endTime;
  @override
  Widget build(BuildContext context) {
    return Container(//color: Colors.green,
        padding: EdgeInsets.all(15),
        child:ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text("MENU",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700))
              ),
              Container(padding: EdgeInsets.all(10),
                child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(10, 8, 8, 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(18)
                            ),
                            margin: EdgeInsets.all(10),
                            child: Wrap(children: <Widget>[
                              Center(child:Icon(Icons.search,size: 15,)),
                              Text("  Search by menu              ",style: TextStyle(color: Colors.grey),)
                            ])
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child:Container(
                          child: FlatButton(shape:RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15),
                          ) ,
                            color: Color(0xffE52897),
                            onPressed: (){showCustomDialog(context);},
                            child: Text("+ ADD NEW MENU",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      )
                    ]
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                child: Table(
                  border: TableBorder.all(color: Color(0xFFC6BFC3)),
                  children: [
                    TableRow(
                        children: [
                          Container(padding:EdgeInsets.all(10),color: Color(0xFFC6BFC3),child: Text("MENU NAME",style: TextStyle(fontSize: 10),textAlign: TextAlign.center,)),
                          Container(padding:EdgeInsets.all(10),color:Color(0xFFC6BFC3),child: Text("STATUS",textAlign: TextAlign.center,style: TextStyle(fontSize: 10))),
                          Container(padding:EdgeInsets.all(10),color:Color(0xFFC6BFC3),child: Text("END DATE",textAlign: TextAlign.center,style: TextStyle(fontSize: 10)))
                        ]
                    ),
                    TableRow(
                        children: [
                          Container(padding:EdgeInsets.all(10),child: Center(child: Text("Menu")),),
                          Container(padding:EdgeInsets.all(10),child: Center(child: Text("Active"))),
                          Container(padding:EdgeInsets.all(10),child: Center(child: Text("2020")))
                        ]
                    ),
                  ],
                ),
              )
            ])
    );
  }
  void showCustomDialog(BuildContext context){
    Dialog fancyDialog = Dialog(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          height: 400.0,
          width: 500.0,
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
                          child: Container(height: 25, width: 80,
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
                  padding: EdgeInsets.all(15),
                  child:
                  ListView(shrinkWrap: true,
                    children: <Widget>[
                      Row(children: <Widget>[Padding(padding: EdgeInsets.only(bottom: 10),
                          child: Text("ADD MENU",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700)))],),
                      Row(children: <Widget>[Text("MENU INFORMATION",style: TextStyle(color: Color(0xffE52897),fontSize: 12,fontWeight: FontWeight.bold))],),
                      Row(children: <Widget>[
                        Expanded(child:
                        Container(margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("MENU NAME",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  //margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: TextFormField(controller: menuNameController,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'menu name' ,
                                        border: InputBorder.none
                                    ),
                                    onChanged: (str){
                                      menuName = menuNameController.text; print(menuName);
                                    },
                                    onSaved: (value)=> menuName = value,
                                  ),
                                )
                              ],
                            ))),
                        Expanded(child:
                        Container(margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("DATES",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  //margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: TextFormField(
                                      style: TextStyle(fontSize: 12),
                                      decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                          hintText:'dates' ,
                                          border: InputBorder.none
                                      ),
                                      onSaved: (value) => dates = value
                                  ),
                                )
                              ],
                            ))),
                      ]),
                      Row(children: <Widget>[
                        Expanded(child:
                        Container(margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("START TIME",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  //margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: TextFormField(controller: startTimeController,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'start Time' ,
                                        border: InputBorder.none
                                    ),
                                    onChanged: (str){
                                      startTime = startTimeController.text; print(startTime);
                                    },
                                    onSaved: (value)=> startTime = value,
                                  ),
                                )
                              ],
                            ))),
                        Expanded(child:
                        Container(margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("END TIME",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  //margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: TextFormField(
                                      style: TextStyle(fontSize: 12),
                                      decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                          hintText:'end time' ,
                                          border: InputBorder.none
                                      ),
                                      onSaved: (value) => endTime = value
                                  ),
                                )
                              ],
                            ))),
                      ]),
                      Row(children: <Widget>[Padding(padding: EdgeInsets.only(bottom: 4,top: 3),
                          child: Text("  KEEP MENU ACTIVE",style:TextStyle(fontSize:12,fontWeight: FontWeight.w500)))],),
                      Divider(color: Color(0xffE52897),),
                      Container(child: Wrap(direction: Axis.vertical,
                        children: <Widget>[
                          Text("WEEK DAYS",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                          Container(width: 470,
                            //margin: EdgeInsets.all(5),
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: DropdownButton(
                              items: [DropdownMenuItem(child: Text("Select"),value: 1)],
                            ),
                          )
                        ],
                      )),
                      Container(child: Wrap(direction: Axis.vertical,
                        children: <Widget>[
                          Text("CATEGORIES",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                          Container(width: 470,
                            //margin: EdgeInsets.all(5),
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: DropdownButton(
                              items: [DropdownMenuItem(child: Text("Select"),value: 1)],
                            ),
                          )
                        ],
                      )),
                    ],
                  )


              ),
            ],
          )
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => SingleChildScrollView(child: fancyDialog));
  }
}