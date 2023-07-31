import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  static Future<T> getDataFromDoc<T>({
    required String? docId,
    required String docPath,
    required String? query,
  }) async {
    try {
      final data = query != null
          ? await docRef<T>(docId != null ? '$docPath/$docId' : docPath)
              .where(query, isEqualTo: true)
              .get()
          : await docRef<T>(docId != null ? '$docPath/$docId' : docPath).get();
      return data.docs.first.data();
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  // stream data from firestore without query
  static Stream<List<T>> streamListDataWithoutQuery<T>({
    required String docPath,
  }) {
    try {
      final Stream<List<T>> data = docRef<T>(docPath).snapshots().map(
            (event) => event.docs
                .map(
                  (e) => e.data(),
                )
                .toList(),
          );
      return data;
    } on FirebaseException catch (e, stack) {
      debugPrint('Failed stream stack : ${stack.toString()}');
      debugPrint('Failed stream error: ${e.toString()}');
      throw e.toString();
    } catch (e, stack) {
      debugPrint('Failed stream stack : ${stack.toString()}');
      debugPrint('Failed stream error: ${e.toString()}');
      throw e.toString();
    }
  }

  // stream data from firestore with query
  static Stream<T> streamDataFromDocWithQuery<T>({
    required String? docId,
    required String docPath,
    required String query,
  }) {
    try {
      final Stream<T> data = docRef<T>('$docPath/$docId')
          .where(query, isEqualTo: true)
          .snapshots()
          .map(
            (event) => event.docs.map(
              (e) => e.data(),
            ) as T,
          );
      return data;
    } on FirebaseException catch (e, stack) {
      debugPrint('Failed stream stack : ${stack.toString()}');
      debugPrint('Failed stream error: ${e.toString()}');
      throw e.toString();
    } catch (e, stack) {
      debugPrint('Failed stream stack : ${stack.toString()}');
      debugPrint('Failed stream error: ${e.toString()}');
      throw e.toString();
    }
  }

  // set gallery model data to firestore

  // update data on firestore
  static Future<T> updateDataInDoc<T>({
    required String docId,
    required String docPath,
    required T data,
    required String query,
    bool? merge,
  }) async {
    try {
      await _firestore
          .collection(docPath)
          .doc(docId)
          .withConverter<T>(fromFirestore: (snapshot, options) {
            return FirestoreConverters.fromFirestore<T>(snapshot);
          }, toFirestore: (data, options) {
            return FirestoreConverters.toFirestore<T>(data);
          })
          .set(
            data,
            SetOptions(
              merge: merge,
            ),
          )
          .then((value) => debugPrint({
                'Data updated': data,
              }.toString()));
      // getDataFromDoc<T>(
      // docId: docId, docPath: docPath, query: query);
      return data;
    } on FirebaseException catch (e, s) {
      debugPrintStack(
        label: 'Firebase Exception',
        stackTrace: s,
      );
      throw e.message.toString();
    } on Exception catch (e, s) {
      debugPrintStack(
        label: 'Catch Exception',
        stackTrace: s,
      );
      throw e.toString();
    } catch (e, s) {
      debugPrintStack(
        label: 'Catch Exception all $e',
        stackTrace: s,
      );
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

  // create new firebase doc
  static Future<Map<String, dynamic>> createDataInDoc({
    required String docPath,
    required Map<String, dynamic> data,
    required String docId,
  }) async {
    try {
      await _firestore.collection(docPath).doc(docId).set(data);
      return data;
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

  static Future<T> deleteAndUpdateInDocList<T>({
    required String docId,
    required String docPath,
    required T data,
    required T newData,
    required String query,
  }) async {
    try {
      // Get the reference of the document
      final getDocRef = docRef<T>(docPath).doc(docId);
      // Get the data from the document
      final docData = await _firestore.runTransaction<T>((transaction) {
        return transaction.get(getDocRef).then((value) {
          // Delete the old list data
          transaction.update(getDocRef, {
            query: FieldValue.arrayRemove([data]),
          });
          // Add the new list data
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

  // add data to firestore
  static Future<Map<String, dynamic>> addDataToDoc({
    required String docPath,
    required Map<String, dynamic> data,
  }) async {
    try {
      final docData =
          await _firestore.collection(docPath).add(data).then((value) {
        debugPrint('Data added: $data');
        return data;
      });
      return docData;
    } on FirebaseException catch (e) {
      throw e.message.toString();
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
      final getDocRef = docRef<T>(docPath).doc(docId);
      final docData = _firestore.runTransaction<T>((transaction) {
        return transaction.get(getDocRef).then((value) {
          if (value.exists) {
            // get document reference

            transaction.update(getDocRef, {
              // pass the query and update data

              query: FieldValue.arrayRemove([data]),
            });
            debugPrint('Data image deleted: $data');
            return data;
          } else {
            throw 'Document does not exist';
          }
        });
      });
      return docData;
    } on FirebaseException catch (firestoreError) {
      debugPrint(
          'Firestore error image delete failed: ${firestoreError.message}');
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

// firestore helper controller notifier using generic type on state notifier
class FirestoreHelperController<T> extends StateNotifier<AsyncValue<T>> {
  FirestoreHelperController() : super(AsyncData(T as T));

// get data from firestore
  Future getDataFromDoc({
    required String docId,
    required String docPath,
    required String query,
  }) async {
    state = const AsyncLoading();
    return state = await AsyncValue.guard(() async {
      final data = await FirestoreHelper.getDataFromDoc<T>(
          docId: docId, docPath: docPath, query: query);
      return data;
    });
  }

// set data to firestore in doc
  Future updateDataInDoc({
    required String docId,
    required String docPath,
    required T data,
    required String query,
  }) async {
    state = const AsyncLoading();
    return state = await AsyncValue.guard(() async {
      final updatedData = await FirestoreHelper.updateDataInDoc<T>(
          docId: docId, docPath: docPath, data: data, query: query);
      return updatedData;
    });
  }

// update data in firestore in doc list
  Future updateDataInDocList({
    required String docId,
    required String docPath,
    required List<T> data,
    required String query,
  }) async {
    state = const AsyncLoading();
    return state = await AsyncValue.guard(() async {
      final updatedData = await FirestoreHelper.updateDataInDocList<T>(
          docId: docId, docPath: docPath, data: data, query: query);
      return updatedData as T;
    });
  }

// delete data in firestore in doc list
  Future deleteDataInDocList({
    required String docId,
    required String docPath,
    required List<T> data,
    required String query,
  }) async {
    state = const AsyncLoading();
    return state = await AsyncValue.guard(() async {
      final updatedData = await FirestoreHelper.deleteDataInDocList<T>(
          docId: docId, docPath: docPath, data: data, query: query);
      return updatedData as T;
    });
  }
}

// firestore helper controller noitifier provider
final firestoreHelperControllerProvider = <T>() => StateNotifierProvider
        .autoDispose<FirestoreHelperController<T>, AsyncValue<T>>((ref) {
      return FirestoreHelperController();
    });

// firestore helper provider
final firestoreHelperProvider = Provider<FirestoreHelper>((ref) {
  return FirestoreHelper();
});
