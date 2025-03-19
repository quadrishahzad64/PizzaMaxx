import 'package:flutter/material.dart';

import 'ProductCartPage.dart';

class shopItems extends StatefulWidget {
   const shopItems({super.key});

  @override
  State<shopItems> createState() => _shopItemsState();
}

class _shopItemsState extends State<shopItems> {

   List cartItems =<Map<String,dynamic>>  [];

  final List<Map<String, dynamic>> pizzaItems = [
     {'Pizza': 'Margherita Pizza', 'Price': 900, 'isFav': false},
     {'Pizza': 'Pepperoni Pizza', 'Price': 900, 'isFav': false},
     {'Pizza': 'BBQ Chicken Pizza', 'Price': 900, 'isFav': false},
     {'Pizza': 'Veggie Pizza', 'Price': 900, 'isFav': false},
     {'Pizza': 'Hawaiian Pizza', 'Price': 900, 'isFav': false},
   ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cartItems.length.toString())),
        body:
      ListView.builder(itemCount: pizzaItems.length,
      itemBuilder: (context,index){
      return Container(
        margin: EdgeInsets.only(bottom: 5),
        child: ListTile(
        tileColor: Colors.black,
        leading: const Icon(Icons.local_pizza),
           title: Text(pizzaItems[index]['Pizza']!, style: TextStyle(color: Colors.green, fontSize: 15),),
            subtitle: Text(pizzaItems[index]['Price']!.toString()),
        trailing: IconButton(onPressed: (){
          setState(() {
            pizzaItems[index]['isFav'] = !pizzaItems[index]['isFav'];
            if (pizzaItems[index]['isFav']) {
              cartItems.add(pizzaItems[index]);
            } else {
              cartItems.remove(pizzaItems[index]);
            }
          });
        }, icon: Icon(Icons.favorite),
          color: pizzaItems[index]['isFav'] ? Colors.red : Colors.grey,)
          ),
      );
           },
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()
      async
      {
        await Navigator.push(context,
            MaterialPageRoute(builder: (context)=> Cart(Items:cartItems)));
        setState(() {

        });
      }
        ,child: Icon(Icons.shop),),
    );
      }
      }
