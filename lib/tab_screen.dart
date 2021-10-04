import 'package:flutter/material.dart';
import 'package:mgmp/statistik_screen.dart';
import 'package:mgmp/vote_screen.dart';


class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  
  int _selectedIndex = 0;
  late TabController _tabController;
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _tabController.animateTo(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        actions: [
          Container(
              margin: EdgeInsets.only(right: 24, bottom: 5),
              child: Image.asset('assets/logo.png'))
        ],
        title: const Text('Voting MGMP'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                0.7,
                0.7
              ],
                  colors: [
                Colors.blue.shade600,
                Colors.blue.shade900,
              ])),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            VoteScreen(),
            Statistik(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.how_to_vote),
            label: 'Voting',
            backgroundColor: Colors.blue.shade900,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Realtime',
            backgroundColor: Colors.blue.shade600,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow.shade600,
        onTap: _onItemTapped,
      ),
    );
  }
}
