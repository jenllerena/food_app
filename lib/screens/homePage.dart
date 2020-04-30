import 'package:flutter/material.dart';
import 'package:eatos_app/screens/newOrder.dart';
import 'package:eatos_app/screens/ticketsPage.dart';
import 'package:eatos_app/screens/settings.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>{
  List<String> _list = ["New Order", "Tickets", "Settings", "Switch user"];
  List<GlobalKey> _keys = [GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey()];
  List<String> _icons = ["Assets/newOrder.png", "Assets/tickets.png", "Assets/settingsIcon.png", "Assets/switchUser.png"];
  int checkIndex = 0;

  @override
  void initState() {
    checkIndex = 0;
    super.initState();
  }
  void indexChecked(int i) {
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
      body: SafeArea(
        child: Row(
          children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: 55,
            color: Color(0xff565962),
            child: Column(//mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(width:  MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(),
                    )
                  ),
                  child: InkWell(
                    onTap: (){ShowUserInfo(context);},
                    child: CircleAvatar(radius: 12,
                      backgroundColor: Color(0xffC61B7F),child: Text("J"),
                    )
                  )
                ),
                Expanded(child:
                  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    for (int i = 0; i < _list.length; i++)
                     Expanded(
                         child: GestureDetector(
                             onTap: ()=> indexChecked(i),
                             child: ListText(
                                 _list[i], _keys[i], _icons[i], checkIndex == i)
                         )// &&
                     )
                 ],
               )),
                Container(
                   padding: EdgeInsets.symmetric(horizontal: 5,vertical: 18),
                    child: Center(
                      child: Image.asset('Assets/titulo.png')
                  )
                ),
              ],//crossAxisAlignment: CrossAxisAlignment.center
            ),
          ),
          if(checkIndex==0)
            Expanded(
              child: Scaffold(
                resizeToAvoidBottomPadding: false,
                body: NewOrden(),
              )
            )
          else
            if(checkIndex==1)
              Expanded(
                child: Tickets())
            else if(checkIndex==2)
              Expanded(
                  child: Settings()
              )
          ]
        )
        ),
      );
  }

  Future<void> ShowUserInfo(BuildContext context){
    return showDialog(context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return
                  Container(
                    child: Stack(alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Positioned(
                          //top: 30,
                          child: AlertDialog(
                              elevation:0,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(25),
                              ),
                              backgroundColor:Color(0xff565962),
                              content: Container(
                                height: 60,width: 230,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text("NAME USER",style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,color: Colors.white))
                                    )
                                  ],
                                )
                              )
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height/2,
                          child: Container(
                            width: 60,height: 60,
                            decoration: BoxDecoration(
                                color: Color(0xffC61B7F),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('Assets/titulo.png')
                                )
                            ),
                          ),
                        )
                      ],
                    )
                );
              }
          );
    });
  }
}
class ListText extends StatelessWidget {
  String name;
  GlobalKey globalKey;
  String icon;
  bool checked;

  ListText(this.name, this.globalKey,this.icon, this.checked);

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: MediaQuery.of(context).size.height/6,
        width:  MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 3),
        key: globalKey,
        decoration: BoxDecoration(
          color: checked ? Color(0xffC61B7F): Color(0xff565962),
          border: Border(
            bottom: BorderSide(),
        ),
      ),
      //quarterTurns: 3,
      child: Center(
        child:Wrap(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(5),
                child: Center(
                  child:Container(width: 25,
                    child:Image.asset(icon))
                )
            ),
            Center(child:Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
              ),)
            ),
        ],
      ),
      )
    );
  }
}
class CustomUserDialog extends StatelessWidget {
  final String title, description;
  final Image image;

  CustomUserDialog({
    @required this.title,
    @required this.description,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        //...top circlular image part,
      ],
    );
  }
}