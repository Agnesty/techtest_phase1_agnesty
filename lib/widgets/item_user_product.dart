import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/data_model.dart';
import '../screens/edit_product_screen.dart';

class ItemProductUser extends StatelessWidget {
  const ItemProductUser(
      {super.key,
      required this.dataProduct,
      required this.gambar,
      required this.id,
      required this.price,
      required this.title});

  final DataModel dataProduct;
  final String title, price, gambar, id;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(3),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: gambar,
            fit: BoxFit.cover,
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
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
      subtitle: Text(
        "Rp ${NumberFormat.decimalPattern('id-ID').format(int.parse(price))}",
        style: const TextStyle(fontSize: 13),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.edit,
          size: 25,
        ),
        onPressed: () {
          // Navigator.of(context)
          //     .pushNamed(EditProductScreen.routeName, arguments: id);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => EditProductScreen(
                id: id,
                initialTitle: title,
                initialPrice: price,
                initialGambar: gambar,
                iniEdit: true,
              ),
            ),
          );
        },
        color: Colors.purple,
      ),
    );
  }
}
