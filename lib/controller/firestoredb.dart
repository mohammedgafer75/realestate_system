// import 'package:abdo_games/model/users.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:abdo_games/controller/auth_controller.dart';
// import 'package:abdo_games/model/game_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FirestoreDb {
//   static addGame(GameModel gamemodel) async {
//     await FirebaseFirestore.instance.collection('Games').add({
//       'price': gamemodel.price,
//       'type': gamemodel.type,
//     });
//   }

//   static Stream<List<GameModel>> GameStream() {
//     return FirebaseFirestore.instance
//         .collection('Games')
//         .snapshots()
//         .map((QuerySnapshot query) {
//       List<GameModel> todos = [];
//       for (var todo in query.docs) {
//         final todoModel =
//             GameModel.fromDocumentSnapshot(documentSnapshot: todo);
//         todos.add(todoModel);
//       }
//       return todos;
//     });
//   }

//   static Stream<UserModel> UserStream() {
//     return FirebaseFirestore.instance
//         .collection('user')
//         .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .snapshots()
//         .map((QuerySnapshot query) {
//       List<UserModel> todos = [];
//       for (var todo in query.docs) {
//         final todoModel =
//             UserModel.fromDocumentSnapshot(documentSnapshot: todo);
//         todos.add(todoModel);
//       }
//       return todos.first;
//     });
//   }

//   static updateStatus(bool isDone, documentId) {
//     FirebaseFirestore.instance.collection('Games').doc(documentId).update(
//       {
//         'isDone': isDone,
//       },
//     );
//   }

//   static deleteTodo(String documentId) {
//     FirebaseFirestore.instance.collection('Games').doc(documentId).delete();
//   }
// }
