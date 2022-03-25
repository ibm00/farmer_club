import 'package:farmer_club/screens/search_screen.dart/components/search_users_item.dart';
import 'package:farmer_club/screens/search_screen.dart/search_provider.dart';
import 'package:farmer_club/utils/shared_widgets/app_bar_widget.dart';
import 'package:farmer_club/utils/shared_widgets/circular_loading_widget.dart';
import 'package:farmer_club/utils/shared_widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = "/search-screen";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "بحث"),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: SizedBox(
              height: 47,
              child: TextFieldWidget(
                prefix: Icon(Icons.search, color: Colors.black),
                isContentPadding: false,
                hintText: "بحث...",
              ),
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final usersProv = ref.watch(allUsersProvider);
                return usersProv.when(
                  data: (users) => ListView.builder(
                    itemCount: users!.length,
                    itemBuilder: (context, index) =>
                        SearchUsersItem(userModel: users[index]),
                  ),
                  error: (e, s) => Text(e.toString()),
                  loading: () => const CircularLoadingWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
