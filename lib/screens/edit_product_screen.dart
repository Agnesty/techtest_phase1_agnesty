import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/product_ctr.dart';
import '../services/loading_status.dart';

// ignore: must_be_immutable
class EditProductScreen extends StatefulWidget {
  static const routeName = "/editproductscreen";
  String? id;
  bool? iniEdit;
  String? initialTitle;
  String? initialPrice;
  String? initialGambar;
  EditProductScreen(
      {this.id,
      this.iniEdit,
      this.initialGambar,
      this.initialPrice,
      this.initialTitle,
      super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _productController = Get.put(ProductCtr());
  final _gambarFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  final _gambarController = TextEditingController();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    _gambarFocusNode.addListener(_updateImageUrl);
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _priceController.text = widget.initialPrice ?? '';
    _gambarController.text = widget.initialGambar ?? '';
  }

  final loadingStatus = LoadingStatus.loading.obs;

  @override
  void dispose() {
    _gambarFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _gambarFocusNode.dispose();
    _gambarController.dispose();
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_gambarFocusNode.hasFocus) {
      if ((!_gambarController.text.startsWith('http') &&
              !_gambarController.text.startsWith('https')) ||
          (_gambarController.text.endsWith('.png') &&
              _gambarController.text.endsWith('.jpg') &&
              _gambarController.text.endsWith('.jpeg'))) {
        return;
      }

      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    String title = _titleController.text;
    String price = _priceController.text;
    String gambar = _gambarController.text;
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      print("Form validation failed!");
      return;
    }
    _form.currentState!.save();
    setState(() {
      loadingStatus.value = LoadingStatus.loading;
    });
    if (widget.iniEdit! == true) {
      await _productController.updateProduct(widget.id!, title, price, gambar);
    } else {
      try {
        await _productController.addProduct(title, price, gambar);
      } catch (error) {
        // print("Error adding product: $error");
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('An error occured!'),
                  content: Text('Something went wrong! : $error'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('Okay'),
                    )
                  ],
                ));
      }
    }
    setState(() {
      loadingStatus.value = LoadingStatus.completed;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your Product',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            if(widget.iniEdit == true)
            IconButton(
                onPressed: () {
                  _productController.deleteData(widget.id!);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red[700],
                  size: 25,
                ))
            
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: _form,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    inputFormatters: [CapitalizeTextFormatter()],
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_gambarFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Please enter a number greater than zero';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 8, right: 20),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: _gambarController.text.isEmpty
                            ? const Center(child: Text('Enter a URL'))
                            : FittedBox(
                                child: Image.network(
                                  _gambarController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _gambarController,
                          focusNode: _gambarFocusNode,
                          onEditingComplete: () {
                            setState(() {});
                          },
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an image URL';
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL';
                            }
                            if (value.endsWith('.png') &&
                                value.endsWith('.jpg') &&
                                value.endsWith('.jpeg')) {
                              return 'Please enter a valid image URL.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //Save data
            _saveForm();
          },
          label: const Row(
            children: [
              Icon(Icons.save_rounded),
              SizedBox(
                width: 5,
              ),
              Text(
                'Saved',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          elevation: 10,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}

class CapitalizeTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.capitalize!,
      selection: newValue.selection,
    );
  }
}
