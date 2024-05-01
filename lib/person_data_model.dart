class PersonDataModel {
  String? name;
  String? birthDate;
  String? uniqueId;
  String? nationalityID;
  String? age;

  PersonDataModel({
    this.name,
    this.birthDate,
    this.uniqueId,
    this.nationalityID,
    this.age,
  });

  PersonDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    birthDate = json['birthDate'];
    uniqueId = json['uniqueId'];
    nationalityID = json['nationalityID'];
    age = json['age'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'birthDate': birthDate,
      'uniqueId': uniqueId,
      'nationalityID': nationalityID,
      'age': age,
    };
  }
}