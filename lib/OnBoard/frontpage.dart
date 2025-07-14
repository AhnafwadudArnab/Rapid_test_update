import 'package:flutter/material.dart';
import 'package:myproject/All%20in%20one/Registrations/signup.dart';

import '../../Widgets/Big_Contents_models.dart';
import '../../utils/dimensions.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Column(
                    children: [
                      Image.asset(
                        contents[i].image,
                        height: MediaQuery.of(context).size.height * 0.55,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: Dimensions.height30),
                      Text(
                        contents[i].title,
                        style: TextStyle(
                          fontSize:
                              Dimensions
                                  .font26, // Using Dimensions.font26 for font size
                          fontWeight:
                              FontWeight
                                  .bold, // Example styling, customize as needed
                          color:
                              Colors
                                  .black, // Example color, customize as needed
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      Text(
                        contents[i].description,
                        style: TextStyle(
                          fontSize: Dimensions.font15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndex == contents.length - 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              }
              _controller.nextPage(
                duration: const Duration(microseconds: 100),
                curve: Curves.bounceIn,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius35),
                color: Colors.blueAccent,
              ),
              height: 58,
              margin: const EdgeInsets.all(40.0),
              width: double.infinity,
              child: Center(
                child: Text(
                  currentIndex == contents.length - 1 ? "Start" : "Next",
                  style: TextStyle(
                    fontSize:
                        Dimensions
                            .font20, // Using Dimensions.font26 for font size
                    fontWeight:
                        FontWeight.bold, // Example styling, customize as needed
                    color: Colors.white, // Example color, customize as needed
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: Dimensions.height10,
      width: currentIndex == index ? 18 : 7,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius6),
        color: currentIndex == index ? Colors.blueAccent : Colors.black38,
      ),
    );
  }
}
