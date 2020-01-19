import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as qrScanner;
import 'package:qrscanner/billing/cart.dart';

List items = [];
List prizes=[];
List quantity=[];
List barcode=[];
List weight=[];

class AddToCart extends StatefulWidget {
  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
//  StreamSubscription _streamSubscription;
  dynamic prod;

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Do you really want to exit?",
            style: TextStyle(fontFamily: 'OpenSansRegular', fontSize: 18.5),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "No",
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              child: Text(
                "Yes",
              ),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ));
  }

//  details() async{
//    QuerySnapshot querySnapshot = await Firestore.instance.collection("Products").getDocuments();
//    var list = querySnapshot.documents;
//    print(list);
//  }
//  @override
//  void initState() {
//    details();
//
//    super.initState();
//  }
  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Shopeazy"),
          backgroundColor: Colors.black54,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.person_outline),
            onPressed: _signOut,),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart())),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20.0),
                          child: ListTile(
                            title: Text("${items[index]}"),
                            trailing: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                if (this.mounted) {
                                  setState(() {
                                    String temp = barcode[index];
                                    prizes.removeAt(index);
                                    items.removeAt(index);
                                    barcode.removeAt(index);
                                    quantity.removeAt(index);
                                    weight.removeAt(index);
                                    for(int i=0; i<barcode.length; i++)
                                      if (temp==barcode[i])quantity[i]+=1;
//                                         Firestore.instance
//                                         .collection('Products')
//                                         .document(barcode.removeAt(index))
//                                         .setData({
//                                          "products": [data]
//                                          }, merge: true);
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    })),
            SizedBox(
              height: 10.0,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: Colors.black54,
                    onPressed: () {
                      qrScanner.scan().then((data) {
                        if (data != null && data.length > 0) {
                          // sending the qr data to firestore
//                          Firestore.instance
//                              .collection("Carts")
//                              .document("cartID")
//                              .setData({
//                            "products": [data]
//                          }, merge: true);

//                          Firestore.instance
//                              .collection('Products')
//                              .document(data)
//                              .get()
//                              .then((DocumentSnapshot) {
//                            prod = DocumentSnapshot.data.values;
//                          });

                          Firestore.instance
                              .collection('Products')
                              .document(data)
                              .get()
                              .then((DocumentSnapshot) {
                            dynamic qnew;
                            dynamic qnew1;
                            dynamic qnew2;
                            dynamic qnew3;

//                            print(DocumentSnapshot.data.values.toList()[2]);
                            qnew = (DocumentSnapshot?.data?.values.toList()[2]);
                            qnew1= (DocumentSnapshot?.data?.values.toList()[1]);
                            qnew2= (DocumentSnapshot?.data?.values.toList()[0]) ;
                            qnew3 = (DocumentSnapshot?.data?.values.toList()[3] -1);

                            print("Quantity $qnew3");
//                            print("item $qnew");
                            print("prize $qnew2");
                            print("weight $qnew1");
                            if (this.mounted)
                              setState(() {
                                if(qnew3!=0 && qnew3>0) {
                                  barcode.add(data);
                                  items.add(qnew);
                                  quantity.add(qnew3);
                                  prizes.add(qnew2);
                                  weight.add(qnew1);
                                }});
                          });

//                        Firestore.instance.collection('Products').document(data)
//                            .get().then((DocumentSnapshot){
//                            prod="${DocumentSnapshot.data.values.toString()}";}
//                        );

//                        if (this.mounted)
//                          setState(() {
//                            print("pord is $prod");
//                            items.add(data);
////                            print("Items are $items");
//                          });
                        }else{
                          print("No data");
                        }
                      });
                    },
                    child: Text("Add to Cart",style: TextStyle(color: Colors.white,fontSize: 20),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print(e); // TODO: show dialog with error
  }
}