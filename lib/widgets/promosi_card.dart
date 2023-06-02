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
  int currentPage = 0;
  List<Map<String, String>> ContentData = [
    {
      "judul": "Asus ROG",
      "highlightText": "Unbelievable Visual \n& Performances",
      "image": "assets/images/icons-time-attendance-clocks.png"
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
    return Flexible(
      flex: 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ContentData.length,
        itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ContentData[index]['judul']!,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      ContentData[index]['highlightText']!,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 35,
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                              fontSize: 16,
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
                      height: 130,
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
