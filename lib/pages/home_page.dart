import 'package:barang_app/api/barang.dart';
import 'package:barang_app/helper/enum.dart';
import 'package:barang_app/pages/form_add_page.dart';
import 'package:barang_app/pages/form_edit_page.dart';
import 'package:barang_app/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Data view"),
          backgroundColor: const Color.fromARGB(255, 151, 49, 41),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Consumer<ApiUserProvider>(
                builder: (context, result, _) {
                  if (result.state == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (result.state == ResultState.hasData ||
                      result.state == ResultState.endCheck) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        return Provider.of<ApiUserProvider>(context,
                                listen: false)
                            .update();
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: result.list.length + 1,
                        itemBuilder: (context, index) {
                          return index == result.list.length
                              ? const Center(
                                  child: Text("you have reached bottom page"))
                              : BarangTile(
                                  data: result.list[index],
                                );
                        },
                      ),
                    );
                  } else if (result.state == ResultState.noData) {
                    return Center(child: Text(result.message));
                  } else if (result.state == ResultState.error) {
                    return Center(child: Text(result.message));
                  } else {
                    return const Center(child: Text("Something wrong"));
                  }
                },
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 207, 115, 131),
                  onPressed: () {
                    Navigator.of(context).pushNamed(FormAddPage.routeName);
                  },
                  child: const Icon(Icons.add),
                ),
              )
            ],
          ),
        ));
  }
}

class BarangTile extends StatelessWidget {
  final Barang data;
  const BarangTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: Card(
          elevation: 2,
          child: ListTile(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(FormPage.routeName, arguments: data);
              },
              title: Text(
                data.namaBarang,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Harga RP. ${data.harga.toString()}",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              trailing: IconButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 207, 115, 131),
                  ))),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete ${data.namaBarang}?"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteItem(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(BuildContext context) {
    Provider.of<ApiUserProvider>(context, listen: false)
        .deleteItem(data.idBarang);
  }
}
