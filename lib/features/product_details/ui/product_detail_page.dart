import 'package:bloc_market_app/styles/button_styles.dart';
import 'package:bloc_market_app/styles/colors.dart';
import 'package:bloc_market_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../../widgets/quantity_buttons.dart';

class ProductDetailPage extends StatefulWidget {
  final String productName;
  final double productPrice;
  final String productDescription;
  final String productImageUrl;

  const ProductDetailPage({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productImageUrl,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int itemCount = 1;
  double totalCost = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.darkNeon,
          title: const Text('Product details'),
        ),
        body: SafeArea(
          child: _buildScreen(),
        ));
  }

  Widget _buildScreen() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(''),
          _buildCenterContent(),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildCenterContent() {
    return Column(
      children: [
        Image.network(
          widget.productImageUrl,
          width: double.infinity,
          height: 200.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        Text(widget.productName, style: AppTextStyles.titleStyle),
        const SizedBox(height: 16),
        Text('Price: \$${widget.productPrice.toStringAsFixed(2)}',
            style: AppTextStyles.priceStyle),
        const SizedBox(height: 16),
        const Text(
          'Product description',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(widget.productDescription, style: AppTextStyles.buttonDark),
      ],
    );
  }

  Widget _buildButton() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quantity:  ${itemCount.toString()}',
                  style: AppTextStyles.buttonDark,
                ),
                const SizedBox(height: 8),
                Text(
                  'Total:  \$${(itemCount * widget.productPrice).toStringAsFixed(2)}',
                  style: AppTextStyles.buttonDark,
                ),
              ],
            ),
            QuantityButtons(
              itemCount: itemCount,
              productPrice: widget.productPrice,
              onIncrement: (newCount) {
                setState(() {
                  itemCount = newCount;
                  totalCost = itemCount * widget.productPrice;
                });
              },
              onDecrement: (newCount) {
                setState(() {
                  itemCount = newCount;
                  totalCost = itemCount * widget.productPrice;
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              CustomSnackBar.show(
                context: context,
                text:
                    'Purchase successful! You spent  \$${(itemCount * widget.productPrice).toStringAsFixed(2)}',
                icon: Icons.shopping_cart,
                iconColor: AppColors.neon,
              );
            },
            child: const Text(
              'Buy',
              style: AppTextStyles.button,
            ),
          ),
        ),
      ],
    );
  }
}
