import 'package:flutter/material.dart';

class MyScrollController extends ChangeNotifier {
  /// The currently active scroll controller.
  static ScrollController? currentScrollController;

  /// The main scroll controller for this instance.
  final ScrollController scrollController = ScrollController();

  /// A [ValueNotifier] that holds the current scroll offset.
  late final _offset = ValueNotifier(0.toDouble());

  /// Getter for the scroll offset [ValueNotifier].
  ValueNotifier<double> get offset => _offset;

  /// Disposes of the scroll controller and performs cleanup.
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /// Initializes the offset tracking and sets up the scroll listener.
  ///
  /// This method should be called after the widget is initialized to start
  /// tracking the scroll offset.
  Future<void> initOffset() async {
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        currentScrollController = scrollController;
        _offset.value = scrollController.offset;
      }
    });
  }
}
