import 'package:ensiklopedia_islam/model/history.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

//ckucj event, fade
class HistoryWidget extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: SizedBox(
            height: 165,
            child: FixedTimeline.tileBuilder(
              theme: TimelineThemeData(
                direction: Axis.horizontal,
                connectorTheme: ConnectorThemeData(
                  space: 20.0,
                  thickness: 5.0,
                ),
              ),
              builder: TimelineTileBuilder.connected(
                contentsAlign: ContentsAlign.alternating,
                contentsBuilder: (context, index) => Card(
                  child: InkWell(
                    splashColor: Colors.grey.withAlpha(30),
                    onTap: () {
                      //card tapped
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Timeline Event $index'),
                    ),
                  ),
                ),
                connectorBuilder: (_, index, type) => DecoratedLineConnector(),
                indicatorBuilder: (context, index) => RawMaterialButton(
                  constraints: BoxConstraints.expand(width: 42, height: 42),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {},
                  fillColor: Colors.teal,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 22.0,
                  ),
                ),
                itemCount: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}




class _HistoryTitleWidget extends StatefulWidget {
  _HistoryTitleWidget(this.history);

  final History history;



  @override
  State<StatefulWidget> createState() {
    return _TitleState();
  }
}

class _TitleState extends State<_HistoryTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.widget.history.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 21.0, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 2.0),
              ),
              Flexible(
                child: Text(
                  this.widget.history.summary!,

                  //maxLines: 2,
                  //overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18.0, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

