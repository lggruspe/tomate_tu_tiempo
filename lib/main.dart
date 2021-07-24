import 'dart:async';
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
        MyClock(Duration(minutes: 1)),
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

class MyClock extends StatefulWidget {
  final Duration duration;

  MyClock(this.duration);

  @override
  _MyClockState createState() => _MyClockState(duration);
}

class _MyClockState extends State<MyClock> {
  PausableTimer timer;

  _MyClockState(Duration duration) : timer = PausableTimer(duration);

  void _startTimer() => setState(() => timer.start((t) => setState(() {})));
  void _pauseTimer() => setState(() => timer.pause());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          // color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Column(children: <Widget>[
            Text(
              timer.duration.toString().substring(2, 7),
              style: TextStyle(
                fontSize: 80.0,
              ),
            ),
            StartPauseButton(_startTimer, _pauseTimer),
          ]),
        ),
      ),
    );
  }
}

class StartPauseButton extends StatefulWidget {
  final VoidCallback? onPressedStart;
  final VoidCallback? onPressedPause;

  StartPauseButton(this.onPressedStart, this.onPressedPause);

  @override
  _StartPauseButtonState createState() =>
      _StartPauseButtonState(onPressedStart, onPressedPause);
}

class _StartPauseButtonState extends State<StartPauseButton> {
  bool _active = false;

  final VoidCallback? onPressedStart;
  final VoidCallback? onPressedPause;

  _StartPauseButtonState(this.onPressedStart, this.onPressedPause);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.blue,
      icon: Icon(_active ? Icons.pause : Icons.play_arrow),
      iconSize: 40.0,
      onPressed: () {
        final callback = _active ? onPressedPause : onPressedStart;
        if (callback != null) callback();
        setState(() {
          _active = !_active;
        });
      },
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

class PausableTimer {
  Duration duration;
  Timer? timer;

  PausableTimer(this.duration);

  void start(void Function(Timer) callback) {
    const second = Duration(seconds: 1);
    if (timer == null) {
      timer = Timer.periodic(second, (timer) {
        if (duration < Duration.zero) {
          timer.cancel();
          callback(timer);
        } else {
          callback(timer);
          duration -= second;
        }
      });
    }
  }

  void pause() {
    timer?.cancel();
    timer = null;
  }
}
