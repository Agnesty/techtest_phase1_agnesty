import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techtest_phase1_agnesty/models/data_model.dart';

class DetailProductScreen extends StatelessWidget {
  final DataModel dataModel;
  const DetailProductScreen({super.key, required this.dataModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.favorite_border))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 250,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: dataModel.gambar!,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      Image.asset('assets/images/placeholder.png'),
                  errorWidget: (context, url, error) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Gambar tidak bisa dimuat, check koneksi Anda',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataModel.title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        endIndent: 2,
                        indent: 2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Price",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          Container(
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.amber.shade300, width: 2)),
                            child: Center(
                                child: Text(
                              "Rp ${NumberFormat.decimalPattern('id-ID').format(int.parse(dataModel.price!))}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Qualifications",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        endIndent: 2,
                        indent: 2,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "By : LeptopIn",
                            style:
                                TextStyle(fontSize: 14, color: Colors.orange),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
