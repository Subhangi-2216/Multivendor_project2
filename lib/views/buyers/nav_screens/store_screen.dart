import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multivendor_ecommerce_app/views/buyers/productDetail/store_detail_screen.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _storesStream = FirebaseFirestore.instance
        .collection('vendors')
        .where('approved', isEqualTo: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _storesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 241, 188, 142),
            ),
          );
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 80, left: 40),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Store Owners',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        final storeData = snapshot.data!.docs[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return StoreDetailScreen(
                                storeData: storeData,
                              );
                            }));
                          },
                          child: ListTile(
                            title: Text(
                              storeData['bussinessName'],
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(storeData['countryValue']),
                            leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(storeData['storeImage'])),
                          ),
                        );
                      })),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
