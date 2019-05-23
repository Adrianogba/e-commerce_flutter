import 'dart:async';
import 'package:fairfruit/models/product.dart';

class LikeBloc {
  final inputController = StreamController<Product>.broadcast();
  Sink<Product> get takeingInput => inputController.sink;

  final outputController = StreamController<bool>();
  Stream<bool> get outStream => outputController.stream;

  LikeBloc() {
    inputController.stream.listen(onData);
  }

  void onData(Product event) {
    event.changeLikeValue();
    outputController.add(event.isLiked);
  }

  void dispose() {
    inputController.close();
    outputController.close();
  }
}
