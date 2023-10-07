// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/container_widget.dart';
import '../widgets/elevated_button.dart';

// تطبيق توقيت ساعة الإيقاف
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? repeatedFunction; // يُستخدم لإيقاف العد التنازلي مؤقتًا
  Duration duration =
      const Duration(seconds: 0); // القيمه الاصليه اللي هيرجع لها

  startTimer() {
    setState(() {
      repeatedFunction = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          //  خاص بالثواني لما يوصل 60 ثانيه يروح للدقائق يكون 1 وهكذا لي 60 دقيقه ولما يوصل لل 60 دقيقه كده يحسب 1 ساعه فهو بيبدا من الثواني وهكذا
          int newSeconds = duration.inSeconds + 1;
          duration = Duration(seconds: newSeconds);
        });
      });
    });
  }

// وعلي اساس هذا يتم تنفيذ شرط ان انا ضغط علي الزر او لا true او false يستخدم لعمل شرط ان القيمه ب
  bool inRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 40, 43),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ContainerWidget(
                textNumber: duration.inHours.toString().padLeft(2, '0'),
                textTime: 'Hour',
              ),
              ContainerWidget(
                textNumber:
                    duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
                textTime: 'Minutes',
              ),
              ContainerWidget(
                textNumber:
                    duration.inSeconds.remainder(60).toString().padLeft(2, '0'),
                textTime: 'Seconds',
              ),
            ],
          ),
          const SizedBox(height: 33),
          inRunning
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButtonWidget(
                      onPressed: () {
                        if (repeatedFunction!.isActive) {
                          setState(() {
                            repeatedFunction!.cancel();
                          });
                        } else {
                          startTimer();
                        }
                      },
                      text: (repeatedFunction!.isActive) ? 'Stop' : 'Resume',
                    ),
                    const SizedBox(width: 22),
                    ElevatedButtonWidget(
                      onPressed: () {
                        if (repeatedFunction != null) {
                          repeatedFunction!.cancel();
                        }
                        setState(() {
                          duration = const Duration(
                              seconds: 0); // القيمه الاصليه اللي هيرجع لها
                          inRunning = false;
                        });
                      },
                      text: 'Cancel',
                    )
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    startTimer();
                    setState(() {
                      inRunning = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 25, 120, 197)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                  ),
                  child: const Text(
                    "Start Timer",
                    style: TextStyle(fontSize: 23),
                  ),
                )
        ],
      ),
    );
  }
}
