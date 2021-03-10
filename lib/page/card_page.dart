import 'package:after_layout/after_layout.dart';
import 'package:ensiklopedia_islam/page/widget/history_header_view.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const loremIpsum =
    "Nabi Saleh (2150-2080 SM) merupakan seorang Nabi yang diutus untuk kaum Tsamud, beliau diangkat menjadi nabi pada tahun 2100 SM. Tsamud adalah nama suku yang oleh sementara ahli sejarah dimasukkan bagian dari bangsa Arab dan ada pula yang menggolongkan mereka ke dalam bangsa Yahudi. Mereka bertempat tinggal disuatu dataran bernama \'Alhijir' terletak antara Hijaz dan Syam yang dahulunya termasuk jajahan dan dikuasai suku Aad yang telah habis binasa disapu angin taufan yang dikirim Allah sebagai pembalasan atas pembangkangan dan pengingkaran terhadap dakwah dan risalah Nabi Hud Kemakmuran dan kemewahan hidup serta kekayaan alam yang dahulunya dimiliki dan dinikmati kaum Aad telah diwarisi oleh Kaum Tsamud. Kaum Tsamud tidak mengenal Tuhan, Tuhan mereka adalah berhala-berhala yang mereka sembah dan puja, kepadanya mereka berqurban, tempat mereka meminta perlindungan dari segala bala dan musibah dan mengharapkan kebaikan serta kebahagiaan. Nabi Saleh memperingatkan meraka agar jangan menentangnya dan agar mengikuti ajakannya beriman kepada Allah yeng telah mengaruniai rezeki yang luas dan penghidupan yang sejahtera. Sekelompok kecil kaum Tsamud yang kebanyakannya terdiri dari orang-orang yang berkedudukan sosial lemah menerima dakwah Nabi Saleh sedangkan sebagian besar terutama mereka golongan orang-orang kaya dan berkedudukan tetap berkelas kepala dan menyombongkan diri menolak ajakan Nabi Saleh. Mereka menentang nabi Saleh dan untuk membuktikan kebenaran kenabiannya dengan suatu bukti mikjizat dalam bentuk benda atau kejadian luar biasa yang berada di luar kekuatan manusia.Nabi Saleh sadar bahwa tantangan kaumnya menuntut bukti berupa mukjizat itu adalah bertujuan hendak menghilangkan pengaruhnya dan mengikis habis kewibawaanya dimata kaumnya terutama para pengikutnya bila ia gagal memenuhi tantangan dan tuntutan mereka. Nabi Saleh telah diberikan mukjizat yaitu seekor unta betina yang dikeluarkan dari celah batu dengan izin Allah yakni untuk menunjukkan kebesaran Allah kepada kaum Tsamud. Namun kaum Tsamud masih mengingkari ajaran Saleh, mereka membunuh unta betina tersebut. Akhirnya kaum Tsamud dibalas dengan azab yang amat dahsyat yaitu dengan satu tempikan dari Malaikat Jibril yang menyebabkan tubuh mereka hancur berai.";

List<String> paragraphList = loremIpsum.split(". ");
StringBuffer stringBuffer = new StringBuffer();

class Card1 extends StatefulWidget {
  //final bool isScrolling;
  final Key key;

  Card1(this.key) : super(key: key);

  @override
  Card1State createState() => Card1State();
}

class Card1State extends State<Card1> with AfterLayoutMixin<Card1> {
  ExpandableController expandableController;
  bool initFlag = false;

  @override
  void afterFirstLayout(BuildContext context) {
    print("AFTER FIRST LAYOUT");
    //expandableController.expanded = this.page.widget.isScrolling;
  }

  @override
  void initState() {
    super.initState();
    if (expandableController == null) {
      expandableController = ExpandableController();
    }
  }

  @override
  Widget build(BuildContext context) {
   /* print("paragraph length  =>> ${paragraphList.length}");
    for (int i = 0; i < paragraphList.length; i++) {
      stringBuffer.write(paragraphList[i]);
      if (i % 2 == 0) {
        stringBuffer.write(".\n\n");
      } else {
        stringBuffer.write(". ");
      }
    }*/

    return ExpandableTheme(
      data: const ExpandableThemeData(
        iconColor: Colors.blue,
        useInkWell: true,
      ),
      child: ListView.separated(

        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 4,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ExpandableNotifier(
              //controller: expandableController,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: false,
                    ),
                    collapsed: SizedBox(
                      height: 400,
                      child: Column(
                        children: [
                          HistoryHeaderView(1),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              loremIpsum,
                              softWrap: true,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21.5,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    expanded: Text.rich(TextSpan(
                        text: loremIpsum,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.5,
                            fontWeight: FontWeight.w600))),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding:
                            EdgeInsets.only(left: 0, right: 0, bottom: 0),
                        child: Expandable(
                          // controller: expandableController,
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),

                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
