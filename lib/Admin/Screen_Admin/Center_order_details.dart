import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CenterOrderDetails extends StatefulWidget {
  final cendoc ; //the center reference

  const CenterOrderDetails({Key key, this.cendoc}) : super(key: key);

  @override
  State<CenterOrderDetails> createState() => _CenterOrderDetails();
}
class _CenterOrderDetails extends State<CenterOrderDetails> {
  bool isButtonActive = true;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('تفاصيل الطلب'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[(new Color(0XFF9CCC65)), new Color(0XFFC5E1A5)])
            ),
          ),

        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25,),
              Container(
                alignment: Alignment.center,
                child: Card(
                  margin: EdgeInsets.all(20),
                  color: Colors.lightGreen[50],
                  shadowColor: Colors.black,
                  elevation: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.group_outlined,
                          color: Colors.lightGreen[400],
                          size: 25,
                        ),
                        title: Text(widget.cendoc['name']),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.lightGreen[400],
                          size: 25,
                        ),
                        title: Text(widget.cendoc['email']),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.lightGreen[400],
                          size: 25,
                        ),
                        title: Text(widget.cendoc['phone']),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Colors.lightGreen[400],
                          size: 25,
                        ),
                        title: Text(widget.cendoc['address']),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.access_time,
                          color: Colors.lightGreen[400],
                          size: 25,
                        ),
                        title: Text(widget.cendoc['workingHours']),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.child_friendly_outlined,
                          color: Colors.lightGreen[400],
                          size: 25,
                        ),
                        title: Text(widget.cendoc['kidsAge']),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.attach_money_outlined,
                          color: Colors.lightGreen[400],
                          size: 25,
                        ),
                        title: Text(widget.cendoc['price']),
                      ),
                      SizedBox(height: 5,width: 15,),
                      Row(
                        children:[
                          SizedBox(width: 10,),
                          ElevatedButton(
                            child: Text("موافق ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.black,
                              primary: Colors.green,
                              onSurface: Colors.grey[700],
                              elevation: 3,
                              padding: EdgeInsets.only(left: 50, right: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed:isButtonActive?(){
                              setState(() {
                                isButtonActive = false;
                                FirebaseFirestore.instance.collection('Centers')
                                .doc(widget.cendoc['userID'])
                                .update({
                                  'state': 'Active',
                                  'state2': 'مقبول',
                                });
                              });
                            }:null,
                          ),
                          SizedBox(height: 40,width: 15,),
                          Row(
                            children:[
                              ElevatedButton(
                                child: Text("رفض ",
                                    style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.black,
                                  primary: Colors.red,
                                  onSurface: Colors.grey[700],
                                  elevation: 3,
                                  padding: EdgeInsets.only(left: 50, right: 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                onPressed:isButtonActive?(){
                                  setState(() {
                                    isButtonActive = false;
                                    FirebaseFirestore.instance.collection('Centers')
                                        .doc(widget.cendoc['userID'])
                                        .update({
                                      'state': 'NotActive',
                                      'state2': 'مرفوض',
                                    });
                                  });
                                }:null,
                              ),],
                          ),],
                      ),],
                  ),
                ),

              ),],
            )
        )
    );
  }
}

class CenterDetails extends StatefulWidget {
  final cendoc ; //the center reference

  const CenterDetails({Key key, this.cendoc}) : super(key: key);

  @override
  State<CenterDetails> createState() => _CenterDetails();
}
class _CenterDetails extends State<CenterDetails> {
  bool isButtonActive = true;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('تفاصيل الطلب'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[(new Color(0XFF9CCC65)), new Color(0XFFC5E1A5)])
            ),
          ),

        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25,),
                Container(
                  alignment: Alignment.center,
                  child: Card(
                    margin: EdgeInsets.all(20),
                    color: Colors.lightGreen[50],
                    shadowColor: Colors.black,
                    elevation: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.group_outlined,
                            color: Colors.lightGreen[400],
                            size: 25,
                          ),
                          title: Text(widget.cendoc['name']),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.lightGreen[400],
                            size: 25,
                          ),
                          title: Text(widget.cendoc['email']),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Colors.lightGreen[400],
                            size: 25,
                          ),
                          title: Text(widget.cendoc['phone']),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.lightGreen[400],
                            size: 25,
                          ),
                          title: Text(widget.cendoc['address']),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.access_time,
                            color: Colors.lightGreen[400],
                            size: 25,
                          ),
                          title: Text(widget.cendoc['workingHours']),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.child_friendly_outlined,
                            color: Colors.lightGreen[400],
                            size: 25,
                          ),
                          title: Text(widget.cendoc['kidsAge']),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.attach_money_outlined,
                            color: Colors.lightGreen[400],
                            size: 25,
                          ),
                          title: Text(widget.cendoc['price']),
                        ),
                        SizedBox(height: 5,width: 15,),

                        ],
                    ),
                  ),

                ),],
            )
        )
    );
  }
}
