import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemCard extends StatelessWidget {
  ItemCard({
    super.key,
  });

  List<Map<String, dynamic>> ContentData = [
    {
      "nama": "Laptop",
      "bnyk": "10 products",
      "icon": Icons.laptop_mac_rounded
    },
    {
      "nama": "Printer",
      "bnyk": "7 products",
      "icon": Icons.print_rounded
    },
    {
      "nama": "Gadget",
      "bnyk": "9 products",
      "icon": Icons.g_mobiledata_rounded
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5,
                child: Container(
                  height: 80,
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.purple,
                      ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            ContentData[index]['icon']!,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ContentData[index]['nama']!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            Text(
                              ContentData[index]['bnyk']!,
                              style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
