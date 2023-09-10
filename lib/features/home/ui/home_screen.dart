import 'package:bloc_market_app/features/home/models/home_product_data_model.dart';
import 'package:bloc_market_app/features/wishlist/ui/wishlist.dart';
import 'package:bloc_market_app/styles/text_styles.dart';
import 'package:bloc_market_app/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/base_state.dart';
import '../../../styles/colors.dart';
import '../../../widgets/custom_search_field.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../cart/ui/cart.dart';
import '../home_bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends BaseState<Home> {
  final HomeBloc homeBloc = HomeBloc();
  String query = '';

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          navigate(const Cart());
        } else if (state is HomeNavigateToWishlistPageActionState) {
          navigate(const Wishlist());
        } else if (state is HomeProductItemCartedActionState) {
          CustomSnackBar.show(
            context: context,
            text: 'Item carted',
            icon: Icons.done,
            iconColor: AppColors.neon,
          );
        } else if (state is HomeProductItemWishlistedActionState) {
          CustomSnackBar.show(
            context: context,
            text: 'Item wishlisted',
            icon: Icons.done,
            iconColor: AppColors.neon,
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            final filteredProducts = successState.products.where((product) {
              return product.name.toLowerCase().contains(query.toLowerCase());
            }).toList();
            return _buildSuccessState(context, filteredProducts);
          case HomeErrorState:
            return const Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Text('Something went wrong'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget _buildSuccessState(
      BuildContext context, List<ProductDataModel> filteredProducts) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.grey400,
          title: const Text(
            'Bloc Market App',
            style: AppTextStyles.appBarStyle,
          ),
          actions: [
            IconButton(
              onPressed: () {
                homeBloc.add(HomeWishlistButtonNavigateEvent());
              },
              icon: const Icon(
                Icons.favorite_outline,
                size: 26,
              ),
            ),
            IconButton(
              onPressed: () {
                homeBloc.add(HomeCartButtonNavigateEvent());
              },
              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 26,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        body: _buildSearchField(filteredProducts),
      ),
    );
  }

  Column _buildSearchField(List<ProductDataModel> filteredProducts) {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CustomTextField(
              hintText: 'Find some products...',
              onChanged: (newQuery) {
                setState(() {
                  query = newQuery;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return ProductTile(
                  productDataModel: filteredProducts[index],
                  homeBloc: homeBloc,
                );
              },
            ),
          ),
        ],
      );
  }
}
