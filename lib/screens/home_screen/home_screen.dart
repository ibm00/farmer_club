import 'package:farmer_club/screens/home_screen/home_provider.dart';
import 'package:farmer_club/utils/shared_widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/shared_widgets/circular_loading_widget.dart';
import '../../utils/shared_widgets/post_box_widget.dart';
import '../../utils/shared_widgets/add_post_card.dart';
import '../../utils/shared_widgets/top_loading_widget.dart';

class HomeScreen extends ConsumerWidget {
  static const routeName = "/home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(
      addingPostProvider.select((value) => value.isLoading),
    );
    return Scaffold(
      appBar: const AppBarWidget(title: 'الرئيسية', hasDrawer: true),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const AddPostCard(),
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, ref, _) {
                      final homePostsProv = ref.watch(homePostsProvider);
                      return homePostsProv.when(
                        data: (posts) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: posts.length,
                            itemBuilder: (context, index) => PostBoxWidget(
                              posts[index],
                              deletePostFun:
                                  ref.read(addingPostProvider).deletePost,
                            ),
                          );
                        },
                        error: (e, s) => Text("error Happend: ${e.toString()}"),
                        loading: () => const CircularLoadingWidget(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          if (isLoading) const TopLoadingWidget()
        ],
      ),
    );
  }
}
