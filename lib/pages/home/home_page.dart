import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waserda/models/user_model.dart';
import 'package:waserda/providers/auth_provider.dart';
import 'package:waserda/providers/product_provider.dart';
import 'package:waserda/theme.dart';
import 'package:waserda/widgets/product_card.dart';
import 'package:waserda/widgets/product_tile.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (authProvider.user != null)
                    Text(
                      'Hallo, ${user.name}',
                      style: primaryTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                    ),
                  Text(
                    'Selamat Datang Di Waserda ',
                    // '@${user.username}',
                    style: subtitleTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      ("https://scontent.fdps3-1.fna.fbcdn.net/v/t1.6435-9/204849967_337802364655372_3473989799936335582_n.jpg?_nc_cat=109&ccb=1-3&_nc_sid=730e14&_nc_eui2=AeHxbqkWNfpNv5PHxzgn3dIB94IcUnNUNKb3ghxSc1Q0pgTGdmsSPd2ivIZ55FivaoWeckfmji_Sf4_ii_zaFDiP&_nc_ohc=8URQ4JbagF0AX8NYW7T&_nc_ht=scontent.fdps3-1.fna&oh=a715ec3499e6bad808db74b403a8e0b6&oe=60E0D414")
                      // user.profilePhotoUrl,
                      ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget categories() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Container(
          height: 40,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: productProvider.category.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  productProvider.idCategory =
                      productProvider.category[index].id;
                  if (index == 0) {
                    productProvider.isCategory = false;
                  } else {
                    productProvider.isCategory = true;
                    productProvider
                        .getProductsByName(productProvider.category[index].id);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  margin: EdgeInsets.only(
                      right: 16, left: index == 0 ? defaultMargin : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: productProvider.idCategory ==
                            productProvider.category[index].id
                        ? primaryColor
                        : Colors.white,
                    border: productProvider.idCategory ==
                            productProvider.category[index].id
                        ? null
                        : Border.all(color: Color(0xFF504F5E), width: 0.5),
                  ),
                  child: Text(
                    productProvider.category[index].name,
                    style: primaryTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: medium,
                      color: productProvider.idCategory ==
                              productProvider.category[index].id
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    Widget popularProductsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Popular Products',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget popularProducts() {
      return Container(
        margin: EdgeInsets.only(top: 14),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Row(
                children: productProvider.products
                    .map(
                      (product) => ProductCard(product),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      );
    }

    Widget newArrivalsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Produk Terbaru',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget categoryTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Untuk Kamu',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget newArrivals() {
      return Container(
        margin: EdgeInsets.only(
          top: 14,
        ),
        child: Column(
          children: productProvider.products
              .map(
                (product) => ProductTile(product),
              )
              .toList(),
        ),
      );
    }

    Widget productsCategory() {
      return Container(
        margin: EdgeInsets.only(
          top: 14,
        ),
        child: Column(
          children: productProvider.productsCategory
              .map(
                (product) => ProductTile(product),
              )
              .toList(),
        ),
      );
    }

    return ListView(
      children: [
        header(),
        categories(),
        productProvider.isCategory ? SizedBox() : popularProductsTitle(),
        productProvider.isCategory ? SizedBox() : popularProducts(),
        productProvider.isCategory ? categoryTitle() : newArrivalsTitle(),
        productProvider.isCategory ? productsCategory() : newArrivals(),
      ],
    );
  }
}
