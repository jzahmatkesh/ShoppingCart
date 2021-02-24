import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/screen/Cart.dart';

import 'module/ProductBloc.dart';
import 'module/class.dart';
import 'screen/product.dart';

void main() {
  runApp(BlocProvider<ProductBloc>(
    create: (context)=>ProductBloc(),
    child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home()
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        leading: IconButton(
          icon: Stack(
            children: [
              Align(
                child: Icon(CupertinoIcons.shopping_cart),
                alignment: Alignment.centerLeft,
              ),
              Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 10,
                  child: BlocBuilder<ProductBloc, BlocState>(
                    builder: (context, state)=>Text('${BlocProvider.of<ProductBloc>(context).cartProducts.length}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))
                  ),
                  backgroundColor: Colors.red,
                )
              )
            ],
          ),
          onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart())),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: FutureBuilder<List<Product>>(
            future: Product.loadData(),
            builder: (context, snap){
              if (snap.connectionState == ConnectionState.done)
                return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (context, i)=>Card(
                    child: ListTile(
                      onTap: (){},
                      title: Container(
                        height: 300,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image(image: NetworkImage(snap.data[i].picurl))
                            ),
                            SizedBox(height: 15),
                            Expanded(child: Text(snap.data[i].name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                            Expanded(child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${snap.data[i].price}\$', 
                                  style: TextStyle(
                                    color: snap.data[i].off > 0 ? Colors.red : Colors.black, 
                                    decoration: snap.data[i].off > 0 ? TextDecoration.lineThrough : TextDecoration.none, fontWeight: FontWeight.bold
                                  )
                                ),
                                SizedBox(width: 15),
                                snap.data[i].off > 0
                                  ? Text('${(snap.data[i].price - (snap.data[i].price*snap.data[i].off)).toStringAsFixed(2)}\$', style: TextStyle(fontWeight: FontWeight.bold),)
                                  : Container()
                              ],
                            )),
                            IconButton(
                              icon: Icon(CupertinoIcons.shopping_cart),
                              onPressed: ()=>BlocProvider.of<ProductBloc>(context).add(AddToCart(product: snap.data[i]))
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  )
                );
              return Center(child: CupertinoActivityIndicator());
            },
          )
        ),
      ),
    );
  }
}