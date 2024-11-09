import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_projects/main.dart';
import 'package:practice_projects/word_hurdle_game/word_hurdle_page.dart';

import 'earthquake_logs/earthquake_log.dart';

class NavigateScreen extends StatelessWidget {
  const NavigateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Screen'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              'Projects',
              style: TextStyle(fontSize: 24),
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.goNamed(WordHurdlePage.routeName);
                  },
                  child: const Text('Word Hurdle Game')),
              ElevatedButton(
                  onPressed: () {
                    context.goNamed(EarthquakeLog.routeName);
                  },
                  child: const Text('EarthQuake Log')),
            ],
          )
        ],
      ),
    );
  }
}
