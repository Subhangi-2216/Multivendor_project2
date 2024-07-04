import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multivendor_ecommerce_app/views/buyers/productDetail/product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchedValue = "";

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 241, 188, 142),
        elevation: 0,
        title: TextFormField(
          onChanged: (value) {
            setState(() {
              _searchedValue = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Search for products',
            labelStyle: TextStyle(
              color: Colors.black,
              letterSpacing: 4,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: _searchedValue == ''
          ? Center(
              child: Text(
                'Search for products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: _productsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                final searchedData = snapshot.data!.docs.where((element) {
                  return element['productName']
                      .toLowerCase()
                      .contains(_searchedValue.toLowerCase());
                });

                return Column(
                  children: searchedData.map((e) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProductDetailScreen(
                            productData: e,
                          );
                        }));
                      },
                      child: Card(
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(e['imageUrl'][0]),
                            ),
                            Column(
                              children: [
                                Text(
                                  e['productName'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  e['productPrice'].toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 241, 188, 142),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
    );
  }
}
