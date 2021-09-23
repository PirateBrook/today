import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today/src/app.dart';
import 'package:today/src/entity/event.dart';

class _FocusPageState extends State {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return FutureBuilder<List<Event>>(
        future: appState.api.events.list(),
        builder: (context, futureSnapshot) {
          if (!futureSnapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Text("Has Data!"),
          );
        });
  }
}

class FocusPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FocusPageState();
}
