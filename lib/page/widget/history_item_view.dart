import 'package:ensiklopedia_islam/page/widget/history_item_header_view.dart';
import 'package:ensiklopedia_islam/style/color.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class HistoryItemView extends StatelessWidget {
  final int index;
  final String desc;

  HistoryItemView({required this.index, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: COLOR_DEFAULT,
      margin: EdgeInsets.zero,
      child: ExpandableNotifier(
        initialExpanded: true,
        //controller: expandableController,
        child: Padding(
          padding: EdgeInsets.zero,
          child: ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToExpand: false,
                tapBodyToCollapse: false,
              ),
              collapsed: Container(
                color: COLOR_DEFAULT,
                child: SizedBox(
                  height: 160,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HistoryHeaderView(index + 1),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: index == 0
                                  ? const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0)
                                  : EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                              child: Text(
                                desc,
                                softWrap: true,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    letterSpacing: 0.6,
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              expanded: Container(
                color: COLOR_DEFAULT,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HistoryHeaderView(index + 1),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text.rich(
                              TextSpan(
                                text: desc,
                                style: TextStyle(
                                    letterSpacing: 0.6,
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              builder: (_, collapsed, expanded) {
                return Padding(
                  padding: EdgeInsets.only(left: 0, right: 0, bottom: 0),
                  child: Expandable(
                    // controller: expandableController,
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
