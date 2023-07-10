import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllChannelScreen extends StatefulWidget {
  static const roudName = "/AllChannelScreen";

  const AllChannelScreen();

  @override
  State<AllChannelScreen> createState() => _AllChannelScreenState();
}

final myProducts = List<String>.generate(1000, (i) => 'Product $i');

class _AllChannelScreenState extends State<AllChannelScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            // the number of items in the list
            itemCount: myProducts.length,

            // display each item of the product list
            itemBuilder: (context, index) {
              return Card(
                // In many cases, the key isn't mandatory
                key: ValueKey(myProducts[index]),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(myProducts[index]),
                        Row(
                          children: [
                            Image.asset(
                              'assets/logoo.png',
                              width: 50,
                            ),
                            Text("$index"),
                          ],
                        ),
                      ],
                    )),
              );
            }));
  }
}
