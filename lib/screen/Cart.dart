import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../module/class.dart';
import '../module/ProductBloc.dart';
import 'product.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, BlocState>(
      builder: (context, state)=>Scaffold(
        appBar: AppBar(
          title: Text('Shopping Cart'),
          actions: [
            BlocProvider.of<ProductBloc>(context).cartProducts.length>0
              ? IconButton(
                  icon: Icon(CupertinoIcons.trash),
                  onPressed: ()=>BlocProvider.of<ProductBloc>(context).add(ClearCart()),
                )
              : Container()
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 12,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    child: Text('Total Products in cart: ${BlocProvider.of<ProductBloc>(context).cartProducts.length}', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: BlocProvider.of<ProductBloc>(context).cartProducts.length,
                    itemBuilder: (context, idx){
                      Product _prd = BlocProvider.of<ProductBloc>(context).cartProducts[idx];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage(_prd.picurl)),
                              SizedBox(width: 25),
                              Expanded(child: Text('${_prd.name}')),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('${_prd.price}\$', style: TextStyle(color: _prd.off > 0 ? Colors.red : Colors.black, decoration: _prd.off > 0 ? TextDecoration.lineThrough : TextDecoration.none, fontWeight: FontWeight.bold),),
                                    _prd.off > 0
                                      ? Text('${(_prd.price - (_prd.price*_prd.off)).toStringAsFixed(2)}\$', style: TextStyle(fontWeight: FontWeight.bold),)
                                      : Container()
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(CupertinoIcons.trash, color: Colors.red),
                                onPressed: ()=>BlocProvider.of<ProductBloc>(context).add(DelFromCart(product: _prd)),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),
                BlocProvider.of<ProductBloc>(context).cartProducts.length>0
                  ? Card(
                      elevation: 12,
                      child: Container(
                        width: double.infinity,
                        color: Colors.deepOrange,
                        padding: EdgeInsets.all(12),
                        child: Text('Total Price: ${BlocProvider.of<ProductBloc>(context).cartProducts.reduce((val, element)=>Product(price: val.price+(element.price - (element.price*element.off)))).price.toStringAsFixed(2)}\$', style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    )
                  : Container()
              ],
            )
          ),
        ),
      )
    );
  }
}