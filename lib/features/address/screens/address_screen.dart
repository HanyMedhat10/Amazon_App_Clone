import 'package:amazon_clone/common/widgets/custom_app_bar_search.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();
  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final List<PaymentItem> _paymentItems = [];
  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('gpay.json');
  final Future<PaymentConfiguration> _applePayConfigFuture =
      PaymentConfiguration.fromAsset('applepay.json');
  final AddressServices addressServices = AddressServices();
  String addressToBeUsed = '';

  @override
  void initState() {
    super.initState();
    _paymentItems.add(
      PaymentItem(
        label: 'Total Amount',
        amount: widget.totalAmount,
        // amount: 0.0.toString(),
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pinCodeController.dispose();
    _cityController.dispose();
  }

  void onApplePayResult(res) {
    debugPrint('res: $res');
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
      addressServices.placeOrder(
          context: context,
          address: addressToBeUsed,
          totalSum: double.parse(widget.totalAmount));
    }
  }

  void onGooglePayResult(res) {
    debugPrint('res: $res');
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
      addressServices.placeOrder(
          context: context,
          address: addressToBeUsed,
          totalSum: double.parse(widget.totalAmount));
    }
  }

  void payPressed(String addressFromProvider) {
    debugPrint('addressFromProvider: $addressFromProvider');
    addressToBeUsed = "";
    bool isForm = _flatBuildingController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _pinCodeController.text.isNotEmpty ||
        _cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed = '${_flatBuildingController.text}, '
            '${_areaController.text}, '
            '${_cityController.text}, -'
            '${_pinCodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR', error: true);
    }
    debugPrint('addressToBeUsed: $addressToBeUsed');
    // Navigator.pushNamed(context, '/checkout', arguments: {
    //   'totalAmount': widget.totalAmount,
    //   'address': addressToBeUsed
    // });
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    // String address = '101 fake Street 12th St, New York, NY 10110';
    return Scaffold(
      appBar: CustomAppBarSearch(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            address.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    // ? this here is for create User (sign up)
                    CustomTextfield(
                      controller: _flatBuildingController,
                      hintText: 'Flat, House no., Building, Company, Landmark',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: _areaController,
                      hintText: 'Area, Street, Sector, Village',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: _pinCodeController,
                      hintText: 'PinCode, City, State',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: _cityController,
                      hintText: 'Town/City/District',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<PaymentConfiguration>(
              future: _applePayConfigFuture,
              builder: (context, snapshot) => snapshot.hasData
                  ? ApplePayButton(
                      onPressed: () => payPressed(address),
                      width: double.infinity,
                      paymentConfiguration: snapshot.data!,
                      paymentItems: _paymentItems,
                      type: ApplePayButtonType.buy,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: onApplePayResult,
                      loadingIndicator: const Center(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            FutureBuilder<PaymentConfiguration>(
                future: _googlePayConfigFuture,
                builder: (context, snapshot) => snapshot.hasData
                    ? GooglePayButton(
                        onPressed: () => payPressed(address),
                        width: double.infinity,
                        paymentConfiguration: snapshot.data!,
                        paymentItems: _paymentItems,
                        type: GooglePayButtonType.buy,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: onGooglePayResult,
                        loadingIndicator: const Center(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      )
                    : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
