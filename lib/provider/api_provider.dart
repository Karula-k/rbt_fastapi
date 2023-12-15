import 'package:barang_app/api/api_helper.dart';
import 'package:barang_app/api/barang.dart';
import 'package:barang_app/helper/enum.dart';
import 'package:flutter/cupertino.dart';

class ApiUserProvider extends ChangeNotifier {
  final ApiService apiService;
  ApiUserProvider({required this.apiService}) {
    fetchList();
  }

  List<Barang> _list = [];
  List<Barang> get list => _list;

  ResultState _state = ResultState.noData;
  ResultState get state => _state;

  String _message = "";
  String get message => _message;

  void update() {
    fetchList();
  }

  Future<void> fetchList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final listHeader = await apiService.readData();

      if (listHeader.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        _list = listHeader;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        _message = "No Data";
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = "Error: $e"; // capture the actual error message
    }
  }

  Future<void> addItem(Barang barang) async {
    try {
      final response = await apiService.addItem(barang);

      if (response.statusCode == 200) {
        fetchList();
      } else {
        throw Exception('Failed to add item');
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = "Error: $e";
    }
  }

  Future<void> editItem(int id, Barang barang) async {
    try {
      final response = await apiService.editItem(id, barang);

      if (response.statusCode == 200) {
        fetchList(); // Fetch the updated list after editing an item
      } else {
        throw Exception('Failed to edit item');
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = "Error: $e";
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      final response = await apiService.deleteItem(id);

      if (response.statusCode == 200) {
        fetchList();
      } else {
        throw Exception('Failed to delete item');
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = "Error: $e";
    }
  }
}
