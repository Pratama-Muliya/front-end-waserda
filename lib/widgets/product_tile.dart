import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waserda/models/product_model.dart';
import 'package:waserda/pages/product_page.dart';
import 'package:waserda/theme.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.galleries[0].url,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.name,
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    product.name,
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(3.0),
                  //   child: Text(
                  //     NumberFormat.currency(
                  //             locale: 'id-ID',
                  //             symbol: 'Stock : ',
                  //             decimalDigits: 0)
                  //         .format(product.stock),
                  //     style: stockTextStyle.copyWith(fontSize: 9),
                  //   ),
                  // ),
                  Text(
                    NumberFormat.currency(
                            locale: 'id-ID', symbol: 'IDR ', decimalDigits: 0)
                        .format(product.price),
                    style: priceTextStyle.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
