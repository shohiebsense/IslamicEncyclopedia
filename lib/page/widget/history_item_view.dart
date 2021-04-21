
import 'package:ensiklopedia_islam/page/widget/history_item_header_view.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class HistoryItemView extends StatelessWidget {
  final int index;
  final String desc;

  HistoryItemView({required this.index, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ExpandableNotifier(
        //controller: expandableController,
        child: Padding(
          padding: EdgeInsets.zero,
          child: ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment
                    .center,
                tapBodyToExpand: true,
                tapBodyToCollapse: false,
              ),
              collapsed: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,

                    // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      Color(0xfffafafa),
                      Color(0xffffffff),
                    ],
                  ),
                ),
                child: SizedBox(
                  height: 290,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HistoryHeaderView(index+1),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: index == 0 ? const EdgeInsets.fromLTRB(
                                  8.0, 0, 8.0, 0) : EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                              child: Text(
                                desc,
                                softWrap: true,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21.5,
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
              expanded: Text.rich(TextSpan(
                  text: desc,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.5,
                      fontWeight: FontWeight.w600))),
              builder: (_, collapsed, expanded) {
                return Padding(
                  padding:
                  EdgeInsets.only(left: 0, right: 0, bottom: 0),
                  child: Expandable(
                    // controller: expandableController,
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(
                        crossFadePoint: 0),

                  ),
                );
              },
            ),
          ),
        ),)
      ,
    );
  }
}
