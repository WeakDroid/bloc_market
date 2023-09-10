import 'dart:async';
import 'package:bloc_market_app/data/cart_items.dart';
import 'package:bloc_market_app/data/wishlist_items.dart';
import 'package:bloc_market_app/styles/colors.dart';
import 'package:bloc_market_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/grocery_data.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../models/home_product_data_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                imageUrl: e['imageUrl']))
            .toList()));
  }
}

FutureOr<void> homeProductWishlistButtonClickedEvent(
    HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
  if (!wishlistItems.contains(event.clickedProduct)) {
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  } else {
    CustomSnackBar.show(
      context: event.context,
      text: 'The product is already in wishlist',
      icon: Icons.error_outline,
      iconColor: AppColors.alertRed,
    );
  }
}

FutureOr<void> homeProductCartButtonClickedEvent(
    HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
  if (!cartItems.contains(event.clickedProduct)) {
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  } else {
    CustomSnackBar.show(
      context: event.context,
      text: 'The product is already in cart list',
      icon: Icons.error_outline,
      iconColor: AppColors.alertRed,
    );
  }
}

FutureOr<void> homeWishlistButtonNavigateEvent(
    HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
  emit(HomeNavigateToWishlistPageActionState());
}

FutureOr<void> homeCartButtonNavigateEvent(
    HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
  emit(HomeNavigateToCartPageActionState());
}
