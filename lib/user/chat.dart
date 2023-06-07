import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:herbit/public_user/disease.dart';
import 'package:herbit/user/prescription.dart';


class chat extends StatefulWidget {
  const chat({Key? key}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  String? dropdownvalue ;
  TextEditingController symptomControler=new TextEditingController();

  // List of items in our dropdown menu
  var items = [
    'Malayalam',
    'English',
  ];
  List<String> options = []; // List to store dropdown options
  String selectedOption = ''; // Currently selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text("home page"),
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
    bottomRight: Radius.circular(25),
    bottomLeft: Radius.circular(25),
    )),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(19),
              child:StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('symptom').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    List<String> data = snapshot.data!.docs.map((
                        doc) => doc['symptom'] as String).toList();

                    return DropdownButtonFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.zero),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colors.black,
                              ))),
                      hint: Text(
                        'Select Symptoms',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: dropdownvalue,
                      onChanged: (vale) {
                        setState(() {
                          dropdownvalue = vale.toString();
                        });
                      },
                      items: data
                          .map((value) =>
                          DropdownMenuItem(value: value, child: Text(value)))
                          .toList(),
                    );
                  }
              ),),
            Padding(
              padding: const EdgeInsets.all(19),
              child: TextField(
                controller: symptomControler,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Retype your symptoms",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 70,
              height: 40,
              color: Colors.green[900],
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => prescription(symptomControler.text.trim()),));
                },
                child: Text(
                  'Submit ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
