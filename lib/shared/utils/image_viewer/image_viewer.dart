import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final Color? backgroundColor;
  final List<String> imagesPath;
  final int initialIndex;
  final bool isNetworkImage;
  final Color? indicatorColor;
  final Color? selectedIndicatorColor;
  const ImageViewer(
      {Key? key,
      this.backgroundColor,
      required this.imagesPath,
      this.isNetworkImage = false,
      this.initialIndex = 0,
      this.indicatorColor,
      this.selectedIndicatorColor})
      : super(key: key);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: widget.imagesPath.length,
        vsync: this,
        initialIndex: widget.initialIndex);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                  controller: _tabController,
                  children: widget.imagesPath.map((e) {
                    return Image.file(
                      File(e),
                      fit: BoxFit.contain,
                    );
                  }).toList()),
            ),
            Positioned(
              left: 16,
              top: 32,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: widget.indicatorColor ?? Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 32.0,
              child: Row(
                children: widget.imagesPath
                    .map((e) => Container(
                        padding: EdgeInsets.all(4.0),
                        margin: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            color: _tabController.index ==
                                    widget.imagesPath.indexOf(e)
                                ? widget.selectedIndicatorColor ?? Colors.blue
                                : widget.indicatorColor ?? Colors.white,
                            shape: BoxShape.circle)))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
