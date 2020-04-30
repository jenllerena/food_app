import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget{
  @override
  _ProfilePage createState()=> _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>{
  final db = Firestore.instance;

  TextEditingController firstNameController =  TextEditingController();
  TextEditingController middleNameController =  TextEditingController();
  TextEditingController lastNameController =  TextEditingController();
  TextEditingController emailController =  TextEditingController();
  TextEditingController phoneController =  TextEditingController();
  TextEditingController addressController =  TextEditingController();
  TextEditingController address2Controller =  TextEditingController();
  TextEditingController cityController =  TextEditingController();
  TextEditingController stateController =  TextEditingController();
  TextEditingController zipCodeController =  TextEditingController();
  String id,firstName,lastName,middleName,email,phone,address,city,state,zipCode;
  final _formKey = GlobalKey<FormState>();
  File _image;
  Uint8List profilePhoto;
  bool onSelect=false;
  StreamController<Uint8List> _events;

  void createData()async{
    await db.collection('user').document("user-data").setData({
      'firstName':firstNameController.text,
      'lastName':lastNameController.text,
      'middleName':middleNameController.text,
      'email':emailController.text,
      'phone':phoneController.text,
      'address':addressController.text,
      'city':cityController.text,
      'state':stateController.text,
      'zipCode':zipCodeController.text
    });
/*
    try {
      db.collection('user').document('user-data').updateData({
        'firstName':firstNameController.text,
        'lastName':lastNameController.text,
        'middleName':middleNameController.text,
        'email':emailController.text,
        'phone':phoneController.text,
        'address':addressController.text,
        'city':cityController.text,
        'state':stateController.text,
        'zipCode':zipCodeController.text});
    } catch (e) {
      print(e.toString());
    }
    */
  }
  void getData()  async{
    var document = await Firestore.instance.collection('user').document('user-data')
    .get().then((document) {
      firstNameController.text = document['firstName'];
      lastNameController.text = document['lastName'];
      middleNameController.text = document['middleName'];
      emailController.text = document['email'];
      phoneController.text = document['phone'];
      addressController.text = document['address'];
      cityController.text = document['city'];
      stateController.text = document['state'];
      zipCodeController.text = document['zipCode'];
    });
  }

  void getImage(){
    StorageReference photoReference = FirebaseStorage.instance.ref().child("userPicture");
    photoReference.getData(7*1024*1024).then((data){
      _events.add(data);
      return data;
    });
  }

  decideImage(){
    if(profilePhoto == null){
      return DecorationImage(image:AssetImage("Assets/camera_icon.png"),fit: BoxFit.contain);
    }else{
      return DecorationImage(image:MemoryImage(profilePhoto),fit: BoxFit.cover);
    }
  }

  getProfilePhoto(){
    int max_size = 7*1024*1024;
    StorageReference photoReference = FirebaseStorage.instance.ref().child("userPicture");
    photoReference.getData(max_size).then((data){
      setState((){
        profilePhoto = data;
      });
    }).catchError((error){});
  }

  uploadPhoto(BuildContext context)async{
    final StorageReference firebaseStoageRef = FirebaseStorage.instance.ref().child('userPicture');
    final StorageUploadTask task = firebaseStoageRef.putFile(_image);
    await task.onComplete;
    getImage();
    Navigator.pop(context);
  }

  @override
  void initState(){
    super.initState();
    _events = new StreamController<Uint8List>();
    getImage();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showCustomDialog(BuildContext context){
       return showDialog(context: context,
           builder: (BuildContext context) {
             return StatefulBuilder(
                 builder: (BuildContext context, StateSetter setState) {
                   pickerGallery(BuildContext context)async{
                     if(!onSelect){
                       onSelect = true;
                       File image = await ImagePicker.pickImage(source:ImageSource.gallery);
                       setState((){
                         onSelect = !onSelect;
                         _image = image;
                       });
                     }
                   }
                   pickerCamera(BuildContext context) async{
                     if(!onSelect) {
                       onSelect = true;
                       File image = await ImagePicker.pickImage(source: ImageSource.camera);
                       setState(() {
                         onSelect = !onSelect;
                         _image = image;
                       });
                     }
                   }
                   return AlertDialog(
                     contentPadding:EdgeInsets.all(0),
                     content: Container( width: 450.0,
                         child: Column(
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
                                           setState((){
                                             onSelect = !onSelect;
                                             _image = null;
                                           });
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
                                                 child: MaterialButton(onPressed: () {uploadPhoto(context);},
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
                                 padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                 child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: <Widget>[
                                     Row(children: <Widget>[
                                       Text(" UPLOAD PHOTO", style: TextStyle(
                                           fontSize: 20, fontWeight: FontWeight.w700),)
                                     ],),
                                     Container(margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xffE52897),)),
                                       width: 200,
                                       height: 130,
                                       child: Center(
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             Expanded(
                                                 child: Center(
                                                     child: (_image == null) ? Image(image: AssetImage("Assets/camera_icon.png")) : Image.file(
                                                         _image, fit: BoxFit.cover)
                                                 )),
                                             Align(alignment: Alignment.bottomCenter,
                                                 child: SizedBox(height: 35,
                                                   width: MediaQuery.of(context).size.width,
                                                   child: FlatButton(onPressed: () {},
                                                     shape: new RoundedRectangleBorder(
                                                       borderRadius: new BorderRadius.only(
                                                           bottomRight: Radius.circular(9),
                                                           bottomLeft: Radius.circular(9)),
                                                     ),
                                                     padding: EdgeInsets.all(0),
                                                     child: Text("UPLOAD PHOTO",
                                                       style: TextStyle(
                                                           color: Colors.white),),
                                                     color: Color(0xffE52897),
                                                   ),
                                                 )
                                             )
                                           ],
                                         ),
                                       ),
                                     ),
                                     Row(mainAxisAlignment: MainAxisAlignment.center,
                                         children: <Widget>[
                                           Container(
                                               height: 20, margin: EdgeInsets.symmetric(
                                               horizontal: 10),
                                               child: MaterialButton(onPressed: () {pickerGallery(context);},
                                                   elevation: 10,
                                                   child: Text("CHOOSE PHOTO",
                                                     style: TextStyle(fontSize: 10),),
                                                   color: Color(0xffE52897),
                                                   textColor: Colors.white,
                                                   shape: RoundedRectangleBorder(
                                                     borderRadius: new BorderRadius
                                                         .circular(20),
                                                   ))
                                           ),
                                           Container(
                                               height: 20, margin: EdgeInsets.symmetric(
                                               horizontal: 10),
                                               child: MaterialButton(
                                                   onPressed: () {
                                                     pickerCamera(context);
                                                   },
                                                   elevation: 10,
                                                   child: Text("TAKE PHOTO",
                                                     style: TextStyle(fontSize: 10),),
                                                   color: Color(0xffE52897),
                                                   textColor: Colors.white,
                                                   shape: RoundedRectangleBorder(
                                                     borderRadius: new BorderRadius
                                                         .circular(20),
                                                   ))
                                           )
                                         ]),
                                   ],
                                 )
                             ),
                           ],
                         )
                     ),
                   );
                 });
           });
       }

    return Container(//width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[Padding(padding: EdgeInsets.only(bottom: 10),child: Text("MY PROFILE",style:TextStyle(fontSize:15,fontWeight: FontWeight.w700)))],),
            Expanded(child: Row(
              children: <Widget>[
                Expanded(flex: 1,
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(//margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            decoration: BoxDecoration(border: Border.all(color: Color(0xffE52897),)),
                            width: MediaQuery.of(context).size.width,height: 120,
                            child: Center(
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: StreamBuilder(
                                      stream: _events.stream,
                                      builder: (BuildContext context,snapshot) {
                                        if (!snapshot.hasData) {
                                          return Padding(padding: EdgeInsets.only(top: 25),
                                            child: CircularProgressIndicator(
                                            backgroundColor: Color(0xffE52897)
                                           )
                                          )
                                          ;
                                        }
                                        return Expanded(
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: MemoryImage(
                                                            snapshot.data),
                                                        fit: BoxFit.cover)
                                                )
                                            )
                                        );
                                      }
                                    )
                                  ),
                                  Align(alignment: Alignment.bottomCenter,
                                      child: SizedBox(height: 30,
                                        width: MediaQuery.of(context).size.width,
                                        child: FlatButton(onPressed: (){
                                          showCustomDialog(context);},
                                          padding: EdgeInsets.all(0),
                                          child: Text("UPLOAD PHOTO",style: TextStyle(color: Colors.white),),
                                          color: Color(0xffE52897),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),
                          )
                          //SizedBox(width: 90,height: 90,),
                        ],
                      )
                  ),
                ),
                Expanded(flex:3,
                  child: Container(padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ListView(children: <Widget>[
                      Text("INFORMATION",style: TextStyle(color: Color(0xffE52897),fontSize: 12,fontWeight: FontWeight.bold)),
                      Row(children: <Widget>[
                        Expanded(child:
                          Container(margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("FIRST NAME",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    controller: firstNameController,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'name' ,
                                        border: InputBorder.none
                                    ),
                                    //onSaved: (value){print("!!!!!");print(value);}
                                  ),
                                )
                              ],
                            ))),
                        Expanded(child:
                          Container(margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("MIDDLE NAME",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    controller: middleNameController,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'middle name' ,
                                        border: InputBorder.none
                                    ),
                                      onSaved: (value) => middleName = value
                                  ),
                                )
                              ],
                            ))),
                      ]),
                      Row(children: <Widget>[
                        Expanded(child:
                          Container(margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("LAST NAME",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    controller: lastNameController,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding:EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'last name' ,
                                        border: InputBorder.none
                                    ),
                                      onSaved: (value)=>lastName = value
                                  ),
                                )
                              ],
                            ))),
                        Expanded(child:
                          Container(margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("DATE OF BIRTH",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  //margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'M' ,
                                        border: InputBorder.none
                                    ),
                                    //onSaved: (value)=>firstName = value
                                  ),
                                )
                              ],
                            ))),
                      ]),
                      Divider(color: Color(0xffE52897)),
                      Text("CONTACT INFORMATION",style: TextStyle(color: Color(0xffE52897),fontSize: 12,fontWeight: FontWeight.bold)),
                      Row(children: <Widget>[
                        Expanded(child:
                        Container(margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("PERSONAL EMAIL",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  //margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    controller: emailController,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding:EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'email' ,
                                        border: InputBorder.none
                                    ),
                                      onSaved: (value)=>email = value
                                  ),
                                )
                              ],
                            ))),
                        Expanded(child:
                        Container(margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("PHONE NUMBER",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  //margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    controller: phoneController,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'phone' ,
                                        border: InputBorder.none
                                    ),
                                      onSaved: (value)=>phone = value
                                  ),
                                )
                              ],
                            ))),
                      ]),
                      Divider(color: Color(0xffE52897)),
                      Text("ADDRESS",style: TextStyle(color: Color(0xffE52897),fontSize: 12,fontWeight: FontWeight.bold)),
                      Row(children: <Widget>[
                        Expanded(child:
                        Container(margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("ADDRESS",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    controller: addressController,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding:EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'address' ,
                                        border: InputBorder.none
                                    ),
                                      onSaved: (value)=>address = value
                                  ),
                                )
                              ],
                            ))),
                        Expanded(child:
                        Container(margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("ADDRESS LINE 2",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  //margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    controller: address2Controller,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'address 2' ,
                                        border: InputBorder.none
                                    ),
                                  ),
                                )
                              ],
                            ))),
                      ]),
                      Row(children: <Widget>[
                        Expanded(child:
                        Container(margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("CITY",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  //margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    controller: cityController,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'City' ,
                                        border: InputBorder.none
                                    ),
                                      onSaved: (value)=>city = value
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
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    controller: stateController,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'State' ,
                                        border: InputBorder.none
                                    ),
                                      onSaved: (value)=>state = value
                                  ),
                                )
                              ],
                            ))),
                        Expanded(child:
                        Container(margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("ZIP CODE",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  //margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    controller: zipCodeController,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'Zip code' ,
                                        border: InputBorder.none
                                    ),
                                      onSaved: (value)=>zipCode = value
                                  ),
                                )
                              ],
                            )))
                      ]),
                      Divider(color: Color(0xffE52897)),
                      Text("PASSWORD",style: TextStyle(color: Color(0xffE52897),fontSize: 12,fontWeight: FontWeight.bold)),
                      Row(children: <Widget>[
                        Expanded(child:
                        Container(margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("CURRENT PASSWORD",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  //margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding:EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'******' ,
                                        border: InputBorder.none
                                    ),
                                  ),
                                )
                              ],
                            ))),
                        Expanded(child:
                          Container(margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Wrap(
                              children: <Widget>[
                                Text("NEW PASSWORD",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Container(
                                  //margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        hintText:'password' ,
                                        border: InputBorder.none
                                    ),
                                  ),
                                )
                              ],
                            ))),
                      ]),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(onPressed: (){createData();},
                              child: Text("SAVE"),color: Color(0xffE52897),textColor: Colors.white,
                              shape:RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10),
                              ))
                      )
                    ]),
                  ),
                )
              ],
            ))
          ],
        )
    );
  }


}