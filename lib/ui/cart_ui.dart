import 'package:fairfruit/models/cart.dart';
import 'package:fairfruit/ui/payment.dart';
import 'package:flutter/material.dart';
import 'package:fairfruit/Bloc/cart_bloc.dart';
import 'package:fairfruit/Bloc/cart_provider.dart';

class CartUi extends StatelessWidget {
  final Cart cart;
  final CartBloc cartBloc;
  CartUi(this.cart, this.cartBloc);

  @override
  Widget build(BuildContext context) {
    return CartProvider(
      cartBloc: cartBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Carrinho"),
        ),
        body: StreamBuilder<Cart>(
          stream: cartBloc.cartOutputter,
          initialData: cartBloc.getCart(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false ||
                snapshot.data.returnCartList().length == 0) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Carrinho vazio."),
                ],
              ));
            } else {
              return Container(
                height: MediaQuery.of(context).size.height - 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height / 5-34,
                      child: ListView.builder(
                        itemCount: snapshot.data.getCartLength(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: index % 2 == 0
                                  ? Colors.orange.shade200
                                  : Colors.deepOrange.shade200,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    snapshot
                                        .data.cartList[index].product.imageLink,
                                    height: 80,
                                    width: 120,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      snapshot
                                          .data.cartList[index].product.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("R\$ " +
                                        snapshot.data.cartList[index].product
                                            .price),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            cartBloc.changeCount(index, true);
                                          },
                                          icon: Icon(Icons.add_circle_outline),
                                        ),
                                        Text(snapshot.data.cartList[index].count
                                            .toString()),
                                        IconButton(
                                          onPressed: () {
                                            if (snapshot
                                                    .data.cartList[index].count
                                                    .toString() !=
                                                "1") {
                                              cartBloc.changeCount(
                                                  index, false);
                                            } else {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                duration: Duration(seconds: 1),
                                                content: Text(
                                                    "Você precisa ter pelo menos um item"),
                                              ));
                                            }
                                          },
                                          icon:
                                              Icon(Icons.remove_circle_outline),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                FlatButton(
                                  child: Icon(Icons.delete),
                                  onPressed: () {
                                    cartBloc.delete(index);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      // height: MediaQuery.of(context).size.height / 5,
                      child: Row(
                        children: <Widget>[
                          Container(
                            color: Colors.yellow.shade300,
                            width: MediaQuery.of(context).size.width / 2,
                            height: 55,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Payment(
                                          snapshot.data, cartBloc,)),
                                );

                              },
                              child: Text(
                                  "Pagar"),
                            ),
                          ),
                          Container(
                            color: Colors.yellow.shade900,
                            width: MediaQuery.of(context).size.width / 2,
                            height: 55,
                            child: FlatButton(
                              onPressed: () {},
                              child:
                              Text("Total de itens: ${snapshot.data.getTotalItems()}\nTotal a pagar: R\$ ${snapshot.data.getTotalPrice()}"),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
