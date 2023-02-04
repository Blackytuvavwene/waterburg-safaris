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

  // set gallery model data to firestore

  // update data on firestore
  static Future<T> updateDataInDoc<T>({
    required String docId,
    required String docPath,
    required Map<String, dynamic> data,
    required String query,
  }) async {
    try {
      await _firestore
          .collection(docPath)
          .doc(docId)
          .set(data, SetOptions(merge: true));
      return await getDataFromDoc<T>(
          docId: docId, docPath: docPath, query: query);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  // update from list of data in firestore
  static Future<List<T>> updateDataInDocList<T>({
    required String docId,
    required String docPath,
    required List<T> data,
    required String query,
  }) async {
    try {
      await _firestore.collection(docPath).doc(docId).update({
        query: FieldValue.arrayUnion(data),
      }).then((value) => print({'Data updated': data}));
      return await getDataFromDoc<List<T>>(
          docId: docId, docPath: docPath, query: query);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  // delete from list of data in firestore
  static Future<List<T>> deleteDataInDocList<T>({
    required String docId,
    required String docPath,
    required List<T> data,
    required String query,
  }) async {
    try {
      await _firestore.collection(docPath).doc(docId).update({
        query: FieldValue.arrayRemove(data),
      });
      return await getDataFromDoc<List<T>>(
          docId: docId, docPath: docPath, query: query);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  // delete and update list in firebase
  static Future<T> deleteAndUpdateInDocList<T>({
    required String docId,
    required String docPath,
    required T data,
    required T newData,
    required String query,
  }) async {
    try {
      final getDocRef = docRef(docPath).doc(docId);
      final docData = _firestore.runTransaction<T>((transaction) {
        return transaction.get(getDocRef).then((value) {
          transaction.update(getDocRef, {
            query: FieldValue.arrayRemove([data]),
          });
          transaction.update(getDocRef, {
            query: FieldValue.arrayUnion([newData]),
          });
          return newData;
        });
      });
      return docData;
    } on FirebaseException catch (firestoreError) {
      throw firestoreError.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  // delete from list using run transaction
  static Future<T> deleteInDocList<T>({
    required String docPath,
    required String docId,
    required String query,
    required T data,
  }) async {
    try {
      final getDocRef = docRef(docPath).doc(docId);
      final docData = _firestore.runTransaction<T>((transaction) {
        return transaction.get(getDocRef).then((value) {
          transaction.update(getDocRef, {
            query: FieldValue.arrayRemove([data]),
          });

          return data;
        });
      });
      return docData;
    } on FirebaseException catch (firestoreError) {
      throw firestoreError.message.toString();
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
