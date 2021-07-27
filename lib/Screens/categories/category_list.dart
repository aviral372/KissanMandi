import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kissan_mandi/Screens/categories/subCat_screen.dart';
import 'package:kissan_mandi/services/firebase_services.dart';

class CategoryListScreen extends StatelessWidget {

  static const String id = 'category-list-screen';
  FirebaseService _service = FirebaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Center(
          child: Text(
            'Categories',
            style: TextStyle(
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/farm.png'), fit: BoxFit.cover),
        ),
        child: Container(
          child: FutureBuilder<QuerySnapshot>(
            future: _service.categories.get(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Container();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }

              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index){
                    var doc = snapshot.data.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: (){
                          if(doc['subCat']==null)
                            {
                              return print('No sub Categories');
                            }
                          Navigator.pushNamed(context, SubCatList.id,arguments: doc);
                        },
                        leading: Image.network(doc['image']),
                        title: Text(doc['catName'],style: TextStyle(color: Colors.yellow),),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue,),
                      )
                    );
                  },
                ),
              );
            },
          ),
        ),

      ),
    );
  }
}
