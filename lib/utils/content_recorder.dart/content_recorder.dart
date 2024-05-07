import 'package:flutter/material.dart';

import 'content_recorder_controller.dart';

class ContentRecorder extends StatefulWidget {
  final Widget? child;
  final ContentRecorderController controller;

  const ContentRecorder({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<ContentRecorder> createState() => ContentRecorderState();
}

class ContentRecorderState extends State<ContentRecorder> {
  late ContentRecorderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _controller.containerKey,
      child: widget.child,
    );
  }
}
