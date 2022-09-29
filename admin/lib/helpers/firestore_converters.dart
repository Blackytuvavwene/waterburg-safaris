import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreConverters<T> {
  static T fromFirestore<T>(DocumentSnapshot snapshot) {
    return snapshot.data() as T;
  }

  static Map<String, dynamic> toFirestore<T>(T data) {
    return data as Map<String, dynamic>;
  }
}

final docRef = <T>(String path) {
  return FirebaseFirestore.instance.collection(path).withConverter<T>(
        fromFirestore: (snapshot, _) =>
            FirestoreConverters.fromFirestore<T>(snapshot),
        toFirestore: (data, _) => FirestoreConverters.toFirestore<T>(data),
      );
};

class FirestoreHelper {
  static final _firestore = FirebaseFirestore.instance;

  static Future<T> getDataFromDoc<T>(
      {required String docId,
      required String docPath,
      required String query}) async {
    try {
      final data = await docRef<T>('$docPath/$docId')
          .where(query, isEqualTo: true)
          .get();
      return data.docs.first.data();
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  // update data on firestore
  static Future<T> updateDataInDoc<T>({
    required String docId,
    required String docPath,
    required Map<String, dynamic> data,
    required String query,
  }) async {
    try {
      await docRef<T>(docPath).doc(docId).update(data);
      return await getDataFromDoc<T>(
          docId: docId, docPath: docPath, query: query);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}

// delete data from firestore with runTransaction
Future<void> deleteDataFromDoc<T>({
  required String docId,
  required String docPath,
}) async {
  try {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final doc = await docRef<T>(docPath).doc(docId).get();
      transaction.delete(doc.reference);
    });
  } on FirebaseException catch (e) {
    throw e.message.toString();
  } catch (e) {
    throw e.toString();
  }
}
