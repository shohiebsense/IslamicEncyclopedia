import 'package:flutter/foundation.dart';

class HistoryHeader with ChangeNotifier, DiagnosticableTreeMixin{
  String name = "";
  String summary = "";
  int historyId = 401;

  HistoryHeader();

  void toggleCurrentTitle(String name, String summary, int historyId){
    this.name = name;
    this.summary = summary;
    this.historyId = historyId;
    notifyListeners();
  }

 @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(StringProperty('summary', summary));
  }
}