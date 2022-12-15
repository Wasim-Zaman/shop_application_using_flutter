import 'package:flutter/material.dart';

import '../components/my_components.dart' as component;
import '../providers/product.dart';

class AddOrEditProductsPage extends StatefulWidget {
  const AddOrEditProductsPage({super.key});

  static const pageName = '/add-edit-products-page';

  @override
  State<AddOrEditProductsPage> createState() => _AddOrEditProductsPageState();
}

class _AddOrEditProductsPageState extends State<AddOrEditProductsPage> {
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _imageUrlFocusNode = FocusNode();
  final TextEditingController _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _newProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_whenFocusChanges);

    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_whenFocusChanges);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _whenFocusChanges() {
    if (!_imageUrlFocusNode.hasFocus) {
      // when the image url text field will loss focus, we will simply
      // rebuild the whole page so that the image is shown based on the
      // value of the imageUrlController.

      /* DON'T SHOW PREVIEW IF WE HAVE INCORRECT URL */

      // Similarly don't show a preview if we have incorrect URL.

      if (((!_imageUrlController.text.startsWith('https') &&
              !_imageUrlController.text.startsWith('http'))) ||
          ((!_imageUrlController.text.endsWith('png') &&
              !_imageUrlController.text.endsWith('jpg') &&
              !_imageUrlController.text.endsWith('jpeg')))) {
        return;
      }

      // Update the screen only for correct image url
      setState(() {
        // print('focus lost');
      });
    }
    // else {
    //   print('focus gained');
    // }
  }

  void _saveForm() {
    // in order to save the form, we need access to the form widget,
    // for that we will need Global Key to access or interact with the form.
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
      // do not let the below code to be executed if form is not valid
      // for every text form field.
    }
    _formKey.currentState!.save();
    component.mySnackbar("Saved", "Product saved successfully");
    // print(_newProduct.id);
    // print(_newProduct.title);
    // print(_newProduct.price);
    // print(_newProduct.description);
    // print(_newProduct.imageUrl);
  }

  bool isNumeric(String str) {
    try {
      var value = double.parse(str);
    } on FormatException {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: component.appBar(const Text('Add / Edit'), []),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decorationColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                  cursorColor: Theme.of(context).primaryColor,
                  onSaved: (newValue) {
                    _newProduct = Product(
                      id: _newProduct.id,
                      title: newValue!,
                      description: _newProduct.description,
                      price: _newProduct.price,
                      imageUrl: _newProduct.imageUrl,
                    );
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please provide a value";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Price",
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decorationColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  focusNode: _priceFocusNode,
                  keyboardType: TextInputType.number,
                  cursorColor: Theme.of(context).primaryColor,
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_descriptionFocusNode),
                  onSaved: (newValue) {
                    _newProduct = Product(
                      id: _newProduct.id,
                      title: _newProduct.title,
                      description: _newProduct.description,
                      price: double.parse(newValue!),
                      imageUrl: _newProduct.imageUrl,
                    );
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a price";
                    }
                    if (!isNumeric(value)) {
                      return "Please enter numeric value";
                    }
                    // if (double.tryParse(value) == null) {
                    //   return "Please enter numeric value";
                    // }

                    if (double.parse(value) <= 0) {
                      return "Please enter a price greater then zero";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decorationColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (newValue) {
                    _newProduct = Product(
                      id: _newProduct.id,
                      title: _newProduct.title,
                      description: newValue!,
                      price: _newProduct.price,
                      imageUrl: _newProduct.imageUrl,
                    );
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter description";
                    }
                    if (value.length <= 10) {
                      return 'Should be greater than 10 characters';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        right: 12,
                      ),
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: FittedBox(
                        child: _imageUrlController.text.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text("No Image URL"),
                              )
                            : Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                                // loadingBuilder: (context, child, loadingProgress) =>
                                //     const CircularProgressIndicator(),
                              ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter Image URL",
                          labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            decorationColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        controller: _imageUrlController,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (value) {
                          setState(() {
                            _saveForm();
                          });
                        },
                        onSaved: (newValue) {
                          _newProduct = Product(
                            id: _newProduct.id,
                            title: _newProduct.title,
                            description: _newProduct.description,
                            price: _newProduct.price,
                            imageUrl: newValue!,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter an image URL";
                          }
                          if (!value.startsWith('https') &&
                              !value.startsWith('http')) {
                            return "Please enter a valid URL";
                          }
                          if (!value.endsWith('png') &&
                              !value.endsWith('jpg') &&
                              !value.endsWith('jpeg')) {
                            return "Please enter a valid image URL";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text('Save Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
