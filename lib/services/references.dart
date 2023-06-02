import 'package:cloud_firestore/cloud_firestore.dart';

final fi = FirebaseFirestore.instance;
final dataPaperFR = fi.collection('produk');
DocumentReference dataFR({
  required String paperId, 
  required String dataId
}) => dataPaperFR.doc(paperId).collection('dataProduk').doc(dataId);