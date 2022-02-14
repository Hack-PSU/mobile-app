import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final hackathonDate = DateTime.utc(2022, 4, 8, 14)
    .add(Duration(hours: 5)); // Add 5 hours to account for EST off set

class StringDuration {
  String days;
  String hours;
  String minutes;
  String seconds;

  StringDuration(this.days, this.hours, this.minutes, this.seconds);
}

class CountdownTimerCard extends StatefulWidget {
  State createState() => new _CountdownTimerCardState();
}

class _CountdownTimerCardState extends State<CountdownTimerCard> {
  var currentDifference = hackathonDate.difference(DateTime.now());
  // store widget state to prevent memory leak
  Timer _timer;

  StringDuration get currentDifferentString {
    int totalSeconds = currentDifference.inSeconds;
    String days = (totalSeconds ~/ Duration.secondsPerDay).toString();
    totalSeconds = totalSeconds.remainder(Duration.secondsPerDay);
    String hours = (totalSeconds ~/ Duration.secondsPerHour).toString();
    totalSeconds = totalSeconds.remainder(Duration.secondsPerHour);
    String minutes = (totalSeconds ~/ Duration.secondsPerMinute).toString();
    totalSeconds = totalSeconds.remainder(Duration.secondsPerMinute);
    String seconds = totalSeconds.toString();

    return StringDuration(days, hours, minutes, seconds);
  }

  startTimeout() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // save timer instance to unsubscribe (prevents memory leaks)
      _timer = timer;
      setState(() {
        currentDifference = hackathonDate.difference(DateTime.now());
      });
    });
  }

  @override
  void initState() {
    if (mounted) {
      startTimeout();
    }
    super.initState();
  }

  @override
  void deactivate() {
    if (_timer != null) {
      // clean up timer to prevent memory leak when
      // widget gets destroyed
      _timer.cancel();
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    StringDuration diff = currentDifferentString;
    return Center(
        child: Text(
            "${diff.days} Days ${diff.hours} Hours ${diff.minutes} Minutes ${diff.seconds} Seconds"));
  }
}
