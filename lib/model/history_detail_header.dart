
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HistoryDetailHeader with ChangeNotifier, DiagnosticableTreeMixin{
  String name = "";
  String summary = "";
  int historyId = 401;
  int sumPage = 0;
  int headerIndex = 0;
  int headerPicIndex = 0;

  HistoryDetailHeader();

  void toggleCurrentTitle(String name, String summary, int historyId, int sumPage, int headerIndex, int headerPicIndex){
    this.name = name;
    this.summary = summary;
    this.historyId = historyId;
    this.sumPage = sumPage;
    this.headerIndex = headerIndex;
    this.headerPicIndex = headerPicIndex;
    //notifyListeners();
  }

}