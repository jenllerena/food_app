import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class Modifiers extends StatefulWidget {
  @override
  _Modifiers createState() => _Modifiers();
}

class _Modifiers extends State<Modifiers>{
  TextEditingController groupNameController =  TextEditingController();
  TextEditingController orderTypeController =  TextEditingController();
  TextEditingController modifierNameController =  TextEditingController();
  TextEditingController optionController =  TextEditingController();
  TextEditingController priceController =  TextEditingController();
  QuerySnapshot  dataSnapshot;
  final db = Firestore.instance;

  void saveData() async{
    print(optionController.text);
    await db.collection('modifiers').add({
      'groupName':groupNameController.text,
      'orderType':orderTypeController.text,
      'modifierName':modifierNameController.text,
      'optionName':(optionController != null || optionController.text != "") ? "r":"Regular",
      'price':(priceController != null || priceController.text != "") ? priceController.text : "0.0",
    });
  }
  getData()async{
    return await Firestore.instance.collection('modifiers').getDocuments();
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
              Container(padding: EdgeInsets.symmetric(horizontal: 5),
                child:Text("MODIFIERS",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700))
              ),
              Container(//padding: EdgeInsets.all(10),
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
                              Text("  Search by modifiers...   ",style: TextStyle(color: Colors.grey),)
                            ])
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child:Container(
                          child: FlatButton(shape:RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15)) ,
                            color: Color(0xffE52897),
                            onPressed: (){showCustomDialog(context);},
                            child: Text("+ ADD NEW MODIFIER",style: TextStyle(color: Colors.white),),
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
                        stream: Firestore.instance.collection('modifiers').orderBy('modifierName').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) return CircularProgressIndicator();
                            return Column(mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      color: Color(0xFFC6BFC3),
                                      padding: EdgeInsets.all(10),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(child:Text("MODIFIER NAME",textAlign: TextAlign.center, style: TextStyle(fontSize: 10))),
                                            Expanded(child:Text("TYPE",textAlign: TextAlign.center,style: TextStyle(fontSize: 10))),
                                            Expanded(child:Text("PRICE",textAlign: TextAlign.center,style: TextStyle(fontSize: 10)))
                                          ]
                                      )
                                  ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column( children:<Widget>[
                                      for (int i= 0; i< snapshot.data.documents.length;i++)
                                        Row(crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Expanded(child:
                                            Container(
                                                padding: EdgeInsets.symmetric(vertical: 8),
                                                child: Text(
                                                    '${snapshot.data.documents[i].data['modifierName']}',
                                                    style: TextStyle(fontSize: 10),
                                                    textAlign: TextAlign.center)
                                            )
                                            ),
                                            Expanded(
                                                child: Container(
                                                    child: Text(
                                                        '${snapshot.data.documents[i].data['orderType']}',
                                                        style: TextStyle(fontSize: 10),
                                                        textAlign: TextAlign.center
                                                    ))
                                            ),
                                            Expanded(
                                                child: Container(
                                                    child: Center(child: Text(
                                                        '${snapshot.data.documents[i].data['price']}',
                                                        style: TextStyle(fontSize: 10),
                                                        textAlign: TextAlign.center
                                                    )))
                                            )
                                          ],
                                        ),
                                      Divider()
                                    ],
                                    ),
                                  )
                                )
                                ]
                            );
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
                          child:  Container(
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
                              child: Text("ADD MODIFIER",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700)))],),
                          Row(children: <Widget>[
                            Text("MODIFIER GROUP",
                              style: TextStyle(color: Color(0xffE52897),fontSize: 12,fontWeight: FontWeight.bold))],),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: Wrap(
                                    children: <Widget>[
                                      Text("MODIFIER GROUP NAME",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey[300]),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: TextFormField(
                                          controller: groupNameController,
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
                          Row(children: <Widget>[
                            Container(margin: EdgeInsets.only(top: 10),
                                child:
                                Text("ORDER TYPE APPLICABLE",
                                    style: TextStyle(color: Color(0xffE52897),fontSize: 12,fontWeight: FontWeight.bold)))
                          ],),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: Wrap(
                                    children: <Widget>[
                                      Text("ORDER TYPE TAG",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey[300]),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: TextFormField(
                                          controller: orderTypeController,
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
                          Row(
                            children: <Widget>[
                              Container(margin: EdgeInsets.only(top: 10),
                                  child: Text("MODIFIER INFORMATION",
                                      style: TextStyle(color: Color(0xffE52897),fontSize: 12,fontWeight: FontWeight.bold)))
                            ],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: Wrap(
                                    children: <Widget>[
                                      Text("MODIFIER NAME",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey[300]),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: TextFormField(
                                          controller: modifierNameController,
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
                              ])
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