import 'package:dashboard/filters.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'localized_texts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tender Board',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isArabic = false;
  bool isDrawerVisible = true;
  bool isNotificationVisible = true;
  bool showGraph = true;
  bool showFilter = false;

  void toggleLanguage() {
    setState(() {
      isArabic = !isArabic;
    });
  }

  void toggleDrawer() {
    setState(() {
      isDrawerVisible = !isDrawerVisible;
    });
  }

  void toggleFilter() {
    setState(() {
      showFilter = !showFilter;
    });
  }

  void toggleGraph() {
    setState(() {
      showGraph = !showGraph;
    });
  }

  void toggleNotifications() {
    setState(() {
      isNotificationVisible = !isNotificationVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    String langCode = isArabic ? 'ar' : 'en';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(isDrawerVisible ? Icons.menu_open : Icons.menu),
            onPressed: toggleDrawer,
          ),
          title: Text(LocalizedTexts.getText(langCode, 'appBarTitle')),
          actions: [
            IconButton(
              icon: Icon(showFilter ? Icons.filter_alt_off : Icons.filter_alt),
              onPressed: toggleFilter,
            ),
            IconButton(
              icon: Icon(showGraph ? Icons.bar_chart : Icons.close_sharp),
              onPressed: toggleGraph,
            ),
            IconButton(
              icon: Icon(isNotificationVisible
                  ? Icons.notifications_off
                  : Icons.notifications),
              onPressed: toggleNotifications,
            ),
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: toggleLanguage,
            ),
          ],
        ),
        body: Center(
          child: Row(
            children: [
              // Drawer section
              if (isDrawerVisible)
                Container(
                  width: 200,
                  color: Colors.blue,
                  child: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        _buildDrawerItem(langCode, 'inbox'),
                        _buildDrawerItem(langCode, 'outbox'),
                        _buildDrawerItem(langCode, 'closedJobs'),
                        _buildDrawerItem(langCode, 'cc'),
                        _buildDrawerItem(langCode, 'decision'),
                        _buildDrawerItem(langCode, 'circular'),
                      ],
                    ),
                  ),
                ),
              // Main content section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (showFilter)
                      Filters(
                        langCode: langCode,
                      ),
                    Expanded(
                      child: SizedBox(
                        height: 500,
                        width: isDrawerVisible ? 900 : double.infinity,
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isDrawerVisible ? 5 : 6,
                            childAspectRatio: 1,
                          ),
                          children: [
                            _buildCard(langCode, 'inbox', 10),
                            _buildCard(langCode, 'outbox', 5),
                            _buildCard(langCode, 'closedJobs', 3),
                            _buildCard(langCode, 'cc', 12),
                            _buildCard(langCode, 'decision', 7),
                            _buildCard(langCode, 'circular', 8),
                          ],
                        ),
                      ),
                    ),
                    if (showGraph)
                      Container(
                        height: showFilter
                            ? 150
                            : isDrawerVisible
                                ? 200
                                : 350,
                        width: isDrawerVisible ? 1000 : double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        child: BarChart(
                          BarChartData(
                            titlesData: const FlTitlesData(
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                )),
                            barGroups: [
                              _buildBarGroup(1, 10, Colors.blue, 'Inbox'),
                              _buildBarGroup(
                                  2,
                                  5,
                                  const Color.fromARGB(255, 219, 98, 89),
                                  'Outbox'),
                              _buildBarGroup(3, 3, Colors.green, 'Closed Jobs'),
                              _buildBarGroup(4, 12, Colors.orange, 'CC'),
                              _buildBarGroup(5, 7, Colors.purple, 'Decision'),
                              _buildBarGroup(6, 8, Colors.yellow, 'Circular'),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Notification section
              if (isNotificationVisible)
                Container(
                  width: 250,
                  color: Colors.grey[100],
                  child: ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: [
                      Text(LocalizedTexts.getText(langCode, 'notifications'),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const ListTile(
                        title: Text("Tb-20241101121 received",
                            style: TextStyle(fontSize: 12)),
                        trailing: Icon(Icons.remove_red_eye),
                      ),
                      const ListTile(
                        title: Text("Tb-20241101122 received",
                            style: TextStyle(fontSize: 12)),
                        trailing: Icon(Icons.remove_red_eye),
                      ),
                      const ListTile(
                        title: Text("Circular - 202",
                            style: TextStyle(fontSize: 12)),
                        trailing: Icon(Icons.remove_red_eye),
                      ),
                      const ListTile(
                        title: Text("Tb-20241101122 closed",
                            style: TextStyle(fontSize: 12)),
                        trailing: Icon(Icons.remove_red_eye),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y, Color color, String label) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 20, // Adjust the width of the bars
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 15, // Background height
            color: Colors.grey[300],
          ),
        ),
      ],
      showingTooltipIndicators: [0], // Show tooltip on hover
    );
  }

  Widget _buildDrawerItem(String langCode, String key) {
    return ListTile(
      title: Text(LocalizedTexts.getText(langCode, key)),
      onTap: () {},
    );
  }

  Widget _buildCard(String langCode, String key, int count) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocalizedTexts.getText(langCode, key),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
