class ModelsModel {
  String? id;
  String? object;
  int? created;
  String? ownedBy;

  ModelsModel({this.id, this.object, this.created, this.ownedBy});

  ModelsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    created = json['created'];
    ownedBy = json['owned_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['created'] = created;
    data['owned_by'] = ownedBy;
    return data;
  }
}
