import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/data_model.dart';

// ignore: must_be_immutable
class ItemProduct extends StatelessWidget {
  ItemProduct({super.key, required this.dataModel, required this.ontap});

  final DataModel dataModel;
  VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orange,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: SizedBox(
                    width: 200,
                    child: CachedNetworkImage(
                      imageUrl: dataModel.gambar!,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          Image.asset('assets/images/placeholder.png'),
                      errorWidget: (context, url, error) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
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
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  dataModel.title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
