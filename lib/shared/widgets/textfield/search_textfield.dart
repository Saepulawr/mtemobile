import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class SearchTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final void Function(String)? onTap;
  final void Function(String)? onEditingComplete;
  final void Function(String)? onChange;
  final String initialValue;
  final bool readOnly;
  final bool focus;
  final double height;
  final List<BoxShadow>? shadow;
  final BorderRadiusGeometry? borderRadius;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final Color? hintColor;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  SearchTextField({
    Key? key,
    this.focusNode,
    this.hintText = "",
    this.onTap,
    this.controller,
    this.onEditingComplete,
    this.initialValue = "",
    this.readOnly = false,
    this.focus = true,
    this.onChange,
    this.height = 40.0,
    this.shadow,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.prefixIconColor,
    this.suffixIconColor,
    this.hintColor,
    this.prefixIconSize,
    this.suffixIconSize,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController _textEditingController =
      TextEditingController(text: widget.initialValue);
  late FocusNode _focusNode = FocusNode();
  late ValueNotifier<String> _searchQuery;
  late TextStyle _textStyle;
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _textEditingController = widget.controller!;
      Future.delayed(Duration(milliseconds: 100)).then((value) {
        _textEditingController.text = widget.initialValue;
        _textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.initialValue.length));
      });
    }
    _searchQuery = ValueNotifier<String>(widget.initialValue);
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    }
    if (widget.focus) {
      _focusNode.requestFocus();
    }
    _textStyle = widget.textStyle != null
        ? widget.textStyle!
        : GoogleFonts.nunito(fontSize: 14);
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        // alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.white,
          boxShadow: widget.shadow,
          borderRadius:
              widget.borderRadius ?? BorderRadius.all(Radius.circular(20)),
        ),
        child: TextFormField(
            controller: _textEditingController,
            onTap: () {
              if (widget.onTap != null) widget.onTap!(_searchQuery.value);
            },
            onChanged: (value) {
              _searchQuery.value = value;
              if (widget.onChange != null) widget.onChange!(value);
            },
            readOnly: widget.readOnly,
            onEditingComplete: () {
              if (widget.onEditingComplete != null)
                widget.onEditingComplete!(_searchQuery.value);
            },
            focusNode: _focusNode,
            cursorColor: _textStyle.color,
            keyboardType: TextInputType.text,
            style: widget.textStyle,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              isCollapsed: true,
              fillColor: widget.backgroundColor ?? Colors.white,
              hintText: widget.hintText,
              hintStyle: _textStyle.copyWith(color: widget.hintColor),
              prefixIcon: widget.prefixIcon ??
                  Icon(
                    Icons.search,
                    color: widget.prefixIconColor ?? Colors.grey,
                    size: widget.prefixIconSize ?? 24,
                  ),
              suffixIcon: ValueListenableBuilder<String>(
                valueListenable: _searchQuery,
                builder: (context, value, child) {
                  if (value.trim().isNotEmpty) {
                    return IconButton(
                      onPressed: widget.readOnly
                          ? null
                          : () {
                              setState(() {
                                _textEditingController.text = "";
                                _searchQuery.value = "";
                              });
                            },
                      icon: widget.suffixIcon ??
                          Icon(
                            Icons.cancel,
                            color: widget.suffixIconColor ?? Colors.grey,
                            size: widget.suffixIconSize ?? 16,
                          ),
                    );
                  } else {
                    return Container(
                      height: 0,
                      width: 0,
                    );
                  }
                },
              ),
              border: InputBorder.none,
            )));
  }
}
