import 'package:flutter/material.dart';
import 'package:multivendor_ecommerce_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ShippingTabScreen extends StatefulWidget {
  @override
  State<ShippingTabScreen> createState() => _ShippingTabScreenState();
}

class _ShippingTabScreenState extends State<ShippingTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool? _chargeShipping = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Column(
      children: [
        CheckboxListTile(
          title: Text(
            'Charge Shipping',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
          value: _chargeShipping,
          onChanged: (value) {
            setState(() {
              _chargeShipping = value;
              _productProvider.getFormData(chargeShipping: _chargeShipping);
            });
          },
        ),
        if (_chargeShipping == true)
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: ((value) {
                if (value!.isEmpty) {
                  return 'Enter Shipping Charge';
                } else {
                  return null;
                }
              }),
              onChanged: (value) {
                _productProvider.getFormData(shippingCharge: int.parse(value));
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Shipping Charge',
              ),
            ),
          )
      ],
    );
  }
}