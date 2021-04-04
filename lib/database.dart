import 'dart:async';
import 'dart:io' as io;
import 'package:ensiklopedia_islam/model/biography.dart';
import 'package:ensiklopedia_islam/model/biography_dao.dart';

import 'package:ensiklopedia_islam/model/history_detail.dart';
import 'package:ensiklopedia_islam/model/history.dart';
import 'package:ensiklopedia_islam/model/history_dao.dart';
import 'package:ensiklopedia_islam/model/history_detail_dao.dart';

import 'package:floor/floor.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'model/biography.dart';
part 'database.g.dart';


//run the code generator
//$ flutter packages pub run build_runner build
//SELECT history_id, MIN(period) || ' ' || MAX (period) as PERIOD FROM HistoryDetail GROUP BY history_id;
@Database(version: 1, entities: [Biography, History, HistoryDetail])
abstract class IEDatabase extends FloorDatabase{
  //BiographyDao get biographyDao;
  BiographyDao get biographyDao;
  HistoryDao get historyDao;
  HistoryDetailDao get historyDetailDao;
  static bool isInitialized = false;

  static Future<void> init() async {
    if(isInitialized) return;
    String applicationDirectory = (await sqflite.getDatabasesPath());

    String dbPath = path.join(applicationDirectory, "IE.db");

    bool dbExists = await io.File(dbPath).exists();

    if(!dbExists){
      ByteData data = await rootBundle.load(path.join("assets", "IE.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await io.File(dbPath).writeAsBytes(bytes, flush: true);
    }

    isInitialized = true;
  }

}