import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final List Items;
  const Cart({super.key,required this.Items});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart'),),
   body:
   widget.Items.isEmpty ? Center(child: Text('List is Empty')):
   ListView.builder(
          itemCount: widget.Items.length,
          itemBuilder: (context,index){
            return
              ListTile(
              title: Text("${widget.Items[index]['Pizza']}"),
              subtitle: Text("${widget.Items[index]['Price']}"),
              trailing: IconButton(onPressed: (){
                setState(() {
                  widget.Items.removeAt(index);
                });
              }, icon: Icon(Icons.delete)),
            );

          }

    ),

    );
  }
}
