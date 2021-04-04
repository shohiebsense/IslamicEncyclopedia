import 'package:floor/floor.dart';

@entity
class HistoryDetail {
  @primaryKey
  final int id;
  @ColumnInfo(name: "history_id")
  final int historyId;
  final String period;
  @ColumnInfo(name: "description")
  final String desc;
  final String images;
  @ColumnInfo(name: "description_en")
  final String descEn;
  final String subtitle;
  @ColumnInfo(name: "subtitle_en")
  final String subtitleEn;
  @ColumnInfo(name: "is_bookmark")
  final int isBookmark;

  HistoryDetail(this.id, this.historyId, this.period, this.desc, this.images,
      this.descEn, this.subtitle, this.subtitleEn, this.isBookmark);

  @override
  String toString() {
    return 'HistoryDetail{id: $id, desc: $desc, subtitle: $subtitle}';
  }

}