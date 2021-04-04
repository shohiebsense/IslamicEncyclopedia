
import 'package:ensiklopedia_islam/model/history_detail.dart';
import 'package:floor/floor.dart';

@dao
abstract class HistoryDetailDao {

  @Query('SELECT * FROM HistoryDetail')
  Future<List<HistoryDetail>> findAllHistoryDetails();

  @Query('SELECT * FROM HistoryDetail')
  Stream<List<HistoryDetail>> findAllHistoryDetailsAsStream();

  @Query('SELECT * FROM HistoryDetail WHERE history_id = :historyId')
  Future<List<HistoryDetail>> findAllHistoryDetailsById(final int historyId);

  //dude .....
  @Query('SELECT * FROM HistoryDetail GROUP BY history_id')
  Future<List<HistoryDetail>> findAllPeriods();

}