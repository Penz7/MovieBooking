import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_booking/network/constants.dart';
import 'package:movie_booking/network/models/order_history.dart';

class OrderHistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference<OrderHistories> _orderHistoryRef;

  OrderHistoryService() {
    _orderHistoryRef =
        _firestore.collection(ORDER_HISTORY).withConverter<OrderHistories>(
              fromFirestore: (snapshot, _) =>
                  OrderHistories.fromJson(snapshot.data()!),
              toFirestore: (orderHistory, _) => orderHistory.toJson(),
            );
  }

  Future<List<OrderHistories>> getMovies() async {
    QuerySnapshot<OrderHistories> snapshot = await _orderHistoryRef.get();
    return snapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();
  }

 Future<bool> addOrderHistory(OrderHistories orderHistories) async {
  try {
    await _orderHistoryRef.add(orderHistories);
    return true; 
  } catch (error) {
    print('Error adding order history: $error');
    return false; 
  }
}

Future<List<OrderHistories>> getOrderByUserId(String userId) async {
    QuerySnapshot<OrderHistories> snapshot = await _orderHistoryRef.where('user_id', isEqualTo: userId).get();
    return snapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();
  }
}
