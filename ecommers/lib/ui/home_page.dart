import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/category_item/categories_compact_widget.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_normal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).homePageTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CategoriesCompactWidget(),
          SizedBox(height: Dimens.pagePadding),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.pagePadding,
            ),
            child: Text(
              I18n.of(context).latetstTitle,
              style: Styles.titleText,
            ),
          ),
          SizedBox(height: 9.0),
          _buildLatestCarousel(),
          SizedBox(height: 11.0),
          Expanded(
            child: _buildLatestGridView(),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestCarousel() {
    return CarouselSlider(
      height: Dimens.imageCardSize.height,
      items: List.generate(
        3,
        (index) {
          return ImageCard(
            buttonText: 'Click me',
            description: 'item: $index SOOOOme looooong description',
            imageAsset: GIRL_IMAGE,
            onButtonPressed: () {},
          );
        },
      ),
    );
  }

  Widget _buildLatestGridView() {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 20.0,
      padding: EdgeInsets.symmetric(horizontal: Dimens.pagePadding),
      children: List.generate(30, (index) {
        return Center(
          child: ProductItemNormal(
            assetImagePath: BACKPACK_IMAGE,
            cost: 15.0,
            title: 'top back pack',
            rate: 3.9,
          ),
        );
      }),
    );
  }
}
