import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:multivendor_ecommerce_app/vendor/models/vendor_user_models.dart';
import 'package:multivendor_ecommerce_app/vendor/views/screens/main_vendor_screen.dart';
import 'package:multivendor_ecommerce_app/vendor/views/screens/landing_screen.dart';

class VendorAuthScreen extends StatelessWidget {
  const VendorAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _vendorsStream =
        FirebaseFirestore.instance.collection('vendors');
    // print("Hello worldddddd");

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        initialData: _auth.currentUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(
              providers: [
                EmailAuthProvider(),
              ],
            );
          }

          return FutureBuilder<DocumentSnapshot>(
            future: _vendorsStream.doc(_auth.currentUser!.uid).get(),
            builder: (context, vendorSnapshot) {
              if (vendorSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (vendorSnapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (vendorSnapshot.data?.exists ?? false) {
                VendorUserModel vendorUserModel = VendorUserModel.fromJson(
                    vendorSnapshot.data!.data()! as Map<String, dynamic>);

                if (vendorUserModel.approved == true) {
                  return MainVendorScreen();
                }
              }

              return LandingScreen();
            },
          );
        },
      ),
    );
  }
}
