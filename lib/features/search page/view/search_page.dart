import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techsaint_task/core/widgets/custom_text_form_field.dart';
import 'package:techsaint_task/core/widgets/loader.dart';
import 'package:techsaint_task/features/home%20page/view%20model/product_notifier.dart';
import 'package:techsaint_task/features/home%20page/model/state/product_state.dart';
import 'package:techsaint_task/features/search%20page/components/product_search_tile.dart';

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
            CustomTextFormField(
              controller: searchController,
              labelText: "Search products...",
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
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
