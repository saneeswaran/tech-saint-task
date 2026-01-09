import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techsaint_task/core/widgets/custom_text_form_field.dart';
import 'package:techsaint_task/core/widgets/loader.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';
import 'package:techsaint_task/features/home%20page/view%20model/product_notifier.dart';
import 'package:techsaint_task/features/home%20page/model/state/product_state.dart';
import 'package:techsaint_task/features/search%20page/components/product_search_tile.dart';
import 'package:techsaint_task/features/search%20page/view/search_result_page.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final searchController = TextEditingController();
  String searchQuery = '';

  @override
  /// Cleans up resources used by the widget.
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchProductNotifier(searchQuery));
    final mainState = ref.watch(productNotifier);
    final hasText = searchController.text.isNotEmpty;
    return Scaffold(
      appBar: AppBar(title: const Text("Search Products"), centerTitle: true),
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
                  setState(() {
                    searchQuery = query;
                  });
                },
                onSubmitted: (String query) {
                  if (searchController.text.trim().isEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SearchResultPage(products: []),
                      ),
                    );

                    return;
                  }
                  final List<Products> products = ref
                      .read(productNotifier)
                      .maybeWhen(
                        loaded: (products) => products,
                        orElse: () => [],
                      );

                  final filteredProducts = products
                      .where(
                        (e) => e.title!.toLowerCase().contains(
                          query.toLowerCase(),
                        ),
                      )
                      .toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchResultPage(products: filteredProducts),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            if (hasText)
              Expanded(
                child: mainState.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => const Loader(),
                  error: (error) => Text(error),
                  loaded: (products) {
                    if (searchResults.isEmpty) {
                      return const Center(child: Text("No results found"));
                    }

                    return ListView.separated(
                      itemCount: searchResults.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return ProductSearchTile(product: searchResults[index]);
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
