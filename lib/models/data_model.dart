import 'package:cloud_firestore/cloud_firestore.dart';

class ResponseModel {
  String? id;
  bool? status;
  String? message;
  List<DataModel>? dataModel;
  int? data;

  ResponseModel(
      {this.id, this.status, this.message, this.dataModel, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        status = json['status'] as bool,
        message = json['message'] as String,
        data = json['data'] as int,
        dataModel = (json['data'] as List)
            .map((dynamic e) => DataModel.fromJson(e as Map<String, dynamic>))
            .toList();

  ResponseModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json['id'],
        status = json['status'],
        message = json['message'],
        data = json['data'],

        // will be update in PapersDataUploader
        dataModel = [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.status;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class DataModel {
  String? id;
  String? title;
  String? gambar;
  // String? isActive;
  // String? createTime;
  // String? updateTime;
  String? price;

  DataModel(
      {this.id,
      this.title,
      this.gambar,
      // this.isActive,
      // this.createTime,
      // this.updateTime,
      this.price});

 
  Map<String, dynamic> add() =>
      {"id": id, 
      "gambar": gambar, 
      "title": title, 
      "price": price};

  DataModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        gambar = json['gambar'],
        // isActive = json['is_active'],
        // createTime = json['create_time'],
        // updateTime = json['update_time'],
        price = json['price'];

  DataModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title = json['title'],
        gambar = json['gambar'],
        price = json['price'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['gambar'] = this.gambar;
    // data['is_active'] = this.isActive;
    // data['create_time'] = this.createTime;
    // data['update_time'] = this.updateTime;
    data['price'] = this.price;

    return data;
  }
}
