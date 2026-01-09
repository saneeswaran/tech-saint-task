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

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 600;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isTablet ? 60 : 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Good Morning",
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          ref.read(themeProvider.notifier).toggleTheme(),
                      icon: Icon(isLightTheme ? Iconsax.moon : Iconsax.sun),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: isTablet ? 30 : 22,
                    fontWeight: FontWeight.bold,
                    color: isLightTheme ? Colors.black : Colors.white,
                  ),
                ),

                SizedBox(height: isTablet ? 20 : 16),

                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SearchPage()),
                  ),
                  child: Hero(
                    tag: "searchbar",
                    child: AbsorbPointer(
                      absorbing: true,
                      child: SizedBox(
                        height: 52,
                        child: CustomTextFormField(
                          controller: TextEditingController(),
                          labelText: "Search products...",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
