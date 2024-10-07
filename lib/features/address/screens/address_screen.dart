import 'package:amazon_clone/common/widgets/custom_app_bar_search.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();
  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pinCodeController.dispose();
    _cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var address = context.watch<UserProvider>().user.address ??
    String address = '101 fake Street 12th St, New York, NY 10110';
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
                    const SizedBox(height: 10),
                    CustomButton(text: 'Sign Up', onPressed: () {}),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
