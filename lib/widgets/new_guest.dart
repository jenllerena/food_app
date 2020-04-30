import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class NewGuestView extends StatefulWidget{
  int total;
  String itemNum;
  NewGuestView(this.total,this.itemNum);

  @override
  _NewGuestView createState() => _NewGuestView();
}

class _NewGuestView extends State<NewGuestView>  {

  int checkIndex = 0;
  List<String> _listOptions = ["Dine-In","To-Go","Deliver","Banquet"];
  Widget itemsList(){
    return Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child:  Text("1 custom item "),
            ),
            Align(
              alignment: Alignment.centerRight,
              child:  Text(widget.itemNum),
            )
          ],
        )
    );
  }
  @override
  void initState() {
    checkIndex = 0;
    super.initState();
  }

  void indexChecked(int i) {
    if (checkIndex == i) return;
    setState(() {
      checkIndex = i;
    });
  }

  OptionsL(String name,bool checked,int index){
    return InkWell(
        onTap: () {
          indexChecked(index);
          showCustomDialog(context,index);
        },
        child: Container(
          //padding: EdgeInsets.all(5) ,
            decoration: BoxDecoration(
              color: checked ? Color(0xffE52897) : Colors.white,
              border: Border.all(color: Color(0xffE52897)),
            ),
            child: Center(
              child: Text(name, style: TextStyle(
                  color: checked ? Colors.white : Color(0xffE52897)),),
            )
        )
    );
  }
  Future<void> showCustomDialog(BuildContext context, int index){
    buildOption(String name,bool selected,int index){
      return Container(
          padding: EdgeInsets.symmetric(vertical: 5) ,
          margin: EdgeInsets.symmetric(horizontal: 2) ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: (selected) ? Color(0xffE52897) : Colors.white,
            border: Border.all(color:Colors.grey[200]),
          ),
          child: Center(
            child: Text(name, style: TextStyle(
                color: (selected) ? Colors.white : Color(0xffE52897)),),
          )
      );
    }
    return showDialog(context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                changeIndex(a){
                  print(a);
                  if (index == a) return;
                  setState(() {
                    index = a;
                  });
                }
                return SingleChildScrollView(
                  child: AlertDialog(
                    contentPadding:EdgeInsets.all(0),
                    content:
                    Container( width:600,
                        child:
                        Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: Colors.grey[700]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          decoration: BoxDecoration(border: Border.all(),
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(height: 25, width: 80,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: MaterialButton(onPressed: () {
                                              indexChecked(index);
                                              Navigator.pop(context);},
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
                            Container(width: double.maxFinite,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Column(//mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          for(int j=0;j<_listOptions.length;j++)
                                            Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      changeIndex(j);
                                                    },
                                                    child: buildOption(_listOptions[j],index==j,j) )
                                            )
                                        ]),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 5) ,
                                                  margin: EdgeInsets.all(5) ,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                                    border: Border.all(color:Colors.grey[500]),
                                                  ),
                                                  child: Center(
                                                      child: TextFormField(
                                                        //controller: firstNameController,
                                                        style: TextStyle(fontSize: 12),
                                                        decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                            hintText:'Order Name - Table number' ,
                                                            border: InputBorder.none
                                                        ),
                                                      )
                                                  )
                                              )),
                                          Expanded(
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 5) ,
                                                  margin: EdgeInsets.all(5) ,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                                    border: Border.all(color:Colors.grey[500]),
                                                  ),
                                                  child: Center(
                                                      child: TextFormField(
                                                        //controller: firstNameController,
                                                        style: TextStyle(fontSize: 12),
                                                        decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                            hintText:'Search by Customer Name or Number' ,
                                                            border: InputBorder.none
                                                        ),
                                                      )
                                                  )
                                              ))
                                        ]),
                                    SingleChildScrollView(child: Column(
                                      children: <Widget>[
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                  child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: 5) ,
                                                      margin: EdgeInsets.all(5) ,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                        border: Border.all(color:Colors.grey[500]),
                                                      ),
                                                      child: Center(
                                                          child: TextFormField(
                                                            //controller: firstNameController,
                                                            style: TextStyle(fontSize: 12),
                                                            decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                                hintText:'Customer Name' ,
                                                                border: InputBorder.none
                                                            ),
                                                          )
                                                      )
                                                  )),
                                              Expanded(
                                                  child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: 5) ,
                                                      margin: EdgeInsets.all(5) ,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                        border: Border.all(color:Colors.grey[500]),
                                                      ),
                                                      child: Center(
                                                          child: TextFormField(
                                                            //controller: firstNameController,
                                                            style: TextStyle(fontSize: 12),
                                                            decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                                hintText:'Email' ,
                                                                border: InputBorder.none
                                                            ),
                                                          )
                                                      )
                                                  )),
                                              Expanded(
                                                  child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: 5) ,
                                                      margin: EdgeInsets.all(5) ,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                        border: Border.all(color:Colors.grey[500]),
                                                      ),
                                                      child: Center(
                                                          child: TextFormField(
                                                            //controller: firstNameController,
                                                            style: TextStyle(fontSize: 12),
                                                            decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                                hintText:'Phone Number' ,
                                                                border: InputBorder.none
                                                            ),
                                                          )
                                                      )
                                                  ))
                                            ]),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                  child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: 5) ,
                                                      margin: EdgeInsets.all(5) ,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                        border: Border.all(color:Colors.grey[500]),
                                                      ),
                                                      child: Center(
                                                          child: TextFormField(
                                                            //controller: firstNameController,
                                                            style: TextStyle(fontSize: 12),
                                                            decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                                hintText:'Address' ,
                                                                border: InputBorder.none
                                                            ),
                                                          )
                                                      )
                                                  )),
                                            ]),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                  child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: 5) ,
                                                      margin: EdgeInsets.all(5) ,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                        border: Border.all(color:Colors.grey[500]),
                                                      ),
                                                      child: Center(
                                                          child: TextFormField(
                                                            //controller: firstNameController,
                                                            style: TextStyle(fontSize: 12),
                                                            decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                                hintText:'Apt, Suite,Building' ,
                                                                border: InputBorder.none
                                                            ),
                                                          )
                                                      )
                                                  )),
                                            ]),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                  child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: 5) ,
                                                      margin: EdgeInsets.all(5) ,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                        border: Border.all(color:Colors.grey[500]),
                                                      ),
                                                      child: Center(
                                                          child: TextFormField(
                                                            //controller: firstNameController,
                                                            style: TextStyle(fontSize: 12),
                                                            decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                                hintText:'City' ,
                                                                border: InputBorder.none
                                                            ),
                                                          )
                                                      )
                                                  )),
                                              Expanded(
                                                  child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: 5) ,
                                                      margin: EdgeInsets.all(5) ,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                        border: Border.all(color:Colors.grey[500]),
                                                      ),
                                                      child: Center(
                                                          child: TextFormField(
                                                            //controller: firstNameController,
                                                            style: TextStyle(fontSize: 12),
                                                            decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                                hintText:'State' ,
                                                                border: InputBorder.none
                                                            ),
                                                          )
                                                      )
                                                  )),
                                              Expanded(
                                                  child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: 5) ,
                                                      margin: EdgeInsets.all(5) ,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                        border: Border.all(color:Colors.grey[500]),
                                                      ),
                                                      child: Center(
                                                          child: TextFormField(
                                                            //controller: firstNameController,
                                                            style: TextStyle(fontSize: 12),
                                                            decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                                hintText:'Zipe Code' ,
                                                                border: InputBorder.none
                                                            ),
                                                          )
                                                      )
                                                  ))
                                            ]),
                                      ],
                                    ))
                                  ],
                                )
                            ),
                          ],
                        )
                    ),
                  )
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(//color: Colors.green,
        margin: EdgeInsets.only(top:5,left: 5),
        decoration: BoxDecoration(color: Colors.white,
            border: Border(left:BorderSide(width: 0.2,color: Colors.blueGrey[200]),
              top: BorderSide(width: 0.2,color: Colors.blueGrey[200]),
            )
        ),
        child: Column(
            children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Wrap(direction: Axis.horizontal,
                                children:[
                                  Text("New",style: TextStyle(color:Color(0xffE52897),fontWeight: FontWeight.bold),),
                                  Text(" Guest")
                                ]
                            ) ,
                            Text("ARRIVED AT",style: TextStyle(color: Colors.grey,fontSize:8),),
                          ],
                        )
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child:Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add_circle),
                          Icon(Icons.copyright),
                        ],
                      ),
                    ),
                  )
              ],
            ),
              Container(//color: Color(0xffD1058A),
                height: 23,
                child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      for (int i = 0; i < _listOptions.length; i++)
                        Expanded(child:
                          Container(child: OptionsL(_listOptions[i],checkIndex == i,i)
                          )
                        ),
                    ]
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(flex:5,
                        child: Container(
                          child: ListView(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child:(widget.itemNum != null) ? itemsList() :Text("Please select an item..",style: TextStyle(color: Colors.grey[400]),) ,
                              )
                            ],
                          ),
                        ),),
                      Expanded(
                          flex: 2,
                          child: Container(
                              height: 100,padding: EdgeInsets.all(15),
                              child:
                              (widget.itemNum != null) ?
                              Column(
                                  children:[
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("SubTotal:"),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: (widget.itemNum != null) ? Text(widget.total.toString()) : Text(""),
                                        ),
                                      ],
                                    ),
                                  ]
                              )
                                  : Text("")
                          )
                      )
                    ],
                  ),
                ),
              )
            ]
        )
    );
  }

}

class Options extends StatelessWidget {
  String name;
  bool checked;
  int index;
  Options(this.name, this.checked,this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
          //padding: EdgeInsets.all(5) ,
          decoration: BoxDecoration(
            color: checked ? Color(0xffE52897) : Colors.white,
            border: Border.all(color:Color(0xffE52897)),
          ),
          child: Center(
            child: Text(name,style:TextStyle(color: checked ? Colors.white : Color(0xffE52897)),),
          )
      )
    );
  }
//quarterTurns: 3,
}