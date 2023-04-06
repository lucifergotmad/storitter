import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storitter/data/result_state.dart';
import 'package:storitter/provider/app_provider.dart';
import 'package:storitter/provider/home_provider.dart';
import 'package:storitter/widgets/story_card.dart';

class StoryList extends StatelessWidget {
  const StoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, _) {
      final token = Provider.of<AppProvider>(context, listen: false).token;

      if (provider.state == ResultState.idle) {
        Future.microtask(() => provider.fetchAllStory(token));
      }

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
    });
  }
}
