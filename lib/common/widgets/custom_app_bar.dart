import 'package:amazon_clone/constant/global_variable.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
PreferredSizeWidget CustomAppBar(BuildContext context) => PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/amazon_in.png',
                width: 120,
                height: 45,
                color: Colors.black,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(Icons.notifications_outlined),
                  ),
                  Icon(Icons.search),
                ],
              ),
            ),
          ],
        ),
      ),
    );
