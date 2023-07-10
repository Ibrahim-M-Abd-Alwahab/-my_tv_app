import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_tv_app/Modules/Main/All/multyScreen/multy_screen.dart';

class FavorateChannelScreen extends StatefulWidget {
  static const roudName = "/FavorateChannelScreen";

  const FavorateChannelScreen();

  @override
  State<FavorateChannelScreen> createState() => _FavorateChannelScreenState();
}

final myProducts = List<String>.generate(1000, (i) => 'Product $i');

class _FavorateChannelScreenState extends State<FavorateChannelScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            // the number of items in the list
            itemCount: myProducts.length,

            // display each item of the product list
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(MultyScreen.roudName);
                },
                child: Card(
                    // In many cases, the key isn't mandatory
                    key: ValueKey(myProducts[index]),
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                              Text(myProducts[index]),
                            ],
                          ),
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
                      ),
                    )),
              );
            }));
  }
}
