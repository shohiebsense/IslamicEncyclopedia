import 'package:ensiklopedia_islam/model/history_detail.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timelines/timelines.dart';

class HistoryTimelineView extends StatefulWidget {
  final VoidCallback onTimelineTapped;


  HistoryTimelineView(this.onTimelineTapped);

  @override
  _HistoryTimelineViewState createState() => _HistoryTimelineViewState();
}

class _HistoryTimelineViewState extends State<HistoryTimelineView> {

  final List<String> _periods = ['610 M', '613 M', '619 M', '621 M', '622 M'];
  int currentPosition;


  @override
  Widget build(BuildContext context) {
   return Container(
     height: 150,
     child: SingleChildScrollView(
       scrollDirection: Axis.horizontal,
       child: FixedTimeline.tileBuilder(
         theme: TimelineThemeData(
           direction: Axis.horizontal,
           connectorTheme: ConnectorThemeData(
             space: 33.0,
             thickness: 5.0,
           ),
         ),
         builder: TimelineTileBuilder.connected(
           contentsAlign: ContentsAlign.alternating,
           contentsBuilder: (context, index) => Padding(
             padding: const EdgeInsets.symmetric(
                 horizontal: 12.0),
             child: InkWell(
               splashColor: Colors.grey.withAlpha(30),
               onTap: () {
                 setState(() {
                   currentPosition = index;
                   this.widget.onTimelineTapped();
                   print('Card Tapped');
                   print("current POSITION $currentPosition");
                 });
               },
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(_periods[index]),
               ),
             ),
           ),
           connectorBuilder: (_, index, type) =>
               DecoratedLineConnector(
                 decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.topCenter,
                     end: Alignment.bottomCenter,
                     colors: [
                       Colors.green,
                       Colors.white,
                     ],
                   ),
                 ),
               ),
           indicatorBuilder: (context, index) {
             return RawMaterialButton(
               constraints: BoxConstraints.expand(
                   width: 42, height: 42),
               materialTapTargetSize:
               MaterialTapTargetSize.shrinkWrap,
               onPressed: () {},
               shape: CircleBorder(),
               fillColor: (index == currentPosition? Colors.green: HexColor("#1F1F1F")),
               child: Icon(
                 Icons.check,
                 color: Colors.white,
                 size: 22.0,
               ),
             );
           },
           itemCount: _periods.length,
         ),
       ),
     ),
   );
  }
}
