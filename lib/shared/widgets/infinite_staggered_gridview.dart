import 'package:flutter/material.dart';
import 'package:mtelektrik/shared/widgets/flutter_staggered_grid_view/src/rendering/sliver_staggered_grid.dart';
import 'package:mtelektrik/shared/widgets/flutter_staggered_grid_view/src/widgets/staggered_grid_view.dart';

class InfiniteStaggeredGridView extends StatefulWidget {
  final double scrollThreshold;
  final Function nextData;
  final bool hasNext;
  final Widget? loadingWidget;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final SliverStaggeredGridDelegate gridDelegate;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  // final bool addSemanticIndexes;
  // final double? cacheExtent;
  // final int? semanticChildCount;

  const InfiniteStaggeredGridView({
    required this.nextData,
    required this.itemBuilder,
    required this.itemCount,
    required this.gridDelegate,
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    // this.addSemanticIndexes = true,
    // this.cacheExtent,
    // this.semanticChildCount,
    this.scrollThreshold = 300,
    this.hasNext = false,
    this.loadingWidget,
  }) : super(key: key);

  @override
  _InfiniteStaggeredGridViewState createState() {
    return new _InfiniteStaggeredGridViewState();
  }
}

class _InfiniteStaggeredGridViewState extends State<InfiniteStaggeredGridView> {
  late ScrollController _scrollController;
  int? _lastLoadedEvent;

  @override
  void initState() {
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(InfiniteStaggeredGridView oldWidget) {
    if (oldWidget.itemCount != widget.itemCount) {
      _lastLoadedEvent = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  bool _hasScroll() {
    return _scrollController.position.haveDimensions &&
        _scrollController.position.maxScrollExtent > 0;
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.builder(
      itemCount: widget.hasNext ? widget.itemCount + 1 : widget.itemCount,
      gridDelegate: widget.gridDelegate,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      padding: widget.padding,
      physics: widget.physics,
      primary: widget.primary,
      reverse: widget.reverse,
      scrollDirection: widget.scrollDirection,
      shrinkWrap: widget.shrinkWrap,
      controller: _scrollController,
      itemBuilder: (context, index) {
        if (!_hasScroll() &&
            index == widget.itemCount &&
            _lastLoadedEvent == null &&
            widget.hasNext) {
          _lastLoadedEvent = widget.itemCount;
          WidgetsBinding.instance!
              .addPostFrameCallback((_) => widget.nextData());
        }
        if (index == widget.itemCount) {
          return widget.loadingWidget ??
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ));
        }
        return widget.itemBuilder(context, index);
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= widget.scrollThreshold &&
        _lastLoadedEvent == null &&
        widget.hasNext) {
      _lastLoadedEvent = widget.itemCount;
      widget.nextData();
    }
  }
}
