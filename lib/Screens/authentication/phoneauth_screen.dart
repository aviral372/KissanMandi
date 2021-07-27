import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kissan_mandi/services/phoneauth_service.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';

class PhoneAuthScreen extends StatefulWidget {
  static const String id = 'Phone - AuthScreen';

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  bool validate = false;
  var countryCode = TextEditingController(text: '+91');
  var phoneNumber = TextEditingController();
  String counterText='0';

  PhoneAuthService _service = PhoneAuthService();

  @override
  Widget build(BuildContext context) {

    ProgressDialog progressDialog = ProgressDialog(
      context: context,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      loadingText: 'Please wait...',
      progressIndicatorColor: Theme.of(context).primaryColor,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Center(
          child: Text(
            'Kissan Mandi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('images/farm.png'), fit: BoxFit.cover),
        ),
        child: Padding(

          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 40.0,),
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.yellow,
              child: Icon(CupertinoIcons.person_3_fill, color: Colors.green,size: 60.0,),
            ),
            SizedBox(height: 12,),
            Text(
            'Enter your Phone Number',
              style: TextStyle(color: Colors.yellow, fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Text('We will send a confirmation code to your phone', style: TextStyle(color: Colors.yellow),),
            Row(
              children: [
                Expanded(flex: 1,child: TextFormField(controller: countryCode,decoration: InputDecoration(labelText: 'Country', labelStyle: TextStyle(color: Colors.lightGreen,fontWeight: FontWeight.bold),focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),),),cursorColor: Colors.yellowAccent,style: TextStyle(color: Colors.white),),),
                SizedBox(width: 10,),
                Expanded(flex: 3,child: TextFormField(onChanged:(value){if(value.length==10){setState(() {
                  validate = true;
                });}
                if(value.length<10)
                {
                  setState(() {
                    validate = false;
                  });
                }},autofocus:true,maxLength:10,keyboardType: TextInputType.phone,controller: phoneNumber,decoration: InputDecoration(counterStyle: TextStyle(color: Colors.white),labelText: 'Number', hintText: 'Enter your phone', labelStyle: TextStyle(color: Colors.lightGreen,fontWeight: FontWeight.bold),hintStyle: TextStyle(color: Colors.white),focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),),),cursorColor: Colors.yellowAccent,style: TextStyle(color: Colors.white),),),
              ],
            ),
              Container(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AbsorbPointer(
                      absorbing: validate? false:true,
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: validate ? MaterialStateProperty.all(Theme.of(context).primaryColor):MaterialStateProperty.all(Colors.grey),),
                        onPressed: (){
                          progressDialog.show();
                          String number = '${countryCode.text}${phoneNumber.text}';

                          _service.verifyPhoneNumber(context, number);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Next', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),

                      ),
                    ),
                  ),
                ),
              )
          ],
          ),
        ),

    ),
    );
  }
}
