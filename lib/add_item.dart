import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _countController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _countController.dispose();
    super.dispose();
  }

  void _addItem() {
    if (_nameController.text.isEmpty || _countController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('アイテムの名前と数を入力してください')));
      return;
    }

    // 数値が有効かチェック
    final count = int.tryParse(_countController.text);
    if (count == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('数には数字のみ入力してください')));
      return;
    }

    final name = _nameController.text;
    final category = _categoryController.text.isEmpty
        ? null
        : _categoryController.text;

    context.read<ItemProvider>().addItem(name, category, count);

    _nameController.clear();
    _categoryController.clear();
    _countController.clear();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('アイテムを追加しました')));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('アイテムを追加'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'アイテムの名前',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'カテゴリ（任意）',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _countController,
              decoration: const InputDecoration(
                labelText: '数',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _addItem, child: const Text('追加')),
          ],
        ),
      ),
    );
  }
}
