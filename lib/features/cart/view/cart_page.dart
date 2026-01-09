import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techsaint_task/core/animations/cart/cart_list_loader.dart';
import 'package:techsaint_task/core/constants/constants.dart';
import 'package:techsaint_task/core/constants/theme_notifier.dart';
import 'package:techsaint_task/features/cart/model/state/cart_state.dart';
import 'package:techsaint_task/features/cart/view%20model/cart_notifier.dart';
import 'package:techsaint_task/features/home%20page/components/product_details_page.dart';

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;
          return cartState.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const CartListLoader(),
            error: (error) => Center(
              child: Text(error, style: TextStyle(color: textColor)),
            ),
            loaded: (cartItems) {
              if (cartItems.isEmpty) {
                return Center(
                  child: Text(
                    "Cart is empty",
                    style: TextStyle(color: textColor),
                  ),
                );
              }

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? 900 : double.infinity,
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final product = item.product;
                      final specificProductAmount = ref
                          .watch(cartNotifier.notifier)
                          .getProductAmount(product.id ?? 0);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(product: product),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: shadowColor,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //  Image
                              Container(
                                width: isTablet ? 100 : 80,
                                height: isTablet ? 100 : 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(product.image ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 20),

                              // Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: isTablet ? 18 : 16,
                                        color: textColor,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      product.description ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: subTextColor,
                                        fontSize: isTablet ? 15 : 14,
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '$currency${specificProductAmount.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: priceColor,
                                          ),
                                        ),

                                        //Quantity
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
              );
            },
          );
        },
      ),

      bottomNavigationBar: cartState.when(
        loaded: (cartItems) {
          if (cartItems.isEmpty) return null;

          final totalAmount = notifier.getTotalCartAmount();
          final shipping = totalAmount > 50 ? 0 : 5;

          return Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isLightTheme ? Colors.white : const Color(0xFF1F1F1F),
              border: Border(
                top: BorderSide(
                  color: isLightTheme ? Colors.grey[300]! : Colors.grey[800]!,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(fontSize: 16, color: subTextColor),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$currency${(totalAmount + shipping).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: priceColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLightTheme
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFF66BB6A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error) => null,
        loading: () => null,
        initial: () => null,
      ),
    );
  }
}
