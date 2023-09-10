import 'package:bloc_market_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import '../features/home/models/home_product_data_model.dart';
import '../features/product_details/ui/product_detail_page.dart';
import '../features/wishlist/wishlist_bloc/wishlist_bloc.dart';
import '../styles/colors.dart';
import 'custom_snack_bar.dart';

class WishlistTile extends StatelessWidget {
  final ProductDataModel productDataModel;
  final WishlistBloc wishlistBloc;

  const WishlistTile(
      {super.key, required this.productDataModel, required this.wishlistBloc});

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
              wishlistBloc.add(WishlistRemoveFromWishlistEvent(
                  productDataModel: productDataModel));
              CustomSnackBar.show(
                context: context,
                text: 'Item removed from wishlist',
                icon: Icons.done,
                iconColor: AppColors.neon,
              );
            },
            icon: const Icon(
              Icons.favorite,
              size: 28,
            )),
        IconButton(
            onPressed: () {},
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
