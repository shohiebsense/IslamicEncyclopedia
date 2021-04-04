

import 'package:floor/floor.dart';
import 'package:ensiklopedia_islam/model/biography.dart';

@dao
abstract class BiographyDao {

  @Query('SELECT * FROM Biography')
  Future<List<Biography>> findAllBiography();

}