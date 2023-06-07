import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';
class analysis extends StatefulWidget {
  const analysis({Key? key}) : super(key: key);

  @override
  State<analysis> createState() => _analysisState();
}

class _analysisState extends State<analysis> {
  List image=["images/download.jpg","images/curryleaf.jpg","images/turmeric.jpg","images/images.jpg"];
  List name=["Thulasi","curry leave","turmeric","sunflower",];
  List discription=["* natural immunity booster \n* reduce cold& cough \n* anti cancer properties\n* good for diabetes"
    ,"* powerful antioxidant\n* may reduce risk of cancer\n* help in management of diabetes\n* analgesic\n* neuroprotective effect",
    "* reduce inflammation\n* helps ease joint pain\n* enhances mood\n* guards your hearts\n* treats your gut\n* improve immunity system\n* fight free radical damages"
    ,"* improves heart health\n* improve skin health\n* prevent asthma\n* prevent cancer\n* improves hair health\n* improve digestion",

    /* "reduce cold& cough"
      "anti cancer properties"
      "good for diabetes"*/];
  final CollectionReference _product = FirebaseFirestore.instance
      .collection('product'); //refer to the table we created

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          'HERBAL',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:
      Container(
      child:StreamBuilder(

      stream: _product.snapshots(),
    builder: (BuildContext context,

    AsyncSnapshot<QuerySnapshot>streamSnapshot){

    if(streamSnapshot.hasData){
    return Column(
      children: [

        Text("Analysis",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        ListView.builder(
          shrinkWrap: true,
              itemCount:  streamSnapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {

                final DocumentSnapshot documentSnapshot=streamSnapshot.data!.docs[index];
                print("snap ${documentSnapshot}");
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius:40,
                          backgroundImage: NetworkImage(documentSnapshot['image']),
                        ),
                      /*  Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(documentSnapshot['image']))
                          ),

                        ),*/
                        SizedBox(width: 5,),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(documentSnapshot['plant_name'],style: TextStyle(fontSize: 20,color: Colors.green)),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(documentSnapshot['description'],style: TextStyle(fontSize: 18)),
                            ),
                          ],
                        )
                      ],

                    ),
                  ),
                );
              },
              /*children: <Widget>[
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 210),
                              child: Padding(
                                padding: const EdgeInsets.only(top:10 ),
                                child:



                                ),
                              ),
                             Text('THULASI'),

                          ],
                        ),

                      ],
                    ),


                  ],*/
            ),
      ],
    );

    }
    return const Center(
    child: CircularProgressIndicator(),
    );
    },
    ),

      ),
    );
  }
}
