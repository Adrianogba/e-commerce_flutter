import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fairfruit/Bloc/cart_bloc.dart';
import 'package:fairfruit/Bloc/likeBloc.dart';
import 'package:fairfruit/models/catalog.dart';
import 'package:fairfruit/models/productList.dart';
import 'package:fairfruit/models/product.dart';
import 'product_details.dart';
import 'package:fairfruit/Bloc/cart_provider.dart';
import 'cart_ui.dart';
import 'package:fairfruit/models/cart.dart';
import 'search_results.dart';
import 'user.dart';

class Menu extends StatefulWidget {
  _MenuState createState() => _MenuState();
}

ProductList myList;

class _MenuState extends State<Menu> {
  void initState() {
    super.initState();

    List<Product> list = [
      Product(2, "Alcatra Bovino", "https://via.placeholder.com/300", "This is a hat",
          "100", 4, true, "Carnes"),
      Product(2, "Batata Inglesa", "https://via.placeholder.com/300", "This is a Bat",
          "120", 4.5, true, "Verduras"),
      Product(2, "Pimenta", "https://via.placeholder.com/300", "This is a Shoe",
          "200", 4.6, true, "Temperos"),
    ];
    myList = new ProductList(list);
    controller.addListener(listener);
  }

  LikeBloc likeBloc = LikeBloc();
  CartBloc cartBloc = CartBloc();

  final controller = TextEditingController();

  @override
  void dispose() {
    likeBloc.dispose();
    cartBloc.dispose();

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CartProvider(
      cartBloc: cartBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the Drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person_outline)),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Logar / Registrar",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                ),
              ),
              ExpansionTile(
                leading: Icon(Icons.phone_android),
                title: Text('Temperos'),
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      height: 10,
                      width: 10,
                    ),
                    title: Text('Bovina'),
                  ),
                  ListTile(
                    leading: Container(
                      height: 10,
                      width: 10,
                    ),
                    title: Text('Suina'),
                  ),
                  ListTile(
                    leading: Container(
                      height: 10,
                      width: 10,
                    ),
                    title: Text('Aves'),
                  ),
                  ListTile(
                    leading: Container(
                      height: 10,
                      width: 10,
                    ),
                    title: Text('Peixes e frutos do mar'),
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(Icons.phone_android),
                title: Text('Vegetais'),
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      height: 10,
                      width: 10,
                    ),
                    title: Text('Nacionais'),
                  ),
                  ListTile(
                    leading: Container(
                      height: 10,
                      width: 10,
                    ),
                    title: Text('Importados'),
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(Icons.phone_android),
                title: Text('Temperos'),
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      height: 10,
                      width: 10,
                    ),
                    title: Text('Nacionais'),
                  ),
                  ListTile(
                    leading: Container(
                      height: 10,
                      width: 10,
                    ),
                    title: Text('Importados'),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 120.0,
              title: Text("FruitFair"),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        print("Pesquisa selecionada");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchResult(cartBloc, myList)),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        // height: 60,

                        // padding: ,
                        child: TextField(
                          controller: controller,
                          enabled: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                            hintText: "Pesquisar",
                            prefixIcon: Container(
                                margin: EdgeInsets.fromLTRB(10, 8, 6, 8),
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(35)),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CartUi(cartBloc.getCart(), cartBloc)),
                    );
                  },
                  icon: StreamBuilder<Cart>(
                    stream: cartBloc.cartOutputter,
                    //initialData: 0,
                    initialData: cartBloc.getCart(),
                    builder: (context, snapshot) {
                      var text = "";
                      if (snapshot.hasData) {
                        text = snapshot.data.getTotalItems().toString();
                      }
                      return Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Icon(Icons.shopping_cart),
                          ),
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                color: Colors.green.withOpacity(.7)),
                            child: Center(
                              child: Text(text == "0" ? "" : text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => User()
                    ));
                  },
                  icon: Icon(Icons.more_vert),
                  color: Colors.white,
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Swiper(
                  layout: SwiperLayout.STACK,
                  
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Image.network(
                          "http://via.placeholder.com/288x188",
                          fit: BoxFit.fill,
                        ),
                        Text(
                          index.toString(),
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    );
                  },
                  itemCount: 10,
                  itemWidth: 300.0,
                  // viewportFraction: 0.85,
                  // scale: 0.9,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Promoções",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "14 itens",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 86,
                child: ListView.builder(
                  itemCount: 8,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.orange],
                        )),
                        width: 80,
                        child: Center(child: Text("Categoria $index")),
                        margin: EdgeInsets.all(4),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Produtos em destaque",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print("tapped");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetails(
                                myList.getList()[index], cartBloc, myList)),
                      );
                    },
                    child: new Container(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Image.network(myList.getList()[index].imageLink),
                            Text(
                              myList.getList()[index].name,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        height: 150.0),
                  );
                }, childCount: myList.getList().length))
          ],
        ),
      ),
    );
  }

  String listener() {
    print(controller.text);
    return controller.text;
  }
}
