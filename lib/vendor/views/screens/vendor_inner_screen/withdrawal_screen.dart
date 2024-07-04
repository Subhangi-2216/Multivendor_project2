import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class WithdrawalScreen extends StatefulWidget {
  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  late String amount;

  late String name;

  late String mobile;

  late String bankName;

  late String bankAccountName;

  late String bankAccountNumber;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 241, 188, 142),
        elevation: 0,
        title: Text(
          'Withdraw ',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 6,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Amount must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    amount = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    name = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mobile must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    mobile = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bank name must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    bankName = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Bank Name, Eg: Access Bank',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bank acc name must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    bankAccountName = value;
                  },
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Bank Account Name, Eg: Subhangi Lamichhane',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bank acc number must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    bankAccountNumber = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Bank Account Number',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      /// STORE DATE IN CLOUD FIRESTORE
                      EasyLoading.show(status: 'Please wait...');
                      try {
                        await _firestore
                            .collection('withdrawal')
                            .doc(Uuid().v4())
                            .set({
                          'Amount': amount,
                          'Name': name,
                          'Mobile': mobile,
                          'BankName': bankName,
                          'BankAccountName': bankAccountName,
                          'BankAccountNumber': bankAccountNumber,
                        });
                  //       EasyLoading.dismiss();
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(
                  //           content: Text('Data successfully stored!'),
                  //         ),
                  //       );
                  //     } catch (e) {
                  //       EasyLoading.dismiss();
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(
                  //           content: Text('Failed to store data.'),
                  //         ),
                  //       );
                  //     }
                  //   } else {
                  //     print('Validation failed');
                  //   }
                  // },
                                          EasyLoading.dismiss();
                        _clearFields();
                        Navigator.pop(context);
                        _showModalBottomSheet(context, 'Data successfully stored!');
                      } catch (e) {
                        EasyLoading.dismiss();
                        Navigator.pop(context);
                        _showModalBottomSheet(context, 'Failed to store data.');
                      }
                    } else {
                      print('Validation failed');
                    }
                  },

                  child: Text(
                    'Get Cash',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _clearFields() {
    _formkey.currentState!.reset();
  }

  void _showModalBottomSheet(BuildContext context, String message) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Text(
            message,
            style: TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }
}


