import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BodyPage _currentPage = BodyPage.Statistics;

  void _changePage(BodyPage page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Tómate tu tiempo'),
          ),
          body: MyBody(_currentPage),
          bottomNavigationBar: MyNavBar(_currentPage, _changePage),
        ),
        theme: ThemeData(
          colorScheme: ColorScheme.dark(),
        ));
  }
}

class MyNavBar extends StatelessWidget {
  final BodyPage page;
  final void Function(BodyPage) onTap;

  MyNavBar(this.page, this.onTap);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.grey[400],
      unselectedItemColor: Colors.grey[600],
      currentIndex: page.index,
      onTap: (index) => onTap(BodyPage.values[index]),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Statistics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.hourglass_bottom),
          label: 'Timer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}

class StatisticsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Statistics'),
    );
  }
}

class SettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings'),
    );
  }
}

class TimerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MyDescription(),
        MyClock(),
        MyButtons(),
        Switch(
          value: false,
          onChanged: null,
        ),
      ],
    );
  }
}

class MyDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Center(
          child: const Text(
            'A very long description of a task in my to-do list.',
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}

class MyClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          // color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: const Text(
            '30:00',
            style: TextStyle(
              fontSize: 80.0,
            ),
          ),
        ),
      ),
    );
  }
}

class MyButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: IconButton(
          color: Colors.blue,
          icon: Icon(Icons.play_arrow),
          iconSize: 50.0,
          onPressed: null,
        ),
      ),
    );
  }
}

enum BodyPage {
  Statistics,
  Timer,
  Settings,
}

class MyBody extends StatelessWidget {
  final BodyPage page;

  MyBody(this.page);

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case BodyPage.Statistics:
        return StatisticsBody();
      case BodyPage.Timer:
        return TimerBody();
      case BodyPage.Settings:
        return SettingsBody();
    }
  }
}
