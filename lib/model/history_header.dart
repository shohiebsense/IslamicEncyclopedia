
import 'package:flutter/foundation.dart';

class HistoryHeader with ChangeNotifier, DiagnosticableTreeMixin{
  String name = "";
  String summary = "";
  int historyId = 401;
  int headerIndex = 0;
  int headerPicIndex = 0;

  HistoryHeader();

  void toggleCurrentTitle(String name, String summary, int historyId, int headerIndex, int headerPicIndex){
    this.name = name;
    this.summary = summary;
    this.historyId = historyId;
    this.headerIndex = headerIndex;
    this.headerPicIndex = headerPicIndex;
    notifyListeners();
  }

 @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(StringProperty('summary', summary));
  }
}