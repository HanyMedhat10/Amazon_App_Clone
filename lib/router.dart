import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screens.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

MaterialPageRoute generateRouter(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AddProductScreen(),
      );
    case SearchScreen.routeName:
      final searchQuery = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailScreen.routeName:
      final Product product = settings.arguments as Product;
      return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProductDetailScreen(
                product: product,
              ));
    case CategoryDealsScreen.routeName:
      final category = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => CategoryDealsScreen(category: category),
      );
    case AddressScreen.routeName:
        final totalAmount = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => AddressScreen(totalAmount: totalAmount,),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
