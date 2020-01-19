import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:qrscanner/Cart/AddToCart.dart';

import 'finalPayment.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int totalamount = 0;
  double totalweight = 0;

  quantityChange() {
    for(int i=0; i<barcode.length; i++)
    Firestore.instance.collection("Products").document("${barcode[i]}").setData({
      "Quantity":quantity[i]
    }, merge: true);
  }

  transcationCancel(){

  }

  @override
  void initState() {
    quantityChange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Prizes is $prizes");
    for (int i in prizes) totalamount += i;
    for (double i in weight) totalweight += i;
//  for(int i=0;i<prizes.length;i++){
//    if(prizes[i] != null )totalamount=totalamount+prizes[i];
//  }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("BILL",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25)),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => creditScreen())),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Material(
                      elevation: 2.5,
                      child: ListTile(
                        title: Text(items[index],
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        trailing: Text("₹${prizes[index]}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                      ),
                    );
                  }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                  elevation: 3,
                  color: Colors.black54,
                  child: ListTile(
                    title: Text(
                      "TOTAL : Weight:${totalweight.toStringAsFixed(2)} Kg",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 23),
                    ),
                    trailing: Text("₹$totalamount",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 23)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
