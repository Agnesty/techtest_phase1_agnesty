class DataModel {
  String? id;
  String? title;
  String? gambar;
  String? isActive;
  String? createTime;
  String? updateTime;
  String? price;

  DataModel(
      {this.id,
      this.title,
      this.gambar,
      this.isActive,
      this.createTime,
      this.updateTime,
      this.price});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
        id: json['id'],
        title: json['title'],
        gambar: json['gambar'],
        isActive: json['is_active'],
        createTime: json['create_time'],
        updateTime: json['update_time'],
        price: json['price']);
  }
}
