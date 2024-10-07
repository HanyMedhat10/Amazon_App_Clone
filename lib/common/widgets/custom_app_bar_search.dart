import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
PreferredSize CustomAppBarSearch(BuildContext context) {
  void navigateToSearchScreen(String query) {
    Navigator.pop(context, query);
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 42,
              margin: const EdgeInsets.only(left: 15),
              child: Material(
                borderRadius: BorderRadius.circular(7),
                elevation: 1,
                child: TextFormField(
                  onFieldSubmitted: navigateToSearchScreen,
                  decoration: InputDecoration(
                    prefixIcon: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 23,
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(top: 10),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black38,
                        width: 1,
                      ),
                    ),
                    hintText: 'Search Amazon.in',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: 42,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: const Icon(
              Icons.mic,
              color: Colors.black,
              size: 25,
            ),
          ),
        ],
      ),
    ),
  );
}
