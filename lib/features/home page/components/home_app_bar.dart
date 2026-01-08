import 'package:flutter/material.dart';
import 'package:techsaint_task/core/widgets/custom_text_form_field.dart';
import 'package:techsaint_task/features/search%20page/view/search_page.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const SizedBox(height: 60),
          // Welcome Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Search Field
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
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
