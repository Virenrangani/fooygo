import 'package:flutter/cupertino.dart';

class CustomPadding {
  //EdgeInserts All
  static const edgeAll4= EdgeInsets.all(4);
  static const edgeAll8= EdgeInsets.all(8);
  static const edgeAll12= EdgeInsets.all(12);
  static const edgeAll16= EdgeInsets.all(16);
  static const edgeAll20= EdgeInsets.all(20);

  //EdgeInserts Symmetric vertical
  static const edgeSymmetricVer4= EdgeInsets.symmetric(vertical:4);
  static const edgeSymmetricVer8= EdgeInsets.symmetric(vertical:8);
  static const edgeSymmetricVer12= EdgeInsets.symmetric(vertical:12);
  static const edgeSymmetricVer16= EdgeInsets.symmetric(vertical:16);

  //EdgeInserts Symmetric horizontal
  static const edgeSymmetricHori4= EdgeInsets.symmetric(horizontal:4);
  static const edgeSymmetricHori8= EdgeInsets.symmetric(horizontal:8);
  static const edgeSymmetricHori12= EdgeInsets.symmetric(horizontal:12);
  static const edgeSymmetricHori16= EdgeInsets.symmetric(horizontal:16);

  //EdgeInserts Symmetric horizontal
  static const edgeSymmetricHoriVer4= EdgeInsets.symmetric(vertical:4,horizontal: 4);
  static const edgeSymmetricHoriVer8= EdgeInsets.symmetric(vertical:8,horizontal: 8);
  static const edgeSymmetricHoriVer12= EdgeInsets.symmetric(vertical:12,horizontal: 12);
  static const edgeSymmetricHoriVer16= EdgeInsets.symmetric(vertical:16,horizontal: 16);


  static const edgeSymmetricHori8Ver16=EdgeInsets.symmetric(horizontal: 8, vertical: 16);
  static const edgeSymmetricHori16Ver8=EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static const edgeSymmetricHori24Ver20=EdgeInsets.symmetric(horizontal: 24, vertical: 20);
  static const edgeSymmetricHori12Ver8=EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  static const edgeSymmetricHori8Ver12=EdgeInsets.symmetric(horizontal: 8, vertical: 12);
  static const edgeSymmetricHori8Ver2=EdgeInsets.symmetric(horizontal: 8, vertical: 2);

  //EdgeInserts only bottom
  static const edgeOnlyBottom12=EdgeInsets.only(bottom: 12);
  static const edgeOnlyBottom8=EdgeInsets.only(bottom: 8);

  //EdgeInserts only bottom
  static const edgeOnlyTop8=EdgeInsets.only(top: 8);
  static const edgeOnlyTop12=EdgeInsets.only(top: 12);

  static const edgeOnlyTop60LeftRight30=EdgeInsets.only(top:60,left: 30,right: 30);






}