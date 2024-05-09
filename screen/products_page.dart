import 'package:flutter/material.dart';
import 'package:grocery_store_app/model/db_helper.dart';
import 'package:grocery_store_app/model/items_model.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final DBHelper _dbHelper = DBHelper();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _dbHelper.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var product = snapshot.data![index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text(product.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _nameController.text = product.name;
                                _descriptionController.text = product.description;
                                showDialog(
                                  context: context,
                                  builder: (context) => editProductDialog(context, product),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _dbHelper.deleteProduct(product.id!);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Product Description'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final newProduct = Product(name: _nameController.text, description: _descriptionController.text);
              _dbHelper.insertProduct(newProduct);
              setState(() {
                _nameController.clear();
                _descriptionController.clear();
              });
            },
            child: Text('Add Product'),
          ),
        ],
      ),
    );
  }

  Widget editProductDialog(BuildContext context, Product product) {
    return AlertDialog(
      title: Text('Edit Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Product Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _dbHelper.updateProduct(Product(id: product.id, name: _nameController.text, description: _descriptionController.text));
            Navigator.of(context).pop();
            setState(() {});
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}