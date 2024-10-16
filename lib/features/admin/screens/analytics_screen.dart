import 'package:amazon_clone/features/admin/model/sales.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/category_product_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  num? totalEarnings;
  List<Sales>? sales;
  void getEarnings() {
    adminServices.getEarnings(context: context).then((value) {
      setState(() {
        totalEarnings = value['totalEarnings'];
        sales = value['sales'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return totalEarnings == null || sales == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Text('\$$totalEarnings',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1.6,
                  child: CategoryProductChart(
                      sales: sales!, totalEarnings: totalEarnings!),
                ),
              )
            ],
          );
  }
}
