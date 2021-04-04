import 'package:floor/floor.dart';
import 'package:ensiklopedia_islam/model/history.dart';


//SELECT MIN(period) || ' ' || MAX (period) FROM HistoryDetail GROUP BY history_id;
@dao
abstract class HistoryDao {
  @Query('SELECT * FROM History')
  Future<List<History>> findAllHistory();

  @Query('SELECT * FROM History WHERE id=:id')
  Future<History?> findHistoryById(final int id);

  @Query('SELECT * FROM History')
  Stream<List<History>> findAllHistoryAsStream();

}