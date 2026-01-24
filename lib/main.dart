import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';
import 'item_list.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeLocalStorage();
  runApp(const MyApp());
}

final localStorage = LocalStorage('count_app.json');

Future<void> initializeLocalStorage() async {
  await localStorage.ready;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child: MaterialApp(
        title: 'Count App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ItemList(),
      ),
    );
  }
}

// モデルクラス
class Item {
  String name;
  String? category;
  int count;

  Item({required this.name, this.category, required this.count});

  // JSON に変換
  Map<String, dynamic> toJson() {
    return {'name': name, 'category': category, 'count': count};
  }

  // JSON から復元
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] as String,
      category: json['category'] as String?,
      count: json['count'] as int,
    );
  }
}

// Provider クラス
class ItemProvider extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;
  String _searchName = '';
  String _searchCategory = '';
  int? _minCount;
  int? _maxCount;

  String get searchName => _searchName;
  String get searchCategory => _searchCategory;
  int? get minCount => _minCount;
  int? get maxCount => _maxCount;

  List<Item> get filteredItems {
    return _items.where((item) {
      final nameMatch = item.name.toLowerCase().contains(
        _searchName.toLowerCase(),
      );
      final categoryMatch =
          _searchCategory.isEmpty ||
          (item.category?.toLowerCase() ?? '').contains(
            _searchCategory.toLowerCase(),
          );
      final minCountMatch = _minCount == null || item.count >= _minCount!;
      final maxCountMatch = _maxCount == null || item.count <= _maxCount!;

      return nameMatch && categoryMatch && minCountMatch && maxCountMatch;
    }).toList();
  }

  ItemProvider() {
    loadItems();
  }

  // ローカルストレージからデータを読み込み
  Future<void> loadItems() async {
    try {
      await localStorage.ready;
      final data = localStorage.getItem('items');
      if (data != null) {
        final List<dynamic> jsonList = jsonDecode(data);
        _items.clear();
        _items.addAll(jsonList.map((item) => Item.fromJson(item)));
        notifyListeners();
      }
    } catch (e) {
      print('Error loading items: $e');
    }
  }

  // ローカルストレージにデータを保存
  Future<void> _saveItems() async {
    try {
      await localStorage.ready;
      final jsonList = _items.map((item) => item.toJson()).toList();
      await localStorage.setItem('items', jsonEncode(jsonList));
    } catch (e) {
      print('Error saving items: $e');
    }
  }

  void addItem(String name, String? category, int count) {
    _items.add(Item(name: name, category: category, count: count));
    _saveItems();
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    _saveItems();
    notifyListeners();
  }

  void updateItem(int index, int newCount) {
    _items[index].count = newCount;
    _saveItems();
    notifyListeners();
  }

  void updateItemDetails(int index, Item updatedItem) {
    _items[index] = updatedItem;
    _saveItems();
    notifyListeners();
  }

  void setSearchName(String name) {
    _searchName = name;
    notifyListeners();
  }

  void setSearchCategory(String category) {
    _searchCategory = category;
    notifyListeners();
  }

  void setMinCount(int? count) {
    _minCount = count;
    notifyListeners();
  }

  void setMaxCount(int? count) {
    _maxCount = count;
    notifyListeners();
  }

  void clearFilters() {
    _searchName = '';
    _searchCategory = '';
    _minCount = null;
    _maxCount = null;
    notifyListeners();
  }
}
