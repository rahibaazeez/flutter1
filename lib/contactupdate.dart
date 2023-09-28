import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactform/contacthome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contactupdate extends StatefulWidget {
  String? id;
  String? name;
  String? phonenumber;
  String? photo;
  Contactupdate({ this.id,this.name, this.phonenumber,this.photo});

  @override
  State<Contactupdate> createState() => _ContactupdateState();
}

class _ContactupdateState extends State<Contactupdate> {
  update(){
    var data1={
      "name":namecontroller.text,
      "phonenumber":phonecontroller.text,
      "photo":photocontroller.text
    };
    FirebaseFirestore.instance.collection("contacts").doc(widget.id).update(data1);
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Contacthome()));

  }
  TextEditingController namecontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();
  TextEditingController photocontroller=TextEditingController();
  @override
  void initState() {
   namecontroller.text=widget.name!.toString();
   photocontroller.text=widget.phonenumber!.toString();
   photocontroller.text=widget.photo!.toString();
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Add contact "),
      ),
      body: Column(
        children: [
          TextField(
            controller: namecontroller,
            decoration: InputDecoration(
                label: Text("Enter name"),
                border: OutlineInputBorder()
            ),

          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: phonecontroller,
            decoration: InputDecoration(
                label: Text("Enter phonenumber"),
                border: OutlineInputBorder()
            ),
          ),

          TextField(
            controller: photocontroller,
            decoration: InputDecoration(
                label: Text("Enter photo url"),
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: (){
            update();
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Contacthome()));
          }, child:Text("Submit") )

        ],
      ),
    );
  }
}
