import 'package:eatos_app/screens/staff/employees.dart';
import 'package:eatos_app/screens/staff/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eatos_app/screens/profilePage.dart';
import 'package:eatos_app/screens/menuPage.dart';
import 'package:eatos_app/screens/menu/categories.dart';
import 'package:eatos_app/screens/menu/modifiers.dart';
import 'package:eatos_app/screens/menu/add-ons.dart';
import 'package:eatos_app/screens/guestBook.dart';

import 'menu/products.dart';

class Settings extends StatefulWidget{
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings>{
  List<String> _list = ["General", "My Profile", "End of day", "Guestbook", "Menu","Categories","Modifiers",
    "Add-Ons","Products","Ingredients","Groups", "Employee","Schedule", "Gratuity","Taxes","Discounts",
    "Service Charge","Card Reader","Cash Managment","Payment Options", "Server","Printers","Cash Register","Printer Advanced"
  ];
  List<Widget> _listScreens = [PageGeneral(),ProfilePage(),EndDay(),GuestBook(),MenuPage(),Categories(),Modifiers(),AddOns(),Products(),Menu(),
    Menu(),Employees(),Schedules(),Menu(),Menu(),Menu(),Service(),Menu(),Menu(),Menu(),Menu(),Menu(),Menu(),Menu()];
  int checkIndex = 0;
  List<bool> isSelected = [true,false,false,false,false];
  void indexChecked(int i) {
    print(checkIndex);
    print(i);
    if (checkIndex == i) return;
    setState(() {
      checkIndex = i;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Row(
          children: <Widget>[
            Container(height: MediaQuery.of(context).size.height,
              width: 110,
              color: Color(0xff565962),
              child: ListView(
                children: <Widget>[

                  ExpansionTile(
                    title: FittedBox(fit: BoxFit.fitWidth,child: Text("RESTAURANT",style: TextStyle(color: Colors.white))),
                    trailing: Icon(Icons.chevron_left,color: Colors.white),
                    //backgroundColor: Colors.yellow,
                    children: [
                      Column(children:[
                        Container(color: Colors.white,
                          child:Column(
                          children: <Widget>[
                            for (int i = 0; i < 4; i++)
                              GestureDetector(
                                onTap: (){indexChecked(i);},
                                child: TextTab(_list[i],checkIndex == i)
                              ),
                          ],
                        )
                        )
                      ])
                    ],
                  ),
                  ExpansionTile(
                      title: Text("MENU",style: TextStyle(color: Colors.white, fontSize: 10)),
                      trailing: Icon(Icons.chevron_left,color: Colors.white,),
                      //backgroundColor: Colors.yellow,
                      children: [
                        Column(children:[
                          Container(color: Colors.white,
                              child:Column(
                                children: <Widget>[
                                  for (int i = 4; i < 11; i++)
                                    GestureDetector(
                                        onTap: (){indexChecked(i);},
                                        child: TextTab(_list[i],checkIndex == i)
                                    ),
                                ],
                              )
                          )
                        ]
                        )
                      ],
                  ),
                  ExpansionTile(
                    title: Text("STAFF",style: TextStyle(color: Colors.white, fontSize: 10)),
                    trailing: Icon(Icons.chevron_left,color: Colors.white,),
                    //backgroundColor: Colors.yellow,
                    children: [
                      Column(children:[
                        Container(color: Colors.white,
                            child:Column(
                              children: <Widget>[
                                for (int i = 11; i < 13; i++)
                                  GestureDetector(
                                      onTap: (){indexChecked(i);},
                                      child: TextTab(_list[i],checkIndex == i)
                                  ),
                              ],
                            )
                        )
                      ])
                    ],
                  ),
                  ExpansionTile(
                    title: FittedBox(fit: BoxFit.fitWidth,child: Text("PAYMENT",style: TextStyle(color: Colors.white))),
                    trailing: Icon(Icons.chevron_left,color: Colors.white,),
                    //backgroundColor: Colors.yellow,
                    children: [
                      Column(children:[
                        Container(color: Colors.white,
                            child:Column(
                              children: <Widget>[
                                for (int i = 13; i < 20; i++)
                                  GestureDetector(
                                      onTap: (){indexChecked(i);},
                                      child: TextTab(_list[i],checkIndex == i)
                                  ),
                              ],
                            )
                        )
                      ])
                    ],
                  ),
                  ExpansionTile(
                    title: FittedBox(fit: BoxFit.fitWidth,child: Text("ADVANCED",style: TextStyle(color: Colors.white))),
                    trailing: Icon(Icons.chevron_left,color: Colors.white,),
                    //backgroundColor: Colors.yellow,
                    children: [
                      Column(children:[
                        Container(color: Colors.white,
                            child:Column(
                              children: <Widget>[
                                for (int i = 20; i < _list.length; i++)
                                  GestureDetector(
                                      onTap: (){indexChecked(i);},
                                      child: TextTab(_list[i],checkIndex == i)
                                  ),
                              ],
                            )
                        )
                      ])
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: _listScreens[checkIndex],
            )
          ],
        ),
      ),
    );
  }
}
class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;
  NewItem({this.isExpanded=false, this.header, this.body, this.iconpic});
}
class TextTab extends StatelessWidget {
  String name;
  //GlobalKey globalKey;
  bool checked;
  TextTab(this.name,  this.checked);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 25,
        padding: EdgeInsets.fromLTRB(10, 0, 5, 0) ,
        key: GlobalKey(),
        decoration: BoxDecoration(
          color: checked ? Color(0xffE52897) : Colors.white,
        ),
        child: Align(alignment: Alignment.centerLeft,
          child: Text(name,textAlign: TextAlign.left,style:
          TextStyle(color: checked ? Colors.white : Colors.black,fontSize: 10)),
        )
    );
  }
//quarterTurns: 3,
}
class PageGeneral extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 10,top:20),child: Text("GENERAL",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700))),
          Padding(padding: EdgeInsets.only(left: 10,top:15,),child:
            Text("RESTAURANT INFORMATION",style:TextStyle(color: Color(0xffE52897),fontSize:9,fontWeight: FontWeight.w500),)),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(margin: EdgeInsets.all(10),
                      child: Wrap(
                        children: <Widget>[
                          Text("RESTAURANT NAME",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                          Container(
                            //margin: EdgeInsets.all(5),
                            padding: EdgeInsets.only(left:10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(18)
                            ),
                            child: TextFormField(style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  hintText:'Red Chillies' ,
                                  border: InputBorder.none
                              ),
                            ),
                          )
                        ],
                      ))
              ),
              Expanded(child: Container(margin: EdgeInsets.all(10),
                  child: Wrap(
                    children: <Widget>[
                      Text("RESTAURANT TYPE",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                      Container(
                        //margin: EdgeInsets.all(5),
                        padding: EdgeInsets.only(left:10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(18)
                        ),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText:'Restaurant System' ,
                              border: InputBorder.none
                          ),
                        ),
                      )
                    ],
                  ))
              )
            ],
          ),
          Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Wrap(
                children: <Widget>[
                  Text("RESTAURANT BIO",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                  Container(
                    //margin: EdgeInsets.all(5),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(18)
                    ),
                    child: TextFormField(
                      style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                          hintText:'Enter a brief bio about your restaurant.' ,
                          border: InputBorder.none
                      ),
                    ),
                  )
                ],
              )),
          Container(margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Wrap(
                children: <Widget>[
                  Text("RESTAURANT EMAIL",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                  Container(
                    //margin: EdgeInsets.all(5),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(18)
                    ),
                    child: TextFormField( style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5),
                          hintText:'Email' ,
                          border: InputBorder.none
                      ),
                    ),
                  )
                ],
              )),
          Container(margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Wrap(
                children: <Widget>[
                  Text("ADDRESS",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                  Container(
                    //margin: EdgeInsets.all(5),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(18)
                    ),
                    child: TextFormField(style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5),
                          hintText:'Address' ,
                          border: InputBorder.none
                      ),
                    ),
                  )
                ],
              )),
          Row(children: <Widget>[
            Expanded(child:
            Container(margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Wrap(
                  children: <Widget>[
                    Text("CITY",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                    Container(
                      //margin: EdgeInsets.all(5),
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18)
                      ),
                      child: TextFormField(
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(contentPadding: EdgeInsets.all(5),
                            hintText:'M' ,
                            border: InputBorder.none
                        ),
                      ),
                    )
                  ],
                ))),
            Expanded(child:
              Container(margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Wrap(
                    children: <Widget>[
                      Text("STATE",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                      Container(
                        //margin: EdgeInsets.all(5),
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(18)
                        ),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(contentPadding: EdgeInsets.all(5),
                              hintText:'M' ,
                              border: InputBorder.none
                          ),
                        ),
                      )
                    ],
                ))),
            Expanded(child:
            Container(margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Wrap(
                  children: <Widget>[
                    Text("ZIP CODE",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                    Container(
                      //margin: EdgeInsets.all(5),
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18)
                      ),
                      child: TextFormField(
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(contentPadding: EdgeInsets.all(5),
                            hintText:'M' ,
                            border: InputBorder.none
                        ),
                      ),
                    )
                  ],
                )))
          ],),
          Divider(color: Color(0xffE52897),),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text("SCHEDULE INFORMATION",style: TextStyle(color: Color(0xffE52897),fontSize: 12),),
              ),
              Align(
                alignment: Alignment.centerRight,
                child:Container(
                child: FlatButton(shape:RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15),
                  ) ,
                  color: Color(0xffE52897),
                  onPressed: (){},
                  child: Text("+ ADD A NEW SCHEDULE",style: TextStyle(color: Colors.white),),
                  ),
                  ))
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
            child: Table(
              border: TableBorder.symmetric(outside:BorderSide(color:Colors.grey[200]) ),
              children: [
                TableRow(
                    children: [
                      Container(padding:EdgeInsets.all(10),color: Color(0xFFC6BFC3),child: Text("SCHEDULE NAME",style: TextStyle(fontSize: 10),textAlign: TextAlign.center,)),
                      Container(padding:EdgeInsets.all(10),color:Color(0xFFC6BFC3),child: Text("DURATION",textAlign: TextAlign.center,style: TextStyle(fontSize: 10))),
                      Container(padding:EdgeInsets.all(10),color:Color(0xFFC6BFC3),child: Text("DAYS",textAlign: TextAlign.center,style: TextStyle(fontSize: 10)))
                    ]
                ),
                TableRow(
                    children: [
                      Container(padding:EdgeInsets.all(10),child: Center(child: Text("TestSchedule")),),
                      Container(padding:EdgeInsets.all(10),child: Center(child: Text("02/10/2020"))),
                      Container(padding:EdgeInsets.all(10),child: Center(child: Text("Mondays, Tuesday")))
                    ]
                ),
              ],
            ),
          ),
          Divider(color: Color(0xffE52897),),
        ],
      ),
    );
  }
}

class EndDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
           Row(children: <Widget>[Padding(padding: EdgeInsets.only(bottom: 10),child: Text("END OF DAY",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700)))],),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(alignment: Alignment.centerLeft,
                    child: Text("START END OF DAY",style: TextStyle(color: Color(0xffE52897),fontSize: 10,fontWeight: FontWeight.bold)),
                  ),
                  Align(alignment: Alignment.centerRight,
                      child:FlatButton(onPressed: (){showCustomDialog(context);}, child: Text("START END OF DAY"),color: Color(0xffE52897),textColor: Colors.white,
                          shape:RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10),
                          ))
                  )
                ]),
            Divider(color: Colors.grey),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(alignment: Alignment.centerLeft,
                    child: Text("AUTOMIC START END OF DAY",style: TextStyle(fontSize: 10))
                  ),
                  Align(alignment: Alignment.centerRight,
                     child: Container(width: 70,height: 35,padding: EdgeInsets.all(0),
                       decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all((Radius.circular(30)))),
                       child: Stack(
                         children: <Widget>[
                           Align( alignment: Alignment.centerRight,
                            child: Container(
                             width: 35,height: 35,
                              decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                           ),
                         )],
                       ),
                     )
                  )
                ]),
            Divider(color: Colors.grey),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(alignment: Alignment.centerLeft,
                      child: Text("START END OF DAY",style: TextStyle(fontSize: 10))
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child:
                      Container(width: 85,height: 25,padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                        child: Stack(
                          children: <Widget>[
                            Align( alignment: Alignment.centerRight,
                              child: Container(
                                width: 40,height: 25,
                                decoration: BoxDecoration(color: Colors.grey,
                                border:Border(
                                  left: BorderSide(color: Colors.black)
                                ),//borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight: Radius.circular(30))
                                ),child: Icon(Icons.history)
                              ),
                            )],
                        ),
                      )
                  )
                ]),
            Divider(color: Color(0xffE52897)),
            Text("AUTOMATIC TASKS",style: TextStyle(color: Color(0xffE52897),fontSize: 10,fontWeight: FontWeight.bold)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(alignment: Alignment.centerLeft,
                      child: Text("AUTOMIC RUN END OF DAY TASKS",style: TextStyle(fontSize: 10))
                  ),
                  Align(alignment: Alignment.centerRight,
                      child: Container(width: 70,height: 35,padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all((Radius.circular(30)))),
                        child: Stack(
                          children: <Widget>[
                            Align( alignment: Alignment.centerRight,
                              child: Container(
                                width: 35,height: 35,
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                              ),
                            )],
                        ),
                      )
                  )
                ]),
            Divider(color: Colors.grey),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(alignment: Alignment.centerLeft,
                      child: Text("RUN TASKS AT",style: TextStyle(fontSize: 10))
                  ),
                  Align(alignment: Alignment.centerRight,
                      child: Container(width: 70,height: 35,padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all((Radius.circular(30)))),
                        child: Stack(
                          children: <Widget>[
                            Align( alignment: Alignment.centerRight,
                              child: Container(
                                width: 35,height: 35,
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                              ),
                            )],
                        ),
                      )
                  )
                ]),
            Divider(color: Colors.grey),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(alignment: Alignment.centerLeft,
                      child: Text("CLOCK OUT EMPLOYEES",style: TextStyle(fontSize: 10))
                  ),
                  Align(alignment: Alignment.centerRight,
                      child: Container(width: 70,height: 35,padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all((Radius.circular(30)))),
                        child: Stack(
                          children: <Widget>[
                            Align( alignment: Alignment.centerRight,
                              child: Container(
                                width: 35,height: 35,
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                              ),
                            )],
                        ),
                      )
                  )
                ]),
            Divider(color: Colors.grey),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(alignment: Alignment.centerLeft,
                      child: Text("CLOSE DRAWERS",style: TextStyle(fontSize: 10))
                  ),
                  Align(alignment: Alignment.centerRight,
                      child: Container(width: 70,height: 35,padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all((Radius.circular(30)))),
                        child: Stack(
                          children: <Widget>[
                            Align( alignment: Alignment.centerRight,
                              child: Container(
                                width: 35,height: 35,
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                              ),
                            )],
                        ),
                      )
                  )
                ]),
            Divider(color: Colors.grey),

            ],
          ),
    );
  }

  void showCustomDialog(BuildContext context){
    Dialog fancyDialog = Dialog(
      child: Container(
          height: 520.0,
          width: 600.0,
          child: Column(mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.grey[700]),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {Navigator.pop(context);},
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                  width: double.maxFinite,
                  //height: 390,
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child:Column(
                    children: <Widget>[
                      Row(children: <Widget>[Padding(padding: EdgeInsets.only(bottom: 10),
                          child: Text("Good Morning!",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700)))],),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
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
                                )
                              ],
                            ))),
                      ]),
                      Container(child: Wrap(direction: Axis.vertical,
                        children: <Widget>[
                          Text("CATEGORIES",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
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
        context: context, builder: (BuildContext context) => fancyDialog);
  }
}
class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(" MENU"),
    );
  }
}

class Service extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(//color: Colors.green,
      padding: EdgeInsets.all(15),
      child:ListView(
        children: <Widget>[
        Text("SERVICE CHARGE",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700)),
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
                        Text("  Search by service              ",style: TextStyle(color: Colors.grey),)
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
                      onPressed: (){},
                      child: Text("+ ADD SERVICE CHARGE",style: TextStyle(color: Colors.white),),
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
                    Container(padding:EdgeInsets.all(10),color: Color(0xFFC6BFC3),child: Text("SERVICE CHARGE NAME",style: TextStyle(fontSize: 10),textAlign: TextAlign.center,)),
                    Container(padding:EdgeInsets.all(10),color:Color(0xFFC6BFC3),child: Text("PERCENTAGE",textAlign: TextAlign.center,style: TextStyle(fontSize: 10)))
                  ]
                ),
                TableRow(
                  children: [
                    Container(padding:EdgeInsets.all(10),child: Center(child: Text("A")),),
                    Container(padding:EdgeInsets.all(10),child: Center(child: Text("10%")))
                  ]
                )
              ],
            ),
          )
    ])
    );
  }
}