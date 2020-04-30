import 'package:flutter/material.dart';
//import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:eatos_app/widgets/new_guest.dart';

class NewOrden extends StatefulWidget{
  @override
  _NewOrden createState() => _NewOrden();
}

class _NewOrden extends State<NewOrden>{
  int checkIndex = 0;
  String itemNum;
  int total = 0;

  updateItem(String text){
    total += int.parse(text);
    setState(() {
      itemNum = text;
    });
  }
  void indexChecked(int i) {
    print(checkIndex);
    print(i);
    if (checkIndex == i) return;
    setState(() {
      checkIndex = i;
    });
  }

  @override
  void initState() {
    checkIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: Color(0xffF7F7F7),
          child:(
              Row(
                children: <Widget>[
                Expanded(flex: 7,
                child: Container(//height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                  child: Column(
                    children: <Widget>[
                          if(checkIndex==0)
                            Expanded(
                              child: customItems(
                                parentAction:updateItem,
                              ),
                            ),
                          if(checkIndex==1)
                            Expanded(child: menuView()),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child:GestureDetector(
                                    onTap: (){indexChecked(0);},
                                    child: TextTab(
                                        "Custom items", GlobalKey(), checkIndex == 0)
                                )),
                            Expanded(child:GestureDetector(
                                onTap: ()=> {indexChecked(1)},
                                child: TextTab(
                                    "Menus", GlobalKey(), checkIndex == 1)
                            )),
                            Expanded(child: Container(
                              margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                              height: 30,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color(0xff565962),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                              ),
                              child: InkWell(//fit: BoxFit.fitWidth,
                                    child: Container(
                                      padding: EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                        border:  Border.all(color:Colors.white),
                                        borderRadius: new BorderRadius.circular(10),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.search,size: 15,color: Colors.white),
                                      ),
                                    ),

                              )
                            )),
                            Expanded(
                                child:Container(
                                    height: 30,
                                    margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Color(0xff565962),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                                    ),
                                    child: Center(
                                      child:FittedBox(fit: BoxFit.fitWidth,
                                          child: Text("Server Connected",
                                              style: TextStyle(color: Colors.green)))
                                      )
                                ))
                          ],),
                      )
                    ],
                  )
                )),
                  Expanded(flex: 3,
                      child: NewGuestView(total,itemNum)
                  )
                ],
              ))
    );
  }
}
class TextTab extends StatelessWidget {
  String name;
  GlobalKey globalKey;
  bool checked;

  TextTab(this.name, this.globalKey, this.checked);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
      padding: EdgeInsets.all(5) ,
      key: globalKey,
      decoration: BoxDecoration(
        color: checked ? Color(0xffE52897) : Color(0xff565962),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),topRight: Radius.circular(5)),
      ),
      child: FittedBox(fit: BoxFit.scaleDown,
        child:Row(
          children: <Widget>[
            Icon(Icons.assignment,color: Colors.white),
            Center(
              child: Text(name,style:TextStyle(color: Colors.white))
            )
          ],
        ))
    );
  }
  //quarterTurns: 3,
}
class customItems extends StatefulWidget{
  final ValueChanged<String> parentAction;
  const customItems({this.parentAction});

  @override
  _customItems createState() => _customItems();
}
class _customItems extends State<customItems> {
  int firstNum, secNum;
  String textDisplay="0";
  String res,operation;

  void btnClicked(String btnText){print(btnText);
    res="";
    //secNum = int.parse(textDisplay);
    if(btnText=="-"){
      if(textDisplay.length == 1){
        res="0";
      }else{
      textDisplay = textDisplay.substring(0, textDisplay.length - 1);
      res = int.parse(textDisplay).toString();}
    }else{
      if(btnText == "+"){
        firstNum = int.parse(textDisplay);
        //print(firstNum);
        widget.parentAction(firstNum.toString());
        res="0";
        operation = btnText;
      }
      else
        res=int.parse(textDisplay+btnText).toString();
    }

      setState((){
        textDisplay=res;
      }
    );
  }

  Widget customButton(String val){
    return Expanded(child:
      Container(height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(5),
        child: OutlineButton(padding: EdgeInsets.all(0),
          onPressed: (){btnClicked(val);},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2)
          ),
          child: Text(
              "$val",
              style: TextStyle(fontSize: 17),textAlign: TextAlign.center
        )))
    );

      /*Column(
      children: <Widget>[
      Expanded(
        child: Container(
          child: OutlineButton(padding: EdgeInsets.all(0),
            onPressed: (){btnClicked(val);},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2)
            ),
            child: Text(
                "$val",
                style: TextStyle(fontSize: 17),textAlign: TextAlign.center
            ),
          ),
        )
      )
      ],
    );*/

  }
  @override
  Widget build(BuildContext context) {
    return Container(//height: MediaQuery.of(context).size.height-60,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          Form(
            child:Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300])
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText:'Item Name' ,
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          Expanded(
            child:
              Container(width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child:
                Row(//shrinkWrap: true,
                    //padding: EdgeInsets.all(10),
                    children: <Widget>[
                      Expanded(flex: 3,
                          child: Column(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      customButton("1"),
                                      customButton("2"),
                                      customButton("3"),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(child:
                                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                                  customButton("4"),
                                  customButton("5"),
                                  customButton("6"),
                                ],
                                ),),
                              Expanded(
                                child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                                  customButton("7"),
                                  customButton("8"),
                                  customButton("9"),
                                ],
                                ),
                              ),
                              Expanded(
                                child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                          flex:7,
                                          child: Container(height: MediaQuery.of(context).size.height,
                                              margin: EdgeInsets.all(5),
                                              child: OutlineButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(2)
                                                ),child:Text('00',
                                                  style: TextStyle(fontSize: 17),textAlign: TextAlign.center),
                                                onPressed: (){},
                                              )
                                          )
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Container(height: MediaQuery.of(context).size.height,
                                              margin: EdgeInsets.all(5),
                                              child: OutlineButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(2)
                                                ),child:Text('0',
                                                  style: TextStyle(fontSize: 17),textAlign: TextAlign.center),
                                                onPressed: (){},
                                              )
                                          )
                                      )
                                    ])
                              )

                            ],
                          )
                      ),
                      Expanded(
                        flex: 1,
                        child:
                         Container(
                            child:
                            Column(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                              Expanded(
                                child: Container(width:MediaQuery.of(context).size.width, //height:90,
                                  margin: EdgeInsets.all(7),
                                  child:OutlineButton(
                                    onPressed: (){btnClicked("-");},
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2)
                                    ),
                                    child:Icon(Icons.arrow_back,color: Colors.red,size: 30)
                                )),
                              ),
                              Expanded(
                                child:Container(width:MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.all(7),
                                  child:OutlineButton(
                                    onPressed: (){btnClicked("+");},
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2)
                                ),
                                    child:Icon(Icons.add,color: Colors.black,size: 30,)
                                )))
                                ],
                              ),
                        ),
                      )
                    ]
                  )
              ),

          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400])
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Custom Amount"),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("$textDisplay",style: TextStyle(fontSize: 18),),
                    )
                  ],
                )
              ),

            ),
          )

        ],
      ),
    );
  }
}
class menuView extends StatelessWidget{
  List<String> menuOptions = <String> ["Gift Card","Service Charge","Add Guest"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(//color: Colors.greenAccent,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Container(//color: Colors.lightBlue,
                  padding: EdgeInsets.all(5),
                  child:OutlineButton(color: Colors.black,
                     onPressed: (){},borderSide: BorderSide(color: Colors.black),
                     child: Text("MENU",
                      style: TextStyle(fontSize: 16),textAlign: TextAlign.center),
                ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(width: 30,height: 30,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color(0xffE52897),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: PopupMenuButton(padding: EdgeInsets.all(2),
                    onSelected: choiceAction,
                    icon: Icon(Icons.more_vert,color:Colors.white,size: 15,),
                    offset: Offset(0,40),
                    itemBuilder: (BuildContext context){
                      return menuOptions.map((option)=>
                          PopupMenuItem(
                            value: option,
                            child: Center(child: Row(
                                children:[Icon(Icons.person),Text(option)])),
                          ),
                      ).toList();
                    },
                  ),
                ),
              )
            ],
          ),
          Container(

          )
        ],
      )

    );
  }
  void choiceAction (String choice){

  }
}