import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kissan_mandi/services/firebase_services.dart';

class CategoryProvider with ChangeNotifier{

  FirebaseService _service = FirebaseService();

  DocumentSnapshot doc;
  DocumentSnapshot userDetails;
  String selectedCategory;
  String selectedSubCat;
  List<String> urlList = [];
  Map<String,dynamic> dataToFireStore = {};


  getCategory(selectedCat)
  {
    this.selectedCategory = selectedCat;
    notifyListeners();
  }
  getSubCategory(selectedsubCat)
  {
    this.selectedSubCat = selectedsubCat;
    notifyListeners();
  }

  getCatSnapshot(snapshot)
  {
    this.doc = snapshot;
    notifyListeners();
  }

  getImages(url)
  {
    this.urlList.add(url);
    notifyListeners();
  }

  getData(data)
  {
    this.dataToFireStore = data;
    notifyListeners();
  }

  getUserDetails(){
    _service.getUserData().then((value){
      this.userDetails = value;
      notifyListeners();

    });
  }


}