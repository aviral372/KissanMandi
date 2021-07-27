import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kissan_mandi/provider/cat_provider.dart';
import 'package:kissan_mandi/services/firebase_services.dart';
import 'package:provider/provider.dart';

class UserReviewScreen extends StatefulWidget {
  static const String id = 'user-review-screen';

  @override
  _UserReviewScreenState createState() => _UserReviewScreenState();
}

class _UserReviewScreenState extends State<UserReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading=false;

  FirebaseService _service = FirebaseService();

  var _nameController = TextEditingController();
  var _countryCodeController = TextEditingController(text: '+91');
  var _phoneController = TextEditingController();
  var _addressController = TextEditingController();

  @override
  void didChangeDependencies() {
    var _provider = Provider.of<CategoryProvider>(context);
    _provider.getUserDetails();
    setState(() {

      _addressController.text = _provider.userDetails['address'];
    });
    super.didChangeDependencies();
  }

  Future<void> updateUser(provider,Map<String, dynamic>data,context) {
    return _service.users
        .doc(_service.user.uid)
        .update(data)
        .then((value) =>saveProductToDb(provider,context),)
        .catchError((error){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update location'),
        ),);
    });
  }

  Future<void> saveProductToDb(CategoryProvider provider,context) {
    return _service.users
        .doc(_service.user.uid)
        .set(provider.dataToFireStore)
        .then((value) {}, )
        .catchError((error){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update location'),
        ),);
    });
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<CategoryProvider>(context);

    showConfirmDialog(){
      return showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Confirm',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text('Are you sure you want to save below products'),
                  SizedBox(height: 10,),
                  ListTile(
                    leading: Image.network(_provider.dataToFireStore['images'][0]),
                    title: Text(_provider.dataToFireStore['title'],maxLines: 1,),
                    subtitle: Text(_provider.dataToFireStore['price'],),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: (){
                        setState(() {
                          _loading = false;
                        });
                        Navigator.pop(context);},
                          child: Text('cancel'),),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          _loading = true;
                        });
                        updateUser(_provider,{
                        'contactDetails':{
                          'name':_nameController.text,
                          'mobile':_phoneController.text,
                        }
                      }, context).then((value){
                        setState(() {
                          _loading = false;
                        });
                        print('completed');
                      });},
                        child: Text('confirm'),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  if(_loading)
                  Center(child: CircularProgressIndicator())
                ],
              ),
            ),
          );
        }
      );
    }


    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Center(
          child: Text(
            'Review details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 40,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        radius: 38,
                        child: Icon(
                          CupertinoIcons.person_alt,
                          color: Colors.green,
                          size: 60,
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Your Name',
                        ),
                        validator: (value){
                          if(value.isEmpty)
                          {
                            return 'Enter name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Text('Contact details',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                        child: TextFormField(
                      controller: _countryCodeController,
                          enabled: false,
                          decoration: InputDecoration(labelText: 'Country',helperText: '',),
                    )),
                    SizedBox(width: 10,),
                    Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Phone Number'),
                          maxLength: 10,
                          validator: (value){
                            if(value.isEmpty)
                              {
                                return 'Enter mobile number';
                              }
                            return null;
                          },
                        ),),
                  ],
                ),
                SizedBox(height: 20,),
                TextFormField(
                  minLines: 2,
                  maxLines: 4,
                  controller: _addressController,
                  decoration: InputDecoration(
                      labelText: 'seller address'
                  ),
                  validator: (value)
                  {
                    if(value.isEmpty) {
                      return 'Please fill the required field';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  child: Text(
                    'Confirm',textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                onPressed: (){
                    if(_formKey.currentState.validate()){

                      return showConfirmDialog();

                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Enter required fields'),
                      )
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
