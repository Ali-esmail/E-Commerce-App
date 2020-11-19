import 'package:flutter/material.dart';

class MyPopupMenuItem<T> extends PopupMenuItem<T>{
  final Widget child;
  final Function onclick;
  MyPopupMenuItem({this.child,this.onclick}) : super(child : child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    // TODO: implement createState
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T,PopupMenuItem> extends PopupMenuItemState<T, MyPopupMenuItem<T>>{

  @override
  void handleTap() {
    widget.onclick();

  }
}