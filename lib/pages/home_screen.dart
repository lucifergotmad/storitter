import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storitter/provider/app_provider.dart';
import 'package:storitter/provider/home_provider.dart';
import 'package:storitter/shared/locale.dart';
import 'package:storitter/widgets/story_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final token = context.read<AppProvider>().token;
    final provider = context.read<HomeProvider>();
    Future.microtask(() => provider.fetchAllStory(token));
    super.initState();
  }

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
                AppLocalizations.of(context)!.homeTitle,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black87),
              ),
              IconButton(
                enableFeedback: true,
                icon: const Icon(
                  Icons.add,
                  color: Colors.blue,
                  size: 28,
                ),
                onPressed: () {
                  context.pushNamed("add");
                },
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            AppLocalizations.of(context)!.homeSubtitle,
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
