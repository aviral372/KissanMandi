import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kissan_mandi/Screens/categories/category_list.dart';
import 'package:kissan_mandi/services/firebase_services.dart';

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FirebaseService _service = FirebaseService();


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: _service.categories.orderBy('sortId',descending: false).get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            return Container(
              height: 200,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('Categories',style: TextStyle(color: Colors.yellow),)),
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, CategoryListScreen.id);
                      },
                      child: Row(
                        children: [
                          Text('See all', style: TextStyle(color: Colors.lightBlueAccent),),
                          Icon(Icons.arrow_forward_ios,size: 12,color: Colors.lightBlueAccent,),
                        ],
                      ),),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index){
                        var doc = snapshot.data.docs[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Image.network(doc['image']),
                                Text(
                                  doc['catName'].toUpperCase(),
                                textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.yellow),

                                ),
                              ],
                            ),
                          ),
                        );
                    },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
