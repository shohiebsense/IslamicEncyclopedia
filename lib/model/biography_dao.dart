

import 'package:floor/floor.dart';
import 'package:ensiklopedia_islam/model/biography.dart';

@dao
abstract class BiographyDao {

  @Query('SELECT * FROM Biography')
  Future<List<Biography>> findAllBiography();

  @Query('SELECT * FROM Biography ORDER BY id LIMIT 25')
  Future<List<Biography>> findAllProphet();

  @Query('SELECT * FROM Biography WHERE category_id = 1002 ORDER BY name')
  Future<List<Biography>> findAllSahabah();

  @Query('SELECT * FROM Biography WHERE category_id = 1003 ORDER BY name')
  Future<List<Biography>> findAllUlama();

}