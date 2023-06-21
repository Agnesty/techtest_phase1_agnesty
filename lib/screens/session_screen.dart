import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

// ignore: must_be_immutable
class SessionManager extends StatefulWidget {
  Widget child;
  VoidCallback onSessionExpired;
  Duration duration;
  StreamController streamController;

  SessionManager(
      {required this.child,
      required this.onSessionExpired,
      required this.duration,
      required this.streamController,
      Key? key})
      : super(key: key);

  @override
  _SessionManagerState createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager> {
  Timer? _timer;
  StreamController? streamController;

  GetStorage storage = GetStorage();

  void sessionStart(bool isMainMenu) {
    // print("session start");

    closeTimer();
    startTimer(isMainMenu);
  }

  void startTimer(bool isMainMenu) {
    _timer = Timer.periodic(widget.duration, (timer) {
      print("timer checking");

      if (isMainMenu == true) {
        widget.onSessionExpired();
      }

      closeTimer();
    });
  }

  void closeTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    streamController = StreamController();
    streamController = widget.streamController;

    if (streamController != null) {
      streamController!.stream.listen((event) {
        if (event != null && event['timer'] as bool) {
          storage.write('pauseCounter', false);
          bool pauseCounter = storage.read('pauseCounter');
          sessionStart(pauseCounter);
        } else {
          closeTimer();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        bool pauseCounter = storage.read('pauseCounter');
        // print("nilai pauseCounter Listener : $pauseCounter");
        sessionStart(pauseCounter);
      },
      child: widget.child,
    );
  }
}
