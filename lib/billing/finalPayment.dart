import 'package:flutter/material.dart';

class creditScreen extends StatefulWidget {
  @override
  _creditScreenState createState() => _creditScreenState();
}

class _creditScreenState extends State<creditScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: allForm(),
    );
  }
}

User user=User();
Widget allForm() {
  return WillPopScope(
    key: Key("asd45ad"),
    child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Enter Credit Card Details",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(fontFamily: 'OpenSansRegular'),
                          initialValue: "",
                          decoration: InputDecoration(
                            labelText: "CardNumber",
                            labelStyle: TextStyle(
                                fontFamily: 'OpenSansRegular',
                                color: Color(0xffC6C6C6)),
                            hintText: "3321 3224 3366 6552",
                            hintStyle: TextStyle(
                                fontFamily: 'OpenSansRegular',
                                color: Color(0xffC6C6C6)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffBDCDD1)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (val) => user.designation = val,
                          validator: (val) => val != "" ? null : val,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 167,
                            child: ListTile(
                              title: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(fontFamily: 'OpenSansRegular'),
                                  decoration: InputDecoration(
                                    hintText: "e.g: 321",
                                    labelText: "CVV",
                                    labelStyle: TextStyle(
                                        fontFamily: 'OpenSansRegular',
                                        color: Color(0xffC6C6C6)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffBDCDD1)),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  initialValue: "",
                                  onSaved: (val) => user.fname = val,
                                  validator: (val) => val != "" ? null : val),
                            ),
                          ),
                          Container(
                            width: 170,
                            child: ListTile(
                              title: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(fontFamily: 'OpenSansRegular'),
                                  decoration: InputDecoration(
                                    hintText: "e.g: 30/21",
                                    labelText: "Exp.Date",
                                    labelStyle: TextStyle(
                                        fontFamily: 'OpenSansRegular',
                                        color: Color(0xffC6C6C6)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffBDCDD1)),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  initialValue: "",
                                  onSaved: (val) => user.lname = val,
                                  validator: (val) => val != "" ? null : val),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ]),
        )),
  );
}

//Creating a class so that it can be used for writing data in firestore
class User{
  String fname;
  String lname;
  String designation;
  String designatedTimings;
  String companyName;
  String primaryUId;
  String secondaryUId;
  String imageUrl;
  Map<dynamic,dynamic> X=Map();

  User({this.fname,this.lname, this.designation, this.designatedTimings, this.companyName,
    this.primaryUId, this.secondaryUId, this.imageUrl }
      );

  toFirestore(){
    //function which will be used for creating the value(value is also a map) of map
    // of Employee's Data(Data(field){key:{value}}) in firestore
    return{
      "FirstName": fname,
      "LastName":lname,
      "Designation": designation,
      "DesignatedTimings": designatedTimings,
      "CompanyName": companyName,
      "PrimaryUId" : primaryUId,
      "SecondaryUId" : secondaryUId,
      "ImageUrl" : imageUrl
    };
  }
}