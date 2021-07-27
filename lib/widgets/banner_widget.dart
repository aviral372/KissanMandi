import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';



class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
          width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width*0.63,
            color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Text(
                                  'VEGETABLES',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        letterSpacing: 1,
                                        fontSize: 18,
                                      ),
                                ),
                                SizedBox(height: 20,),
                              SizedBox(
                                height: 45.0,
                                child: DefaultTextStyle(
                                style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                  child: AnimatedTextKit(
                                    repeatForever: true,
                                      isRepeatingAnimation: true,
                                    animatedTexts: [
                                   FadeAnimatedText('Farm Fresh\nMarket Ready',
                                   duration: Duration(seconds: 4)),
                                   FadeAnimatedText('Stock them up',duration: Duration(seconds: 4)),
                                    FadeAnimatedText('Right Now!!!',duration: Duration(seconds: 4)),
                              ],
                              ),
                            ),
                          ),],
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/kissanmandi-87652.appspot.com/o/Banner%2Ficons8-group-of-vegetables-100.png?alt=media&token=9436a608-e254-4923-805a-2b7ddb921aa7'),
                              )

                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlueAccent,
                              shadowColor: Colors.blueGrey,
                              elevation: 6.0,
                            ),
                            child: Text('BUY'),
                          ),),
                          SizedBox(width: 20,),
                          Expanded(child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlueAccent,
                              shadowColor: Colors.blueGrey,
                              elevation: 6.0,
                              ),
                            child: Text('SELL'),
                          ),),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),),
    );
  }
}
