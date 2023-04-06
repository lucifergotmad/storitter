import 'package:flutter/material.dart';
import 'package:storitter/widgets/story_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Good Morning",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black87),
              ),
              IconButton(
                enableFeedback: true,
                icon: const Icon(Icons.add),
                onPressed: () {},
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Check out people's stories around the worlds!",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 40,
          ),
          const Expanded(
            child: StoryList(),
          )
        ],
      ),
    );
  }
}
