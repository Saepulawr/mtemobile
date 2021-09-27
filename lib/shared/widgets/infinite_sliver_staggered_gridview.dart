import 'package:flutter/material.dart';
import 'package:mtemobile/shared/utils/animated/animated_scrolling.dart';
import 'package:mtemobile/shared/widgets/flutter_staggered_grid_view/src/widgets/sliver.dart';
import 'package:mtemobile/shared/widgets/flutter_staggered_grid_view/src/widgets/staggered_tile.dart';
import 'package:mtemobile/shared/widgets/show_up_animation-2.0.0/show_up_animation.dart';

class InfiniteSliverStaggeredGridView extends StatefulWidget {
  final double scrollThreshold;
  final Function nextData;
  final bool hasNext;
  final List<Widget>? loadingWidget;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final ScrollController controller;
  final EdgeInsetsGeometry? padding;
  final int crossAxisCount;
  final StaggeredTile? Function(int) staggeredTileBuilder;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  const InfiniteSliverStaggeredGridView({
    required this.nextData,
    required this.itemBuilder,
    required this.itemCount,
    required this.crossAxisCount,
    required this.staggeredTileBuilder,
    required this.controller,
    Key? key,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.padding,
    this.scrollThreshold = 300,
    this.hasNext = false,
    this.loadingWidget,
  }) : super(key: key);

  @override
  _InfiniteSliverStaggeredGridViewState createState() {
    return new _InfiniteSliverStaggeredGridViewState();
  }
}

class _InfiniteSliverStaggeredGridViewState
    extends State<InfiniteSliverStaggeredGridView>
    with SingleTickerProviderStateMixin {
  int? _lastLoadedEvent;
  List<Widget> _loadingWidget = [];
  @override
  void initState() {
    widget.controller.addListener(_onScroll);
    _loadingWidget = widget.loadingWidget ??
        [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ))
        ];

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(InfiniteSliverStaggeredGridView oldWidget) {
    if (oldWidget.itemCount != widget.itemCount) {
      _lastLoadedEvent = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  bool _hasScroll() {
    return widget.controller.position.haveDimensions &&
        widget.controller.position.maxScrollExtent > 0;
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: widget.padding ?? EdgeInsets.all(0),
      sliver: SliverStaggeredGrid.countBuilder(
        crossAxisCount: widget.crossAxisCount,
        staggeredTileBuilder: widget.staggeredTileBuilder,
        itemCount: widget.hasNext
            ? widget.itemCount + _loadingWidget.length
            : widget.itemCount,
        crossAxisSpacing: widget.crossAxisSpacing,
        mainAxisSpacing: widget.mainAxisSpacing,
        itemBuilder: (context, index) {
          if (!_hasScroll() &&
              index == widget.itemCount &&
              _lastLoadedEvent == null &&
              widget.hasNext) {
            _lastLoadedEvent = widget.itemCount;
            WidgetsBinding.instance!
                .addPostFrameCallback((_) => widget.nextData());
          }

          if (index < widget.itemCount) {
            return animatedScolling(
                child: widget.itemBuilder(context, index),
                direction: Direction.vertical);
          } else {
            return animatedScolling(
                child: _loadingWidget[
                    (widget.itemCount + _loadingWidget.length - 1) - index],
                direction: Direction.vertical);
          }
        },
      ),
    );
  }

  void _onScroll() {
    final maxScroll = widget.controller.position.maxScrollExtent;
    final currentScroll = widget.controller.position.pixels;
    if (maxScroll - currentScroll <= widget.scrollThreshold &&
        _lastLoadedEvent == null &&
        widget.hasNext) {
      _lastLoadedEvent = widget.itemCount;
      widget.nextData();
    }
  }
}
