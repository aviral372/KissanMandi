
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kissan_mandi/Screens/categories/subCat_screen.dart';
import 'package:kissan_mandi/Screens/sellItems/seller_subCat.dart';
import 'package:kissan_mandi/forms/seller_vegetables_form.dart';
import 'package:kissan_mandi/provider/cat_provider.dart';
import 'package:kissan_mandi/services/firebase_services.dart';
import 'package:provider/provider.dart';

class SellerCategory extends StatelessWidget {
  static const String id = 'seller-category-list-screen';
  @override
  Widget build(BuildContext context) {


  FirebaseService _service = FirebaseService();
  var _catProvider = Provider.of<CategoryProvider>(context);



    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Center(
          child: Text(
            'Choose Categories',
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
            future: _service.categories.orderBy('sortId',descending: false).get(),
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
                          _catProvider.getCategory(doc['catName']);
                          _catProvider.getCatSnapshot(doc);
                          if(doc['subCat']==null)
                            {
                              return Navigator.pushNamed(context, SellerVegForm.id);
                            }
                          Navigator.pushNamed(context, SellerSubCatList.id,arguments: doc);
                        },
                        leading: Image.network(doc['image']),
                        title: Text(doc['catName'],style: TextStyle(color: Colors.yellow),),
                        trailing: doc['subCat']==null ? null: Icon(Icons.arrow_forward_ios, color: Colors.blue,),
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
