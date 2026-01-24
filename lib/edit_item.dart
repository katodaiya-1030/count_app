import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class EditItem extends StatefulWidget {
  final int itemIndex;
  final Item item;

  const EditItem({super.key, required this.itemIndex, required this.item});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _countController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _categoryController = TextEditingController(
      text: widget.item.category ?? '',
    );
    _countController = TextEditingController(text: '${widget.item.count}');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _countController.dispose();
    super.dispose();
  }

  void _updateItem() {
    if (_nameController.text.isEmpty || _countController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('アイテムの名前と数を入力してください')));
      return;
    }

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

    // アイテムを更新
    final itemProvider = context.read<ItemProvider>();
    final updatedItem = Item(name: name, category: category, count: count);

    itemProvider.updateItemDetails(widget.itemIndex, updatedItem);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('アイテムを更新しました')));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('アイテムを編集'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('キャンセル'),
                ),
                ElevatedButton(onPressed: _updateItem, child: const Text('更新')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
