import 'package:barang_app/api/barang.dart';
import 'package:barang_app/helper/widget_helper.dart';
import 'package:barang_app/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormPage extends StatelessWidget {
  final Barang barang;
  const FormPage({Key? key, required this.barang}) : super(key: key);
  static const routeName = '/form';

  @override
  Widget build(BuildContext context) {
    ApiUserProvider apiUserProvider =
        Provider.of<ApiUserProvider>(context, listen: false);
    TextEditingController controllerID =
        TextEditingController(text: barang.idBarang.toString());
    TextEditingController controllerName =
        TextEditingController(text: barang.namaBarang);
    TextEditingController controllerHarga =
        TextEditingController(text: barang.harga.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        backgroundColor: const Color.fromARGB(255, 151, 49, 41),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormWidget(
                formName: 'Id barang',
                controller: controllerID,
                type: false,
              ),
              const SizedBox(height: 16.0),
              FormWidget(
                formName: 'Nama barang',
                controller: controllerName,
                type: true,
              ),
              const SizedBox(height: 16.0),
              FormWidget(
                formName: 'Harga barang',
                controller: controllerHarga,
                type: true,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 207, 115, 131),
        onPressed: () {
          apiUserProvider.editItem(
            int.parse(controllerID.text),
            Barang(
              idBarang: int.parse(controllerID.text),
              namaBarang: controllerName.text,
              harga: int.parse(controllerHarga.text),
            ),
          );
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
