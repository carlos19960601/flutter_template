import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Scroll1Screen extends StatefulWidget {
  const Scroll1Screen({super.key});

  @override
  State<Scroll1Screen> createState() => _Scroll1ScreenState();
}

class _Scroll1ScreenState extends State<Scroll1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(),
        elevation: 0,
        toolbarHeight: 32,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        actions: const [Icon(Icons.fiber_dvr)],
      ),
      body: const NestedContainerWidget(),
    );
  }
}

class NestedContainerWidget extends StatefulWidget {
  const NestedContainerWidget({super.key});

  @override
  _NestedContainerWidgetState createState() => _NestedContainerWidgetState();
}

class _NestedContainerWidgetState extends State<NestedContainerWidget> {
  late PageController _pageController;
  late ScrollController _listScrollController;
  late ScrollController _activeScrollController;
  late Drag? _drag;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _listScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    if (_listScrollController.hasClients) {
      final RenderBox renderBox = _listScrollController
          .position.context.storageContext
          .findRenderObject()! as RenderBox;
      if (renderBox.paintBounds
          .shift(renderBox.localToGlobal(Offset.zero))
          .contains(details.globalPosition)) {
        _activeScrollController = _listScrollController;
        _drag = _activeScrollController.position.drag(details, _disposeDrag);
        return;
      }
    }
    _activeScrollController = _pageController;
    _drag = _pageController.position.drag(details, _disposeDrag);
  }

  /*
   * If the listView is on Page 1, then change the condition as "details.primaryDelta < 0" and
   * "_activeScrollController.position.pixels ==  _activeScrollController.position.maxScrollExtent"
   */
  void _handleDragUpdate(DragUpdateDetails details) {
    if (_activeScrollController == _listScrollController &&
        details.primaryDelta! > 0 &&
        _activeScrollController.position.pixels ==
            _activeScrollController.position.minScrollExtent) {
      _activeScrollController = _pageController;
      _drag?.cancel();
      _drag = _pageController.position.drag(
          DragStartDetails(
              globalPosition: details.globalPosition,
              localPosition: details.localPosition),
          _disposeDrag);
    }
    _drag?.update(details);
  }

  void _handleDragEnd(DragEndDetails details) {
    _drag?.end(details);
  }

  void _handleDragCancel() {
    _drag?.cancel();
  }

  void _disposeDrag() {
    _drag = null;
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        VerticalDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer(),
                (VerticalDragGestureRecognizer instance) {
          instance
            ..onStart = _handleDragStart
            ..onUpdate = _handleDragUpdate
            ..onEnd = _handleDragEnd
            ..onCancel = _handleDragCancel;
        })
      },
      behavior: HitTestBehavior.opaque,
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListView(
            controller: _listScrollController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              20,
              (int index) {
                return ListTile(title: Text('Item $index'));
              },
            ),
          ),
          ListView(
            controller: _listScrollController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              20,
              (int index) {
                return ListTile(title: Text('Item $index'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
