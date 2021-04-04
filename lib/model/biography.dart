import 'package:floor/floor.dart';

@entity
class Biography {
  @primaryKey
  final int id;
  final String name;
  final String mukjizat;
  final String story;
  @ColumnInfo(name: "category_id")
  final int categoryId;
  //final String image;
  final String lifetime;

  //final String mukjizatEnglish;
  //final String storyEnglish;
  final int sort;
  final int bookmark;


  Biography(
      this.id,
      this.name,
      this.mukjizat,
      this.story,
      this.categoryId,
      this.lifetime,
      this.sort,
      this.bookmark);


}