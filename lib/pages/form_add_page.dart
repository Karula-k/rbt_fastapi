import 'package:barang_app/api/barang.dart';
import 'package:barang_app/helper/widget_helper.dart';
import 'package:barang_app/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormAddPage extends StatelessWidget {
  const FormAddPage({Key? key}) : super(key: key);
  static const routeName = '/formadd';

  @override
  Widget build(BuildContext context) {
    ApiUserProvider apiUserProvider =
        Provider.of<ApiUserProvider>(context, listen: false);
    TextEditingController controllerID = TextEditingController();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerHarga = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
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
                type: true,
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
          apiUserProvider.addItem(
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
