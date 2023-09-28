import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactform/contactmain.dart';
import 'package:contactform/contactupdate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contacthome extends StatefulWidget {
  const Contacthome({Key? key}) : super(key: key);

  @override
  State<Contacthome> createState() => _ContacthomeState();
}

class _ContacthomeState extends State<Contacthome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Home page",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        actions: [
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Contactmain()));
            },
              child: Icon(Icons.add,color: Colors.white,size: 50,))
        ],
      ),
      body: Column(
        children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("contacts").snapshots(),
                builder: (context,snapshot) {

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }
                  if(snapshot.hasData){
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index) {

                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>Contactupdate(id: snapshot.data!.docs[index].id, name: snapshot.data!.docs[index]["name"], phonenumber: snapshot.data!.docs[index]["phonenumber"],photo: snapshot.data!.docs[index]["photo"],)));
                              },
                              child: ListTile(
                                title: Text(snapshot.data!.docs[index]["name"]),
                                subtitle: Text(snapshot.data!.docs[index]["phonenumber"].toString()),
                                trailing:GestureDetector(
                                    onTap: (){
                                      FirebaseFirestore.instance.collection("contacts").doc(snapshot.data!.docs[index].id).delete();

                                    },
                                    child: Icon(Icons.delete)),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(snapshot.data!.docs[index]["photo"])
                                      )
                                  ),

                                ),

                              ),
                            );
                          }
                      ),
                    );
                  }
                  else{
                    return Text("Something wrong");
                  }

                }
              ),

        ],
      ),

    );
  }
}
