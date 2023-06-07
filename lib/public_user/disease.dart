import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:herbit/Login.dart';

import '../user/doctor.dart';
import 'homepage.dart';

class disease extends StatefulWidget {
  final String text;


  disease(this.text);

  @override
  State<disease> createState() => _diseaseState();
}

class _diseaseState extends State<disease> {
  List<Map<String, dynamic>> allData = [];
  List<Map<String, dynamic>> filteredData = [];

  String datas='';
  @override
  void initState() {
    super.initState();
    fetchData();
     datas=widget.text;
  }
  Future<void> fetchData() async {
    // Retrieve data from Firebase collection
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('symptom').get();

    // Store retrieved data in allData variable
    allData = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    // Apply filter to the data (e.g., filter by a specific field)
    filteredData = allData.where((data) => data['symptom'] == widget.text).toList();
    print("medicine$filteredData");

    // Refresh the UI
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homepage(),));
          }, icon: Icon(Icons.home))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              SizedBox(
                height: 30,
              ),
              Text(
                'Symptoms',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.text.toUpperCase(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            /*  Text(
                '* headache',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                '* vomiting',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),*/
              Text(
                'Medicine',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: 10,
              ),
    ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    itemCount: filteredData.length,
    itemBuilder: (context, index) {
    // Display the filtered data
    return ListTile(
    title: Text(filteredData[index]['medicine'].toUpperCase())
    );},),
              SizedBox(
                height: 30,
              ),

              SizedBox(height: 100,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 70),
                height: 60,
                color: Colors.green[900],
                child: TextButton(
                  child: Text('OK',style: TextStyle(color: Colors.white,fontSize: 25),),
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homepage(),));
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
