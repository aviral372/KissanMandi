import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geocoder/geocoder.dart';
import 'package:kissan_mandi/Screens/home_screen.dart';
import 'package:kissan_mandi/Screens/login_screen.dart';
import 'package:kissan_mandi/Screens/main_screen.dart';
import 'package:kissan_mandi/services/firebase_services.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  static const String id = 'Location-Screen';
  final bool locationChanging;

  LocationScreen({this.locationChanging});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  FirebaseService _service = FirebaseService();

  bool _loading = true;
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  String _address;

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String manualAddress;


  Future<LocationData>getLocation()async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    final coordinates = new Coordinates(_locationData.latitude, _locationData.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    setState(() {
      _address = first.addressLine;
      countryValue = first.countryName;
    });



    return _locationData;
  }

  @override
  Widget build(BuildContext context){

    if(widget.locationChanging==null)
      {
        _service.users
            .doc(_service.user.uid)
            .get()
            .then((DocumentSnapshot document) {
          if (document.exists) {
            if(document['address']!=null)
            {
              if(mounted){
                setState(() {
                  _loading = true;
                });
                Navigator.pushReplacementNamed(context, MainScreen.id);
              }

            }
            else
            {
              setState(() {
                _loading = false;
              });
            }
          }
        });
      }
    else
      {
        setState(() {
          _loading = false;
        });
      }



    ProgressDialog progressDialog = ProgressDialog(
      context: context,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      loadingText: 'Please wait...',
      progressIndicatorColor: Theme.of(context).primaryColor,
    );

    showBottomScreen(context){

      getLocation().then((location){
        if(location!=null)
          {
            progressDialog.dismiss();
            showModalBottomSheet(
              isScrollControlled: true,
              enableDrag: true,
              context: context,
              builder: (context){
                return Column(
                  children: [
                    SizedBox(height: 26.0,),
                    AppBar(
                      automaticallyImplyLeading: false,
                      iconTheme: IconThemeData(
                        color: Colors.yellow,
                      ),
                      elevation: 1,
                      backgroundColor: Colors.green,
                      title: Row(
                        children: [
                          IconButton(onPressed:(){
                            Navigator.pop(context);
                          },
                            icon: Icon(Icons.clear),
                          ),
                          SizedBox(height: 10,),
                          Text('Location',style: TextStyle(color:Colors.yellow),),
                        ],
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Search city, area or neighbourhood',
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: (){
                        progressDialog.show();
                        getLocation().then((value){
                          if(value!=null)
                             {
                               _service.updateUser({
                                 'location':GeoPoint(value.latitude, value.longitude),
                                 'address': _address,

                               }, context).then((value){
                                 progressDialog.dismiss();
                                 Navigator.pushNamed(context, HomeScreen.id);
                               });
                             }
                        });
                      },
                      horizontalTitleGap: 0.0,
                      leading: Icon(
                        Icons.my_location,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Use current location',
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 4, top: 4,),
                        child: Text(
                          'Choose city',
                          style: TextStyle(color: Colors.yellow, fontSize: 12,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0,0,10,0),
                      child: CSCPicker(
                        layout: Layout.vertical,
                        dropdownDecoration: BoxDecoration(shape: BoxShape.rectangle),
                        defaultCountry: DefaultCountry.India,
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged:(value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged:(value) {
                            setState(() {
                              cityValue = value;
                              manualAddress =
                              _address = '$cityValue, $stateValue, $countryValue';
                            });

                            if(value!=null)
                              {
                                _service.updateUser({
                                  'address': manualAddress,
                                  'state': stateValue,
                                  'city': cityValue,
                                  'country': countryValue,

                                }, context);
                              }
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }
        else
          {
            progressDialog.dismiss();
          }
      });
  }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
      elevation: 1,
        title: Center(
          child: Text(
          'Select Location',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.lightGreen,
    ),
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('images/farm.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)),

                          icon: Icon(CupertinoIcons.location_fill),
                          label: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Text('Around me'),
                          ),
                          onPressed: (){
                            progressDialog.show();
                            getLocation().then((value){

                              if(value!=null)
                              {
                                _service.updateUser({
                                  'address': _address,
                                  'location': GeoPoint(value.latitude, value.longitude),
                                }, context);
                              }
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    progressDialog.show();
                    showBottomScreen(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.blue,width: 2.0),),
                      ),
                      child: Text(
                        'Set Location Manually',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),

          ],
        ),
        ),
      );
  }
}
