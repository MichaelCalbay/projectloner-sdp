import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Unit test on comment', () {
    test("No comment", () {
      String expectedValue = '';

      expect(expectedValue, 'gelaMeponPknuuPmbe39');
    });
    test("There is the comment", () {
      Future<bool> isPostExist() async {
        DocumentSnapshot ds = await FirebaseFirestore.instance
            .collection("Forums")
            .doc("o6H7H0KmU1aNxdyzLcsi")
            .collection('Comments')
            .doc('gelaMeponPknuuPmbe39')
            .get();

        expect(ds.exists, true);

        return ds.exists;
      }
    });
  });
}
