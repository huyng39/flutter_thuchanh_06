import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/model/product.dart';
import '../../data/helper/product_helper.dart';

class ProductAdd extends StatefulWidget {
  final bool isUpdate;
  final Product_Model? productModel;
  const ProductAdd({super.key, this.isUpdate = false, this.productModel});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _catIdController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();
  String titleText = "";
  final DatabaseHelper _databaseService = DatabaseHelper();
  Future<void> _onSave() async {
    final name = _nameController.text;
    final description = _descController.text;
    final price = int.parse(_priceController.text);
    final catId = int.parse(_catIdController.text);
    final image = _imgController.text;
    await _databaseService
        .insertProduct(Product_Model(name: name, price: price, des: description,img: image, catId: catId));
    setState(() {});
    Navigator.pop(context);
  }

  Future<void> _onUpdate() async {
    final name = _nameController.text;
    final description = _descController.text;
    final price = int.parse(_priceController.text);
    final catId = int.parse(_catIdController.text);
    final image = _imgController.text;

    await _databaseService.updateProduct(Product_Model(name: name, price: price, des: description,img: image, catId: catId));

    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.productModel != null && widget.isUpdate) {
      _nameController.text = widget.productModel!.name;
      _descController.text = widget.productModel!.desc;
      _priceController.text = widget.productModel!.price;
      _descController.text = widget.productModel!.desc;
      _descController.text = widget.productModel!.desc;
      _descController.text = widget.productModel!.desc;
    }
    if (widget.isUpdate) {
      titleText = "Update Category";
    } else
      titleText = "Add New Category";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descController,
              maxLines: 7,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter description',
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: () {
                  widget.isUpdate ? _onUpdate() : _onSave();
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16.0,
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
