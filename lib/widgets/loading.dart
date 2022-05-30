import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'default_text.dart';
import 'screen.dart';

class Loading extends StatefulWidget {
  const Loading({
    Key? key,
    this.repeat,
    this.width,
    this.height,
    this.fit,
    this.label,
  }) : super(key: key);

  final bool? repeat;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String? label;

  @override
  State<StatefulWidget> createState() => LoadingState();
}

class LoadingState extends State<Loading> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/loading.json',
                frameRate: FrameRate.max,
                repeat: widget.repeat ?? true,
                width: widget.width,
                height: widget.height,
                fit: widget.fit ?? BoxFit.contain,
                animate: true,
              ),
              if (widget.label != null)
                const SizedBox(
                  height: 20,
                ),
              DefaultText(
                widget.label!,
                textLevel: TextLevel.h2,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
