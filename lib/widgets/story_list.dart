import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storitter/data/result_state.dart';
import 'package:storitter/provider/app_provider.dart';
import 'package:storitter/provider/home_provider.dart';
import 'package:storitter/widgets/story_card.dart';

class StoryList extends StatefulWidget {
  const StoryList({Key? key}) : super(key: key);

  @override
  State<StoryList> createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  @override
  void initState() {
    final token = context.read<AppProvider>().token;
    final provider = context.read<HomeProvider>();
    Future.microtask(() => provider.fetchAllStory(token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    if (provider.state == ResultState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (provider.state == ResultState.noData ||
        provider.state == ResultState.error) {
      return Center(
        child: Text(provider.message),
      );
    } else if (provider.state == ResultState.hasData) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final story = provider.listStory[index];

          return StoryCard(
            story: story,
          );
        },
        itemCount: provider.listStory.length,
      );
    } else {
      return const Center(
        child: Text(""),
      );
    }
  }
}
