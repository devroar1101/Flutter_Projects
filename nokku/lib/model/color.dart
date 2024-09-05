import 'package:cloud_firestore/cloud_firestore.dart';

class ChosenColor {
  ChosenColor(this.red, this.green, this.blue);

  final int red;
  final int green;
  final int blue;

  Map<String, dynamic> toMap() {
    return {
      'red': red,
      'green': green,
      'blue': blue,
    };
  }

  factory ChosenColor.fromMap(Map<String, dynamic> map) {
    return ChosenColor(map['red'], map['green'], map['blue']);
  }
}

class ColorsRepositary {
  ColorsRepositary(this.firestore);
  final FirebaseFirestore firestore;

  void addColor(ChosenColor cColor) async {
    await firestore.collection('colors').doc().set(cColor.toMap());
  }

  Future<List<ChosenColor>> getAllChosenColors() async {
    final docSnapshot = await firestore.collection('colors').get();

    return docSnapshot.docs.map((m) => ChosenColor.fromMap(m.data())).toList();
  }
}
