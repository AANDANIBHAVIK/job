// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:job_letter/utils/widgets/plutostate.dart';
import 'package:pluto_grid/pluto_grid.dart';

class CustomPlutoPagination extends PlutoStatefulWidget {
  const CustomPlutoPagination(
    this.stateManager, {
    this.pageSizeToMove,
    super.key,
  }) : assert(pageSizeToMove == null || pageSizeToMove > 0);

  final PlutoGridStateManager stateManager;

  final int? pageSizeToMove;

  @override
  CustomPlutoPaginationState createState() => CustomPlutoPaginationState();
}

abstract class _CustomPlutoPaginationStateWithChange
    extends PlutoStateWithChange<CustomPlutoPagination> {
  late int page;

  late int totalPage;

  @override
  PlutoGridStateManager get stateManager => widget.stateManager;

  @override
  void initState() {
    super.initState();

    page = stateManager.page;

    totalPage = stateManager.totalPage;

    stateManager.setPage(page, notify: false);

    updateState(PlutoNotifierEventForceUpdate.instance);
  }

  @override
  void updateState(PlutoNotifierEvent event) {
    page = update<int>(
      page,
      stateManager.page,
    );

    totalPage = update<int>(
      totalPage,
      stateManager.totalPage,
    );
  }
}

class CustomPlutoPaginationState extends _CustomPlutoPaginationStateWithChange {
  late double _maxWidth;

  bool get _isFirstPage => page < 2;

  bool get _isLastPage => page > totalPage - 1;

  int get _itemSize {
    final countItemSize = ((_maxWidth - 350) / 100).floor();
    return countItemSize < 0 ? 0 : min(1, 1);
  }

  int get _startPage {
    final itemSizeGap = _itemSize + 1;

    var start = page - itemSizeGap;

    if (page + _itemSize > totalPage) {
      start -= _itemSize + page - totalPage;
    }

    return start < 0 ? 0 : start;
  }

  int get _endPage {
    final itemSizeGap = _itemSize + 1;

    var end = page + _itemSize;

    if (page - itemSizeGap < 0) {
      end += itemSizeGap - page;
    }

    return end > totalPage ? totalPage : end;
  }

  List<int> get _pageNumbers {
    return List.generate(
      _endPage - _startPage,
      (index) => _startPage + index,
      growable: false,
    );
  }

  int get _pageSizeToMove {
    if (widget.pageSizeToMove == null) {
      return 1 + (_itemSize * 2);
    }

    return widget.pageSizeToMove!;
  }

  void _firstPage() {
    _movePage(1);
  }

  void _beforePage() {
    setState(() {
      page -= _pageSizeToMove;

      if (page < 1) {
        page = 1;
      }

      _movePage(page);
    });
  }

  void _nextPage() {
    setState(() {
      page += _pageSizeToMove;

      if (page > totalPage) {
        page = totalPage;
      }

      _movePage(page);
    });
  }

  void _lastPage() {
    _movePage(totalPage);
  }

  void _movePage(int page) {
    stateManager.setPage(page);
  }

  // ButtonStyle _getNumberButtonStyle(bool isCurrentIndex) {
  //   return TextButton.styleFrom(
  //     disabledForegroundColor: Colors.transparent,
  //     shadowColor: Colors.transparent,
  //     padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
  //     backgroundColor: Colors.transparent,
  //   );
  // }

  TextStyle _getNumberTextStyle(bool isCurrentIndex) {
    return TextStyle(
      fontSize:
          isCurrentIndex ? stateManager.configuration.style.iconSize : null,
      color: isCurrentIndex
          ? Colors.white
          : stateManager.configuration.style.iconColor,
    );
  }

  BoxDecoration _getContainerdecoration(bool isCurrentIndex) {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: isCurrentIndex ? Colors.blue : Colors.transparent,
    );
  }

  Widget _makeNumberButton(int index) {
    var pageFromIndex = index + 1;

    var isCurrentIndex = page == pageFromIndex;

    return InkWell(
      onTap: () {
        stateManager.setPage(pageFromIndex);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 35,
          width: 35,
          decoration: _getContainerdecoration(isCurrentIndex),
          child: Center(
            child: Text(
              pageFromIndex.toString(),
              style: _getNumberTextStyle(isCurrentIndex),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, size) {
        _maxWidth = size.maxWidth;

        const Color iconColor = Colors.blue;
        Color iconaccentColor = Colors.blue.shade50;

        return SizedBox(
          width: _maxWidth,
          height: stateManager.footerHeight,
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: _isFirstPage ? null : _firstPage,
                    child: Container(
                        decoration: BoxDecoration(
                            color:
                                _isFirstPage ? Colors.grey.shade300 : iconColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _isFirstPage
                                  ? Colors.grey.shade300
                                  : iconaccentColor,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "FIRST",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: _isFirstPage ? null : _beforePage,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                _isFirstPage ? Colors.grey.shade300 : iconColor,
                          )),
                      child: Icon(
                        Icons.navigate_before,
                        color: _isFirstPage ? Colors.grey.shade300 : iconColor,
                      ),
                    ),
                  ),
                  ..._pageNumbers
                      .map(_makeNumberButton)
                      .toList(growable: false),
                  InkWell(
                    onTap: _isLastPage ? null : _nextPage,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                _isLastPage ? Colors.grey.shade300 : iconColor,
                          )),
                      child: Icon(
                        Icons.navigate_next,
                        color: _isLastPage ? Colors.grey.shade300 : iconColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: _isLastPage ? null : _lastPage,
                    child: Container(
                        decoration: BoxDecoration(
                            color:
                                _isLastPage ? Colors.grey.shade300 : iconColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _isLastPage
                                  ? Colors.grey.shade300
                                  : iconaccentColor,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "LAST",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
