import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storitter/data/model/story.dart';
import 'package:storitter/provider/app_provider.dart';
import 'package:storitter/provider/detail_story_provider.dart';
import 'package:storitter/utils/date_formatter.dart';

class StoryCard extends StatelessWidget {
  final Story story;

  const StoryCard({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          final token = Provider.of<AppProvider>(context, listen: false).token;
          Provider.of<DetailStoryProvider>(context, listen: false)
              .fetchDetailStories(token, story.id);

          context.pushNamed("detail", params: {"id": story.id});
        },
        child: Card(
          elevation: 8,
          borderOnForeground: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 200,
                width: 140,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  child: Image.network(
                    story.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        story.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        story.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.black45),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        formatDate(story.createdAt.toString()),
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
