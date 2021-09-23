import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/src/pages/focus_page.dart';
import 'package:today/src/pages/time_axis_page.dart';
import 'package:today/src/widgets/third_party/adaptive_scaffold.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onSignOut;

  const HomePage({@required this.onSignOut});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      title: LogoWidget(),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () => _handleSignOut(),
            child: const Text('Sign Out'),
          ),
        )
      ],
      currentIndex: _pageIndex,
      destinations: const [
        AdaptiveScaffoldDestination(
            title: "Focus", icon: Icons.filter_center_focus_outlined),
        AdaptiveScaffoldDestination(title: "Time axis", icon: Icons.timeline),
        AdaptiveScaffoldDestination(
            title: "Spending", icon: Icons.money_off_csred_rounded),
      ],
      body: _pageAtIndex(_pageIndex),
      onNavigationIndexChange: (newIndex) {
        setState(() {
          _pageIndex = newIndex;
        });
      },
      floatingActionButton:
          _hasFloatingActionButton ? _buildFab(context) : null,
    );
  }

  bool get _hasFloatingActionButton {
    if (_pageIndex == 2) return false;
    return true;
  }

  FloatingActionButton _buildFab(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
        onPressed: () => _handleFabPress(),
    );
  }

  void _handleFabPress() {
    if (_pageIndex == 0) {

    }

    if (_pageIndex == 1) {

    }
  }

  static Widget _pageAtIndex(int index) {
    if (index == 0) {
      return FocusPage();
    }
    if (index == 1) {
      return TimeAxisPage();
    }
    return const Center(child: Text('Spending'));
  }

  Future<void> _handleSignOut() async {
    var shouldSignOut = await showDialog<bool>(
        context: context,
        builder: (context) =>
            AlertDialog(
                title: const Text('Are you sure you want to sign out?'),
                actions: [
                  TextButton(
                      child: const Text('No'),
                      onPressed: () => Navigator.of(context).pop(false)),
                  TextButton(
                      child: const Text('Yes'),
                      onPressed: () => Navigator.of(context).pop(true))
                ]));

    if (!shouldSignOut) {
      return;
    }

    widget.onSignOut();
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage(
          'assets/images/sun.png',
        ),
        fit: BoxFit.scaleDown,
      ),
      width: 60,
      height: 60,
    );
  }

}