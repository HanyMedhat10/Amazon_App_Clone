import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screens.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminServices adminServices = AdminServices();
  List<Product> products = [];
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  deleteProduct(String id, int index) {
    adminServices.deleteProduct(
      context: context,
      id: id,
      onSuccess: () async {
        products.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final productData = products[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(
                        image: productData.images[0],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteProduct(
                            productData.id!,
                            index,
                          ),
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add a product',
        backgroundColor: const Color.fromARGB(255, 114, 226, 221),
        foregroundColor: Colors.black,
        shape: const StadiumBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
