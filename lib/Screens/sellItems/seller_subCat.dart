import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kissan_mandi/services/firebase_services.dart';

class SellerSubCatList extends StatelessWidget {
  static const String id = 'seller-subCat-screen';
  FirebaseService _service = FirebaseService();
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Center(
          child: Text(
            args['catName'],
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
            child: FutureBuilder<DocumentSnapshot>(
              future: _service.categories.doc(args.id).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Container();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(),);
                }

                var data = snapshot.data['subCat'];

                return Container(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index){


                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: (){

                            },

                            title: Text(data[index],style: TextStyle(color: Colors.yellow),),

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
