import 'package:flutter/material.dart';
import 'package:techsaint_task/core/widgets/custom_text_form_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("Welcome,", style: TextStyle(color: Colors.black)),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: size.height * 0.3,
                width: size.width * 1,
                child: Column(
                  children: [
                    GestureDetector(
                      child: Hero(
                        tag: "searchTag",
                        child: AbsorbPointer(
                          absorbing: true,
                          child: CustomTextFormField(
                            controller: TextEditingController(),
                            labelText: "Search here...",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
