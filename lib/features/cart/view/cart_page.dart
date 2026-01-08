import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techsaint_task/core/animations/cart/cart_list_loader.dart';
import 'package:techsaint_task/core/constants/constants.dart';
import 'package:techsaint_task/core/constants/theme_notifier.dart';
import 'package:techsaint_task/features/cart/model/state/cart_state.dart';
import 'package:techsaint_task/features/cart/view%20model/cart_notifier.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final isLightTheme = ref.watch(themeProvider);
    final cartState = ref.watch(cartNotifier);
    final notifier = ref.read(cartNotifier.notifier);

    final bgColor = isLightTheme ? Colors.white : const Color(0xFF121212);
    final appBarColor = isLightTheme ? Colors.white : const Color(0xFF1F1F1F);
    final textColor = isLightTheme ? Colors.black : Colors.white70;
    final subTextColor = isLightTheme ? Colors.grey[600] : Colors.grey[400];
    final shadowColor = isLightTheme
        ? Colors.grey.withOpacity(0.1)
        : Colors.black.withOpacity(0.3);
    final priceColor = isLightTheme ? Colors.green : Colors.greenAccent[400];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
        backgroundColor: appBarColor,
        elevation: 1,
        foregroundColor: textColor,
      ),
      body: cartState.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const CartListLoader(),
        error: (error) => Center(
          child: Text(error, style: TextStyle(color: textColor)),
        ),
        loaded: (cartItems) {
          if (cartItems.isEmpty) {
            return Center(
              child: Text("Cart is empty", style: TextStyle(color: textColor)),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartItems.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    final product = item.product;
                    final specificProductAmount = ref
                        .watch(cartNotifier.notifier)
                        .getProductAmount(product.id ?? 0);

                    return Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(product.image ?? ''),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: textColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product.description ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: subTextColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '$currency${specificProductAmount.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: priceColor,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: subTextColor!,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.remove,
                                                size: 18,
                                                color: textColor,
                                              ),
                                              onPressed: () {
                                                notifier.decreaseQuantity(
                                                  productId: product.id ?? 0,
                                                  context: context,
                                                );
                                              },
                                              padding: EdgeInsets.zero,
                                            ),
                                            Text(
                                              '${item.cart.quantity}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: textColor,
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.add,
                                                size: 18,
                                                color: textColor,
                                              ),
                                              onPressed: () {
                                                notifier.increaseQuantity(
                                                  productId: product.id ?? 0,
                                                );
                                              },
                                              padding: EdgeInsets.zero,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
