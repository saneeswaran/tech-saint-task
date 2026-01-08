import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:techsaint_task/core/constants/theme_notifier.dart';
import 'package:techsaint_task/core/widgets/custom_text_form_field.dart';
import 'package:techsaint_task/features/search%20page/view/search_page.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Good Morning",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
                icon: Icon(isLightTheme ? Iconsax.moon : Iconsax.sun),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Welcome Back!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isLightTheme ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchPage()),
            ),
            child: Hero(
              tag: "searchbar",
              child: AbsorbPointer(
                absorbing: true,
                child: CustomTextFormField(
                  controller: TextEditingController(),
                  labelText: "Search products...",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
