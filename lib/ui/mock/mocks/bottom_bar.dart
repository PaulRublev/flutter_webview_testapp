import 'package:flutter/material.dart';
import 'package:test_app_webview/ui/mock/mocks/user_data_widget.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ValueNotifier<int> _tabNotifier;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 1),
    );
    _tabNotifier = ValueNotifier(_tabController.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          UserDataWidget(),
          Text('2'),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _tabNotifier,
        builder: (context, index, _) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate),
                label: 'Calculator',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: 'Dishes',
              ),
            ],
            currentIndex: index,
            onTap: (value) => _onItemTapped(value),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabNotifier.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _tabController.index = index;
    _tabNotifier.value = index;
  }
}
