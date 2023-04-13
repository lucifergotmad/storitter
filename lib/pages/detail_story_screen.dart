import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storitter/data/result_state.dart';
import 'package:storitter/provider/detail_story_provider.dart';
import 'package:storitter/utils/date_formatter.dart';

class DetailStoryScreen extends StatelessWidget {
  final String? id;

  const DetailStoryScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailStoryProvider>(
        builder: (context, provider, _) {
          if (provider.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (provider.state == ResultState.hasData) {
            return NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        provider.story.photoUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.story.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.black87, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        provider.story.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        formatDate(provider.story.createdAt.toString()),
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          if (provider.state == ResultState.error ||
              provider.state == ResultState.noData) {
            return Center(
              child: Text(provider.message),
            );
          }

          return const Center(
            child: Text(""),
          );
        },
      ),
    );
  }
}
