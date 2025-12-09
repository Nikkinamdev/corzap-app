import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CircularTimer extends StatefulWidget {
  final double? size; // optional rakha
  final int totalSeconds;

  const CircularTimer({
    super.key,
    this.size, // agar null hai to MediaQuery use hoga
    this.totalSeconds = 60,
  });

  @override
  State<CircularTimer> createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer> {
  late int seconds;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    seconds = widget.totalSeconds;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    final double size = widget.size ?? MediaQuery.of(context).size.width * 0.3;

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Circle
          SizedBox(
            width: w * .35,
            height: w * .35,
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: size * 0.06,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade300),
            ),
          ),

          // Foreground Countdown
          TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 1.0,
              end: seconds / widget.totalSeconds,
            ),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return SizedBox(
                width: w * .35,
                height: w * .35,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: size * 0.06,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                  backgroundColor: Colors.transparent,
                ),
              );
            },
          ),

          // Timer Text
          Text(
                "00:${seconds.toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: w * .08,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
              .animate()
              .fade(duration: 300.ms)
              .scale(duration: 300.ms, begin: const Offset(0.9, 0.9)),
        ],
      ),
    );
  }
}
