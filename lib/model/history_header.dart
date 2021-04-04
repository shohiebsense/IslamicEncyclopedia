

import 'package:flutter/foundation.dart';

class HistoryHeader with ChangeNotifier, DiagnosticableTreeMixin{
  String name = "";
  String summary = "";


  HistoryHeader();



  void toggleCurrentTitle(String name, String summary){
    this.name = name;
    this.summary = summary;
    notifyListeners();
  }

 @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(StringProperty('summary', summary));
  }
}