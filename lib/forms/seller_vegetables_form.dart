import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:kissan_mandi/forms/user_review_screen.dart';
import 'package:kissan_mandi/provider/cat_provider.dart';
import 'package:kissan_mandi/services/firebase_services.dart';
import 'package:kissan_mandi/widgets/imagePicker_widget.dart';
import 'package:provider/provider.dart';

class SellerVegForm extends StatefulWidget {

  static const String id = 'vegetable-form';

  @override
  State<SellerVegForm> createState() => _SellerVegFormState();
}

class _SellerVegFormState extends State<SellerVegForm> {
  final _formKey = GlobalKey<FormState>();

  FirebaseService _service = FirebaseService();

  var _typeController = TextEditingController();
  var _amountController = TextEditingController();
  var _priceController = TextEditingController();
  var _addressController = TextEditingController();
  var _titleController = TextEditingController();

  String _address = '';

  validate(CategoryProvider provider){
    if(_formKey.currentState.validate())
      {
        if(provider.urlList.isNotEmpty){
          provider.dataToFireStore.addAll({
            'category':provider.selectedCategory,
            'subCat' : provider.selectedSubCat,
            'type':_typeController,
            'amount' : _amountController,
            'price': _priceController,
            'title': _titleController,
            'sellerUid': _service.user.uid,
            'images': [provider.urlList],
          });

          print(provider.dataToFireStore);

          Navigator.pushNamed(context, UserReviewScreen.id);

        }
        else
          {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('image not uploaded'),
                )
            );
          }
      }
    else
      {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please complete required fields'),
            )
        );
      }
  }
  @override
  void didChangeDependencies() {
    var _catProvider = Provider.of<CategoryProvider>(context);

    setState(() {
      _typeController.text = _catProvider.dataToFireStore.isEmpty?null:_catProvider.dataToFireStore['type'];
      _amountController.text = _catProvider.dataToFireStore.isEmpty?null:_catProvider.dataToFireStore['amount'];
      _priceController.text = _catProvider.dataToFireStore.isEmpty?null:_catProvider.dataToFireStore['price'];
      _titleController.text = _catProvider.dataToFireStore.isEmpty?null:_catProvider.dataToFireStore['title'];
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var _catProvider = Provider.of<CategoryProvider>(context);
    Widget _appBar()
    {
      return AppBar(
        backgroundColor: Colors.lightGreen,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        title: Text('${_catProvider.selectedCategory} > types',style: TextStyle(color: Colors.white,fontSize: 14),),
      );
    }
    Widget _brandList(){
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            _appBar(),
            Expanded(
              child: ListView.builder(
                itemCount: _catProvider.doc['types'].length,
                  itemBuilder: (BuildContext context,int index){
                return ListTile(
                  onTap: (){
                    setState(() {
                      _typeController.text = _catProvider.doc['types'][index];
                    });
                    Navigator.pop(context);
                  },
                  title: Text(_catProvider.doc['types'][index]),
                );
              }),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Center(
          child: Text(
            'Add some details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body:SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('VEGETABLE',style: TextStyle(fontWeight: FontWeight.bold),),
                InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context){
                      return _brandList();
                    });
                  },
                  child: TextFormField(
                    controller: _typeController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Vegetable Name'
                    ),
                    validator: (value)
                    {
                      if(value.isEmpty) {
                        return 'Please fill the required field';
                      }
                      return null;
                    },
                  ),
                ),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Weight in Tons'
                  ),
                  validator: (value)
                  {
                    if(value.isEmpty) {
                      return 'Please fill the required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '₹',
                      labelText: 'Base Price'
                  ),
                  validator: (value)
                  {
                    if(value.isEmpty) {
                      return 'Please fill the required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLength: 50,
                  controller: _titleController,
                  decoration: InputDecoration(
                      labelText: 'Add title',
                    counterText: 'can mention specific quality (eg. Alfanso mango, fresh tomato)',
                  ),
                  validator: (value)
                  {
                    if(value.isEmpty) {
                      return 'Please fill the required field';
                    }
                    return null;
                  },
                ),

                Divider(color: Colors.grey,),
                Container(
                  width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: _catProvider.urlList.length==0?Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('No image selected',textAlign: TextAlign.center,),
                    ):GalleryImage(
                      imageUrls: _catProvider.urlList,
                    ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){



                    showDialog(context: context, builder: (BuildContext context){
                      return ImagePickerWidget();
                    });
                  },
                  child: Container(
                    color: Colors.yellow,
                    height: 40,
                    child: Center(child: Text(_catProvider.urlList.length>0?'Upload more Images':'Upload Image', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                    fontWeight: FontWeight.bold),),
                ),
                onPressed: (){
                  validate(_catProvider);
                  print(_catProvider.dataToFireStore);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
