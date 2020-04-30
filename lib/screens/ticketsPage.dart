import 'package:flutter/material.dart';

class Tickets extends StatefulWidget{
  @override
  _Tickets createState() => _Tickets();
}

class _Tickets extends State<Tickets> with SingleTickerProviderStateMixin{
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 30.0;

  void animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }
  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Color(0xffE52897),
      end: Color(0xffE52897),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }
  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xffF7F7F7),
      body: Row(
        children: <Widget>[
        Expanded(
          flex: 7,
          child:Container(
            child: Column(
              children: <Widget>[
                Container(width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(5),
                  color:Color(0xff8C8D8E),
                  height: 35,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child:InkWell(
                                onTap: (){print("PRESS");},
                               child:Container(//width: 60,
                                   padding: EdgeInsets.only(top: 5),
                                 color: Color(0xff8C8D8E),
                                  child:Column(
                                    children: <Widget>[
                                      Center(child:Text(
                                        "ORDER",style: TextStyle(color: Colors.white,fontSize: 10),textAlign: TextAlign.center,
                                      )),
                                      Center(child:Icon(Icons.expand_more,size: 15,color: Colors.white,))
                                    ],
                                  )
                              )
                            )
                        ),
                        Expanded(
                            child:InkWell(onTap: (){print("PRESS");},
                                child:Container(//width: 60,
                                    padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                                    color: Color(0xff8C8D8E),
                                    child:Column(
                                      children: <Widget>[
                                        Center(child:Text(
                                          "NAME",style: TextStyle(color: Colors.white,fontSize: 10),textAlign: TextAlign.center,
                                        )),
                                        Center(child:Icon(Icons.expand_more,size: 15,color: Colors.white,))
                                      ],
                                    )
                                )
                            )
                        ),
                        Expanded(
                            child:InkWell(
                                onTap: (){print("PRESS");},
                                child:Container(//width: 60,
                                    padding: EdgeInsets.only(top: 5),
                                    color: Color(0xff8C8D8E),
                                    child:Column(
                                      children: <Widget>[
                                        Center(child:Text(
                                          "TYPE",style: TextStyle(color: Colors.white,fontSize: 10),textAlign: TextAlign.center,
                                        )),
                                        Center(child:Icon(Icons.expand_more,size: 15,color: Colors.white,))
                                      ],
                                    )
                                )
                            )
                        ),
                        Expanded(
                            child:InkWell(onTap: (){print("PRESS");},
                                child:Container(//width: 60,
                                    padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                                    color: Color(0xff8C8D8E),
                                    child:Column(
                                      children: <Widget>[
                                        Center(child:Text(
                                          "STATUS",style: TextStyle(color: Colors.white,fontSize: 10),textAlign: TextAlign.center,
                                        )),
                                        Center(child:Icon(Icons.expand_more,size: 15,color: Colors.white,))
                                      ],
                                    )
                                )
                            )
                        ),
                        Expanded(
                            child:InkWell(onTap: (){print("PRESS");},
                                child:Container(//width: 60,
                                    padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                                    color: Color(0xff8C8D8E),
                                    child:Column(
                                      children: <Widget>[
                                        Center(child:Text(
                                          "TIMER",style: TextStyle(color: Colors.white,fontSize: 10),textAlign: TextAlign.center,
                                        )),
                                        Center(child:Icon(Icons.expand_more,size: 15,color: Colors.white,))
                                      ],
                                    )
                                )
                            )
                        ),
                        Expanded(
                            child:InkWell(onTap: (){print("PRESS");},
                                child:Container(//width: 60,
                                    padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                                    color: Color(0xff8C8D8E),
                                    child:Column(
                                      children: <Widget>[
                                        Center(child:Text(
                                          "REVENUE",style: TextStyle(color: Colors.white,fontSize: 10),textAlign: TextAlign.center,
                                        )),
                                        Center(child:Icon(Icons.expand_more,size: 15,color: Colors.white,))
                                      ],
                                    )
                                )
                            )
                        ),
                        Expanded(
                            child:InkWell(onTap: (){print("PRESS");},
                                child:Container(//width: 60,
                                    padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                                    color: Color(0xff8C8D8E),
                                    child:Column(
                                      children: <Widget>[
                                        Center(child:Text(
                                          "PAYMENT",style: TextStyle(color: Colors.white,fontSize: 10),textAlign: TextAlign.center,
                                        )),
                                        Center(child:Icon(Icons.expand_more,size: 15,color: Colors.white,))
                                      ],
                                    )
                                )
                            )
                        ),
                        Container(width: 20,
                          margin: EdgeInsets.all(5),//color: Colors.red,
                          child: FittedBox(
                            child: FloatingActionButton(
                              backgroundColor: _buttonColor.value,
                              onPressed: animate,
                              tooltip: 'Toggle',
                              child: AnimatedIcon(
                                icon: AnimatedIcons.menu_close,
                                progress: _animateIcon,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                Expanded(child: Container(
                  child:Transform(
                    transform: Matrix4.translationValues(
                      0.0,
                      _translateButton.value,
                      0.0,
                    ),
                    child: Container(margin: EdgeInsets.all(5),
                        child:Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(child: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.only(left:10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(5),
                                        hintText:'Order type' ,
                                        border: InputBorder.none
                                    ),
                                  ),
                                )),
                                Expanded(child: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.only(left:10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(5),
                                        hintText:'Order type' ,
                                        border: InputBorder.none
                                    ),
                                  ),
                                )),
                                Expanded(child: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.only(left:10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(5),
                                        hintText:' ' ,
                                        border: InputBorder.none
                                    ),
                                  ),
                                ))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(child: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.only(left:10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(5),
                                        hintText:'Order type' ,
                                        border: InputBorder.none
                                    ),
                                  ),
                                )),
                                Expanded(child: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.only(left:10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(5),
                                        hintText:'Order Status' ,
                                        border: InputBorder.none
                                    ),
                                  ),
                                )),
                                Flexible(child: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.only(left:10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: Wrap(direction: Axis.horizontal,
                                    children: <Widget>[
                                      TextFormField(style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(5),
                                            hintText:'Payment' ,
                                            border: InputBorder.none
                                        ),
                                      ), Icon(Icons.expand_more,size: 15,)
                                    ],
                                  ),
                                ))
                              ],
                            )
                          ],
                        )

                    ))
                  ),

                )
              ],
            )
            ,
          )
        ),
        Expanded(
          flex: 3,
          child: Container(
              margin: EdgeInsets.only(top:5,left: 5),
              //color: Colors.white,
              decoration: BoxDecoration(color: Colors.white,
                  border: Border(left:BorderSide(width: 0.2,color: Colors.blueGrey),
                    top: BorderSide(width: 0.2,color: Colors.blueGrey),
                    //right:BorderSide(width: 0.2,color: Colors.red),
                    //bottom: BorderSide(width: 0.2,color: Colors.blueGrey)),
                    //borderRadius: BorderRadius.only(topLeft:Radius.circular(15)
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

                  Expanded(
                    child: Container(//color: Colors.greenAccent,
                      child: Center(
                        child: Text("Please select an item...",
                        style: TextStyle(color: Colors.grey),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
    ])
    );
  }
}