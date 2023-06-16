import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PromosiCard extends StatefulWidget {
  PromosiCard({
    super.key,
  });

  @override
  State<PromosiCard> createState() => _PromosiCardState();
}

class _PromosiCardState extends State<PromosiCard> {
  List<Map<String, dynamic>> ContentData = [
    {
      "judul": "Asus ROG",
      "highlightText": "Unbelievable Visual \n& Performances",
      "image": "assets/images/icons-time-attendance-clocks.png",
    },
    {
      "judul": "Lenovo",
      "highlightText": "Mesmerizing Visual \n& Stunning",
      "image": "assets/images/icons-employee-self-service.png"
    },
    {
      "judul": "Samsung",
      "highlightText": "Captivating Visual \n& Exceptional",
      "image": "assets/images/mask1.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ContentData.length,
          itemBuilder: (context, index) {
            return Container(
              height: 180,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 9, 52, 116),
                    Color.fromARGB(255, 110, 18, 127),
                    Color.fromARGB(255, 213, 39, 26),
                    Color.fromARGB(255, 199, 124, 12),
                    Color.fromARGB(255, 239, 216, 5)
                  ]),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.deepPurple.shade800,
                        offset: const Offset(0, 40),
                        blurRadius: 30,
                        spreadRadius: -35)
                  ],
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ContentData[index]['judul']!,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white60,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          ContentData[index]['highlightText']!,
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "Buy Now",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: Lottie.network(
                              "https://assets4.lottiefiles.com/private_files/lf30_wo5lnbyz.json"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
