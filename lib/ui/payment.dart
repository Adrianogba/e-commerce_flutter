import 'package:fairfruit/Bloc/cart_bloc.dart';
import 'package:fairfruit/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Payment extends StatefulWidget {
  Cart cart;
  CartBloc cartBloc;

  Payment(this.cart, this.cartBloc);

  @override
  State<StatefulWidget> createState() {
    var state = new PaymentState();
    state.cart = this.cart;
    state.cartBloc = this.cartBloc;
    return state;
  }
}

class PaymentState extends State<Payment> {
  Cart cart;
  CartBloc cartBloc;

  TextEditingController name = new TextEditingController();

  MaskedTextController cardNumber =
      new MaskedTextController(mask: '0000 0000 0000 0000');

  TextEditingController cardSecurityCode = new TextEditingController();
  MaskedTextController cardExpDate = new MaskedTextController(mask: '00/00');

  @override
  Widget build(BuildContext context) {
    print(cart.cartList.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Finalizar pagamento"),
        centerTitle: true,
        ),
      bottomNavigationBar:




        Container(
          color: Colors.yellow.shade300,
          width: MediaQuery.of(context).size.width / 2,
          height: 55,
          child:
          FlatButton(
            onPressed: () {},
            child: Text("Finalizar Pagamento"),
          ),
      ),

      body: ListView(
        children: <Widget>[

          new Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              color: Colors.white,
              child: new ListTile(
                leading: Text("Total a pagar:",
                    style: new TextStyle(fontWeight: FontWeight.bold)),
                title: Container(
                    alignment: Alignment.centerRight,
                    child: Text("R\$ ${cart.getTotalPrice()}",
    style: new TextStyle(fontWeight: FontWeight.bold)),),
              )),
          new Divider(height: 1.0),


          new Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              color: Colors.white,
              child: new ListTile(
                leading: Text("Nome completo:",
                    style: new TextStyle(fontWeight: FontWeight.bold)),
                title: Container(
                    alignment: Alignment.centerRight,
                    child: TextField(
                        controller: name,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Digite seu nome", border: InputBorder.none))),
              )),
          new Divider(height: 1.0),
          new Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              color: Colors.white,
              child: new ListTile(
                leading: Text("Numero do cartão:",
                    style: new TextStyle(fontWeight: FontWeight.bold)),
                title: Container(
                    alignment: Alignment.centerRight,
                    child: TextField(
                        controller: cardNumber,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "0000 0000 0000 0000", border: InputBorder.none))),
              )),
          new Divider(height: 1.0),

          new Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              color: Colors.white,
              child: new ListTile(
                leading: Text("Código de segurança:",
                    style: new TextStyle(fontWeight: FontWeight.bold)),
                title: Container(
                    alignment: Alignment.centerRight,
                    child: TextField(

                        controller: cardSecurityCode,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          counterText: "",
                            hintText: "000", border: InputBorder.none))),
              )),
          new Divider(height: 1.0),

          new Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              color: Colors.white,
              child: new ListTile(
                leading: Text("Validade:",
                    style: new TextStyle(fontWeight: FontWeight.bold)),
                title: Container(
                    alignment: Alignment.centerRight,
                    child: TextField(
                        controller: cardExpDate,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                            hintText: "00/00", border: InputBorder.none))),
              )),
          new Divider(height: 1.0),

        ],
      ),
    );
  }
}
