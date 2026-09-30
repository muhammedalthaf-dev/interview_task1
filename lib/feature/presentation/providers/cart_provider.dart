import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  const CartItem({
    required this.product,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => product.price * quantity;
  double get originalPrice => (product.price * 1.25) * quantity;
  double get savings => originalPrice - totalPrice;
}

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];

  void addToCart(Product product, {int quantity = 1}) {
    final existingIndex =
        state.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      final currentItem = state[existingIndex];
      final updatedList = [...state];
      updatedList[existingIndex] = currentItem.copyWith(
        quantity: currentItem.quantity + quantity,
      );
      state = updatedList;
    } else {
      state = [...state, CartItem(product: product, quantity: quantity)];
    }
  }

  void incrementQuantity(int productId) {
    final existing =
        state.where((item) => item.product.id == productId).firstOrNull;
    if (existing != null) {
      updateQuantity(productId, existing.quantity + 1);
    }
  }

  void decrementQuantity(int productId) {
    final existing =
        state.where((item) => item.product.id == productId).firstOrNull;
    if (existing != null) {
      updateQuantity(productId, existing.quantity - 1);
    }
  }

  void removeFromCart(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }
    state = [
      for (final item in state)
        if (item.product.id == productId)
          item.copyWith(quantity: quantity)
        else
          item,
    ];
  }

  void clearCart() {
    state = [];
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);

final cartTotalCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.quantity);
});

final cartTotalPriceProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0.0, (sum, item) => sum + item.totalPrice);
});

final cartTotalSavingsProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0.0, (sum, item) => sum + item.savings);
});

final cartDeliveryFeeProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartTotalPriceProvider);
  if (subtotal == 0 || subtotal >= 499) {
    return 0.0;
  }
  return 29.0;
});

final cartGrandTotalProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartTotalPriceProvider);
  if (subtotal == 0) return 0.0;
  final delivery = ref.watch(cartDeliveryFeeProvider);
  const platformFee = 4.0;
  return subtotal + delivery + platformFee;
});
