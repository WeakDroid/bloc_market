import 'package:bloc_market_app/features/home/home_bloc/home_bloc.dart';
import 'package:bloc_market_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import '../features/home/models/home_product_data_model.dart';
import '../features/product_details/ui/product_detail_page.dart';
import '../styles/colors.dart';

class ProductTile extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  const ProductTile(
      {super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              productName: productDataModel.name,
              productPrice: productDataModel.price,
              productDescription: productDataModel.description,
              productImageUrl: productDataModel.imageUrl,
            ),
          ),
        );
      },
      child: _buildContentContainer(context),
    );
  }

  Widget _buildContentContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey800, width: 0.8),
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(productDataModel.imageUrl),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            productDataModel.name,
            style: AppTextStyles.titleStyle,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            productDataModel.description,
            style: AppTextStyles.buttonDark,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$ ${productDataModel.price}",
                style: AppTextStyles.priceStyle,
              ),
              _buildIconsRow(context)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIconsRow(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              homeBloc.add(HomeProductWishlistButtonClickedEvent(
                  clickedProduct: productDataModel, context: context));
            },
            icon: const Icon(
              Icons.favorite_outline,
              size: 28,
            )),
        IconButton(
            onPressed: () {
              homeBloc.add(HomeProductCartButtonClickedEvent(
                  clickedProduct: productDataModel, context: context));
            },
            icon: const Icon(
              Icons.shopping_bag_outlined,
              size: 28,
            )),
        const SizedBox(
          width: 8,
        )
      ],
    );
  }
}
