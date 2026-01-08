import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techsaint_task/core/widgets/custom_text_form_field.dart';
import 'package:techsaint_task/features/home page/view model/product_provider.dart';
import 'package:techsaint_task/features/home%20page/model/state/product_state.dart';
import 'package:techsaint_task/features/search%20page/components/product_search_tile.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Products"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Hero(
              tag: "searchbar",
              child: CustomTextFormField(
                controller: searchController,
                labelText: "Search products...",
                onChanged: (query) {
                  ref.read(productNotifier.notifier).filterProducts(query);
                },
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: state.when(
                initial: () =>
                    const Center(child: Text("Start typing to search")),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e) => Center(
                  child: Text(e, style: const TextStyle(color: Colors.red)),
                ),
                loaded: (products) {
                  if (products.isEmpty) {
                    return const Center(
                      child: Text(
                        "No products found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: products.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return ProductSearchTile(product: products[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
