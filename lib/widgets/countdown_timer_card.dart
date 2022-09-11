import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'default_text.dart';

final openingCeremony = DateTime.utc(2021, 4, 9, 12)
    .add(const Duration(hours: 4)); // Add 4 hours to account for EDT off set
final hackingEnd = DateTime.utc(2022, 4, 10, 13, 45)
    .add(const Duration(hours: 4)); // Add 4 hours to account for EDT off set

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
  var openingDifference = openingCeremony.difference(DateTime.now());
  var endDifference = hackingEnd.difference(DateTime.now());
  // store widget state to prevent memory leak
  Timer? _timer;

  StringDuration get currentDifferentString {
    num totalSeconds = !openingDifference.isNegative
        ? openingDifference.inSeconds
        : endDifference.inSeconds;

    final String days = (totalSeconds ~/ Duration.secondsPerDay).toString();
    totalSeconds = totalSeconds.remainder(Duration.secondsPerDay);

    final String hours = (totalSeconds ~/ Duration.secondsPerHour).toString();
    totalSeconds = totalSeconds.remainder(Duration.secondsPerHour);

    final String minutes =
        (totalSeconds ~/ Duration.secondsPerMinute).toString();
    totalSeconds = totalSeconds.remainder(Duration.secondsPerMinute);

    final String seconds = totalSeconds.toString();

    return StringDuration(days, hours, minutes, seconds);
  }

  void startTimeout() {
    // save timer instance to unsubscribe (prevents memory leaks)
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        openingDifference = openingCeremony.difference(DateTime.now());
        endDifference = hackingEnd.difference(DateTime.now());
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
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String outputStr;
    if (endDifference.isNegative) {
      outputStr = "Hacking is over!";
    } else if (openingDifference.isNegative) {
      final StringDuration diff = currentDifferentString;
      outputStr =
          "${diff.days} Days,\n${diff.hours} Hours,\n${diff.minutes} Minutes,\n${diff.seconds} Seconds Left!";
    } else {
      final StringDuration diff = currentDifferentString;
      outputStr =
          "${diff.days} Days,\n${diff.hours} Hours,\n${diff.minutes} Minutes,\n${diff.seconds} Seconds!";
    }

    return DefaultText(
      outputStr,
      textLevel: TextLevel.h4,
      color: Colors.white,
      fontSize: 32,
      weight: FontWeight.w700,
    );
  }
}
