import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class GuestBook extends StatefulWidget {
  @override
  _GuestBook createState() => _GuestBook();
}

class _GuestBook extends State<GuestBook>{
  TextEditingController categoryNameController =  TextEditingController();
  TextEditingController courseNameController =  TextEditingController();
  TextEditingController categoryPositionController =  TextEditingController();
  TextEditingController coursePositionController =  TextEditingController();
  TextEditingController menuDisplayController =  TextEditingController();
  TextEditingController parentCategoryController =  TextEditingController();
  QuerySnapshot  dataSnapshot;
  final db = Firestore.instance;
  void saveData() async{print(categoryNameController.text);
  await db.collection('categories').add({
    'categoryName':categoryNameController.text,
    'courseName':courseNameController.text,
    'categoryPosition':categoryPositionController.text,
    'coursePosition':coursePositionController.text,
    'menuDisplay':menuDisplayController.text,
    'parentCategory':parentCategoryController.text,
  });
  }
  getData()async{
    return await Firestore.instance.collection('categories').getDocuments();
  }

  @override
  void initState(){
    super.initState();
    getData().then(
            (results){
          setState(() {
            dataSnapshot = results;
          });
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(//color: Colors.green,
        padding: EdgeInsets.all(15),
        child:Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("GUEST BOOK",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700)),
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
                              Text("  Search...              ",style: TextStyle(color: Colors.grey),)
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
                            child: Text("+ ADD NEW GUEST",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      )
                    ]
                ),
              ),
              Expanded(
                child:Container(
                    padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                    child: StreamBuilder(
                        stream: Firestore.instance.collection('categories').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if(dataSnapshot != null){
                            return Table(
                                border: TableBorder.all(color: Color(0xFFC6BFC3)),
                                children: [
                                  TableRow(
                                      children: [
                                        Container(padding:EdgeInsets.all(10),color: Color(0xFFC6BFC3),child: Text("NAME",style: TextStyle(fontSize: 10),textAlign: TextAlign.center,)),
                                        Container(padding:EdgeInsets.all(10),color:Color(0xFFC6BFC3),child: Text("PHONE NUMBER",textAlign: TextAlign.center,style: TextStyle(fontSize: 10))),
                                        Container(padding:EdgeInsets.all(10),color:Color(0xFFC6BFC3),child: Text("EMAIL",textAlign: TextAlign.center,style: TextStyle(fontSize: 10))),
                                        Container(padding:EdgeInsets.all(10),color:Color(0xFFC6BFC3),child: Text("ADDRESS",textAlign: TextAlign.center,style: TextStyle(fontSize: 10)))
                                      ]
                                  ),
                                  for (int i= 0; i< dataSnapshot.documents.length;i++)
                                    TableRow(
                                        children: [
                                          Container(padding: EdgeInsets.all(10),
                                              child: Center(child: Text(
                                                  '${dataSnapshot.documents[i]
                                                      .data['categoryName']}'))),
                                          Container(padding: EdgeInsets.all(10),
                                              child: Center(child: Text(
                                                  '${dataSnapshot.documents[i]
                                                      .data['parentCategory']}'
                                              ))),
                                          Container(padding: EdgeInsets.all(10),
                                              child: Center(child: Text(
                                                  '${dataSnapshot.documents[i]
                                                      .data['cousePosition']}'))),
                                          Container(padding: EdgeInsets.all(10),
                                              child: Center(child: Text(
                                                  '${dataSnapshot.documents[i]
                                                      .data['categoryName']}')))
                                        ]
                                    )
                                ]
                            );
                          }else{
                            return Text("Loading..");
                          }
                        })
                ) ,
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
                          child: Container(
                              height: 25, width: 80,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5),
                              child: MaterialButton(onPressed: () {saveData();Navigator.pop(context);},
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
                              child: Text("ADD A GUEST",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700)))],),
                          Row(children: <Widget>[Text("GUEST INFORMATION",
                              style: TextStyle(color: Color(0xffE52897),fontSize: 12,fontWeight: FontWeight.bold))],),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(child:
                                Container(margin: EdgeInsets.fromLTRB(0, 8, 15, 0),
                                    child: Wrap(
                                      children: <Widget>[
                                        Text("FIRST NAME",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey[300]),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: TextFormField(controller: categoryNameController,
                                            style: TextStyle(fontSize: 12),
                                            decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                hintText:'First name' ,
                                                border: InputBorder.none
                                            ),
                                          ),
                                        )
                                      ],
                                    ))),
                                Expanded(child:
                                Container(margin: EdgeInsets.fromLTRB(15, 8, 0, 0),
                                    child: Wrap(
                                      children: <Widget>[
                                        Text("LAST NAME",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                        Container(
                                          //margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey[300]),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: TextFormField(
                                            controller: courseNameController,
                                            style: TextStyle(fontSize: 12),
                                            decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                hintText:'Last name' ,
                                                border: InputBorder.none
                                            ),
                                          ),
                                        )
                                      ],
                                    ))),
                              ]),
                          Row(children: <Widget>[
                            Expanded(child:
                            Container(margin: EdgeInsets.fromLTRB(0, 8, 15, 0),
                                child: Wrap(
                                  children: <Widget>[
                                    Text("CATEGORY POSITION",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                    Container(
                                      padding:EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey[300]),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: TextFormField(controller: categoryPositionController,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                            hintText:'Category Position' ,
                                            border: InputBorder.none
                                        ),
                                      ),
                                    )
                                  ],
                                ))),
                            Expanded(child:
                            Container(margin: EdgeInsets.fromLTRB(15, 8, 0, 0),
                                child: Wrap(
                                  children: <Widget>[
                                    Text("COURSE POSITION",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                    Container(
                                      //margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey[300]),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: TextFormField(
                                        controller: coursePositionController,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                            hintText:'Course Position' ,
                                            border: InputBorder.none
                                        ),
                                      ),
                                    )
                                  ],
                                ))),
                          ]),
                          Divider(color: Color(0xffE52897)),
                          Row(children: <Widget>[
                            Expanded(
                              child: Wrap(
                                children: <Widget>[
                                  Text("MENU DISPLAY NAME",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey[300]),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: TextFormField(
                                      controller: menuDisplayController,
                                      style: TextStyle(fontSize: 12),
                                      decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                          hintText:'Menu display name' ,
                                          border: InputBorder.none
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: Wrap(
                                    children: <Widget>[
                                      Text("PARENT CATEGORY",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey[300]),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: TextFormField(
                                          controller: parentCategoryController,
                                          style: TextStyle(fontSize: 12),
                                          decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                              hintText:'Select a Parent Category' ,
                                              border: InputBorder.none
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ]),
                        ],
                      )
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