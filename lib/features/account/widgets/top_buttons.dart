import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

/* class TopButtons extends StatelessWidget {
const TopButtons({ super.key });

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text('Add to Cart'),
            ),
            const SizedBox(width: 10,),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text('Buy Now'),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text('EMI options'),
        ),
        const SizedBox(height: 10,),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text('View More'),
        ),
      ],
    );
  }
} */

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AccountButton(
              text: 'Your Orders',
              onTap: () {},
            ),
            AccountButton(
              text: 'Turn Seller',
              onTap: () {},
            ),
          ],
        ),
        // const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () {}
              //  AccountServices().logOut(context),
            ),
            AccountButton(
              text: 'Your Wish List',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

