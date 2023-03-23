import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/api/hackathon/hackathon_model.dart';
import 'default_text.dart';

final openingCeremony = DateTime.utc(2022, 11, 5, 12)
    .add(const Duration(hours: 4)); // Add 4 hours to account for EDT off set
final hackingEnd = DateTime.utc(2022, 11, 6, 13, 45)
    .add(const Duration(hours: 4)); // Add 4 hours to account for EDT off set

class StringDuration {
  StringDuration(this.days, this.hours, this.minutes, this.seconds);
  String days;
  String hours;
  String minutes;
  String seconds;
}

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    Key? key,
    required this.hackathon,
  }) : super(key: key);

  final Hackathon hackathon;

  @override
  State createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  DateTime? activeDate;

  // store widget state to prevent memory leak
  Timer? _timer;

  DateTime getActiveDate() {
    final start = widget.hackathon.startTime.difference(DateTime.now());

    return start.isNegative
        ? widget.hackathon.endTime
        : widget.hackathon.startTime;
  }

  String get days {
    if (activeDate != null) {
      final diff = activeDate!.difference(DateTime.now());
      return diff.inDays.toString();
    }
    return "";
  }

  String get hours {
    if (activeDate != null) {
      final diff = activeDate!.difference(DateTime.now());
      return diff.inHours.remainder(24).toString().padLeft(2, '0');
    }
    return "";
  }

  String get minutes {
    if (activeDate != null) {
      final diff = activeDate!.difference(DateTime.now());
      return diff.inMinutes.remainder(60).toString().padLeft(2, '0');
    }
    return "";
  }

  String get seconds {
    if (activeDate != null) {
      final diff = activeDate!.difference(DateTime.now());
      return diff.inSeconds.remainder(60).toString().padLeft(2, '0');
    }
    return "";
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        activeDate = getActiveDate();
      });
    });
  }

  @override
  void initState() {
    if (mounted) {
      startTimer();
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
    String output = "";
    if (activeDate != null) {
      if (activeDate!.difference(DateTime.now()).isNegative) {
        output = "Hacking is Over!";
      } else if (activeDate == widget.hackathon.startTime) {
        output =
            "$days Days,\n$hours Hours,\n$minutes Minutes,\n$seconds Seconds Left!";
      } else {
        output =
            "$days Days,\n$hours Hours,\n$minutes Minutes,\n$seconds Seconds!";
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DefaultText(
        output,
        textLevel: TextLevel.h4,
        color: Colors.white,
        fontSize: 32,
        weight: FontWeight.w700,
      ),
    );
  }
}

class CountdownTimerCard extends StatefulWidget {
  const CountdownTimerCard({Key? key}) : super(key: key);

  @override
  State createState() => _CountdownTimerCardState();
}

class _CountdownTimerCardState extends State<CountdownTimerCard> {
  Duration openingDifference = openingCeremony.difference(DateTime.now());
  Duration endDifference = hackingEnd.difference(DateTime.now());
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
