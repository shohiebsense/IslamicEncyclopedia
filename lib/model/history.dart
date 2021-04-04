import 'package:floor/floor.dart';

@entity
class History  {
  @primaryKey
  int id;
  String? name;
  String? summary;
  @ColumnInfo(name: "name_en")
  String? nameEnglish;
  @ColumnInfo(name: "summary_en")
  String? summaryEnglish;


  History(this.id, this.name, this.summary, this.nameEnglish,
      this.summaryEnglish);

}
