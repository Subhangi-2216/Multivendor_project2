import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multivendor_ecommerce_app/provider/product_provider.dart';
import 'package:multivendor_ecommerce_app/vendor/views/screens/main_vendor_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDv68FG04USivK16BSGwT5D5ccfgZmRgUk',
          appId: 'com.subhangi.multivendor_ecommerce_app',
          messagingSenderId: '855760917639',
          projectId: 'subhangi-multivendor-store',
          storageBucket: 'subhangi-multivendor-store.appspot.com'));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) {
      return ProductProvider();
    })
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Brand-Bold',
      ),
      home: MainVendorScreen(),
    );
  }
}
