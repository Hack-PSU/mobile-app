import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final hackathonDate = DateTime.utc(2022, 4, 8, 14);

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
  Widget build(BuildContext context) {
    StringDuration diff = currentDifferentString;
    return Center(
        child: Text(
            "${diff.days} Days ${diff.hours} Hours ${diff.minutes} Minutes ${diff.seconds} Seconds"));
  }
}
