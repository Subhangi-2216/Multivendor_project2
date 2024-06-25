import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multivendor_ecommerce_app/controllers/auth_controller.dart';
import 'package:multivendor_ecommerce_app/utils/show_snackbar.dart';
import 'package:multivendor_ecommerce_app/views/buyers/auth/login_screen.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;

  late String fullName;

  late String phoneNumber;

  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController
          .signUpUsers(email, fullName, phoneNumber, password, _image)
          .whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      });

      return showSnack(
          context, 'Congratulations an account has been created for you!');
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Please field must not be empty');
    }
  }

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create Customer Account',
                  style: TextStyle(fontSize: 20),
                ),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundColor: Color.fromARGB(255, 241, 188, 142),
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundColor: Color.fromARGB(255, 241, 188, 142),
                            backgroundImage: NetworkImage(
                                'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg'),
                          ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: IconButton(
                        onPressed: () {
                          selectGalleryImage();
                        },
                        icon: Icon(
                          CupertinoIcons.photo,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      fullName = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Full Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'PhoneNumber must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Phone Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _signUpUser();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 241, 188, 142),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                ),
                              )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have An Account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      },
                      child: Text('Login'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
