import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactform/contacthome.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Contactmain extends StatefulWidget {
  const Contactmain({Key? key}) : super(key: key);

  @override
  State<Contactmain> createState() => _ContactmainState();
}

class _ContactmainState extends State<Contactmain> {
  sentdata()async{


    var data={
      "name":namecontroller.text,
      "phonenumber":phonecontroller.text,
      "photo":url
    };
           await FirebaseFirestore.instance.collection("contacts").add(data);
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Contacthome()));


  }
 String? url;
  getimage()async{
    ImagePicker imagePicker=ImagePicker();
   XFile? xfile=await imagePicker.pickImage(source: ImageSource.camera);
   if(xfile!=null){
     File file=File(xfile!.path);
     storageimage(file);


   }
  }
  storageimage(File file)async{
    var ref=await FirebaseStorage.instance.ref().child("images/${file.path}");
   await ref.putFile(file);
   setState(() async{
     url=await ref.getDownloadURL();
   });


  }

  TextEditingController namecontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();

  @override
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

        ElevatedButton(onPressed: (){
          getimage();
        }, child: Text("Select Image")),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: (){
            if(url != null){
              sentdata();
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please wait photo is uploading")));
            }
          }, child:Text("Submit") )

        ],
      ),
    );
  }
}
