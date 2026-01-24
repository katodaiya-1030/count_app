import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'add_item.dart';
import 'edit_item.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('アイテムカウンター'),
      ),
      body: Column(
        children: [
          _SearchFilterSection(),
          Expanded(
            child: Consumer<ItemProvider>(
              builder: (context, itemProvider, child) {
                final filteredItems = itemProvider.filteredItems;

                if (itemProvider.items.isEmpty) {
                  return const Center(child: Text('アイテムを追加してください'));
                }

                if (filteredItems.isEmpty) {
                  return const Center(child: Text('条件に合うアイテムがありません'));
                }

                return ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    final originalIndex = itemProvider.items.indexOf(item);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                        if (item.category != null)
                                          Text(
                                            item.category!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(color: Colors.grey),
                                          ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => EditItem(
                                            itemIndex: originalIndex,
                                            item: item,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      itemProvider.removeItem(originalIndex);
                                    },
                                  ),
                                ],
                              ),
                              Center(
                                child: SizedBox(
                                  width: 80,
                                  child: Text(
                                    '${item.count}',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _CounterLabelButton(
                                    label: '-100',
                                    onPressed: () {
                                      if (item.count >= 100) {
                                        itemProvider.updateItem(
                                          originalIndex,
                                          item.count - 100,
                                        );
                                      }
                                    },
                                    onLongPressStart: () {
                                      if (item.count >= 100) {
                                        itemProvider.updateItem(
                                          originalIndex,
                                          item.count - 100,
                                        );
                                      }
                                    },
                                    onLongPressContinue: () {
                                      if (item.count >= 100) {
                                        itemProvider.updateItem(
                                          originalIndex,
                                          item.count - 100,
                                        );
                                      }
                                    },
                                  ),
                                  _CounterLabelButton(
                                    label: '-10',
                                    onPressed: () {
                                      if (item.count >= 10) {
                                        itemProvider.updateItem(
                                          originalIndex,
                                          item.count - 10,
                                        );
                                      }
                                    },
                                    onLongPressStart: () {
                                      if (item.count >= 10) {
                                        itemProvider.updateItem(
                                          originalIndex,
                                          item.count - 10,
                                        );
                                      }
                                    },
                                    onLongPressContinue: () {
                                      if (item.count >= 10) {
                                        itemProvider.updateItem(
                                          originalIndex,
                                          item.count - 10,
                                        );
                                      }
                                    },
                                  ),
                                  _CounterButton(
                                    icon: Icons.remove,
                                    onPressed: () {
                                      if (item.count > 0) {
                                        itemProvider.updateItem(
                                          originalIndex,
                                          item.count - 1,
                                        );
                                      }
                                    },
                                    onLongPressStart: () {
                                      if (item.count > 0) {
                                        itemProvider.updateItem(
                                          originalIndex,
                                          item.count - 1,
                                        );
                                      }
                                    },
                                    onLongPressContinue: () {
                                      if (item.count > 0) {
                                        itemProvider.updateItem(
                                          originalIndex,
                                          item.count - 1,
                                        );
                                      }
                                    },
                                  ),
                                  _CounterButton(
                                    icon: Icons.add,
                                    onPressed: () {
                                      itemProvider.updateItem(
                                        originalIndex,
                                        item.count + 1,
                                      );
                                    },
                                    onLongPressStart: () {
                                      itemProvider.updateItem(
                                        originalIndex,
                                        item.count + 1,
                                      );
                                    },
                                    onLongPressContinue: () {
                                      itemProvider.updateItem(
                                        originalIndex,
                                        item.count + 1,
                                      );
                                    },
                                  ),
                                  _CounterLabelButton(
                                    label: '+10',
                                    onPressed: () {
                                      itemProvider.updateItem(
                                        originalIndex,
                                        item.count + 10,
                                      );
                                    },
                                    onLongPressStart: () {
                                      itemProvider.updateItem(
                                        originalIndex,
                                        item.count + 10,
                                      );
                                    },
                                    onLongPressContinue: () {
                                      itemProvider.updateItem(
                                        originalIndex,
                                        item.count + 10,
                                      );
                                    },
                                  ),
                                  _CounterLabelButton(
                                    label: '+100',
                                    onPressed: () {
                                      itemProvider.updateItem(
                                        originalIndex,
                                        item.count + 100,
                                      );
                                    },
                                    onLongPressStart: () {
                                      itemProvider.updateItem(
                                        originalIndex,
                                        item.count + 100,
                                      );
                                    },
                                    onLongPressContinue: () {
                                      itemProvider.updateItem(
                                        originalIndex,
                                        item.count + 100,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    itemProvider.updateItem(originalIndex, 0);
                                  },
                                  icon: const Icon(Icons.restart_alt),
                                  label: const Text('リセット'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade300,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const AddItem()));
        },
        tooltip: 'アイテムを追加',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ...existing code...
class _SearchFilterSection extends StatefulWidget {
  const _SearchFilterSection();

  @override
  State<_SearchFilterSection> createState() => _SearchFilterSectionState();
}

class _SearchFilterSectionState extends State<_SearchFilterSection>
    with SingleTickerProviderStateMixin {
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _minCountController;
  late TextEditingController _maxCountController;
  late AnimationController _animationController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _categoryController = TextEditingController();
    _minCountController = TextEditingController();
    _maxCountController = TextEditingController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _minCountController.dispose();
    _maxCountController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '検索・フィルター',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: _toggleExpanded,
              ),
            ],
          ),
        ),
        SizeTransition(
          sizeFactor: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'アイテム名で検索',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _nameController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _nameController.clear();
                              context.read<ItemProvider>().setSearchName('');
                              setState(() {});
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    context.read<ItemProvider>().setSearchName(value);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    hintText: 'カテゴリで検索',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.category),
                    suffixIcon: _categoryController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _categoryController.clear();
                              context.read<ItemProvider>().setSearchCategory(
                                '',
                              );
                              setState(() {});
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    context.read<ItemProvider>().setSearchCategory(value);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _minCountController,
                        decoration: InputDecoration(
                          hintText: '数以上',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.trending_up),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          final count = int.tryParse(value);
                          context.read<ItemProvider>().setMinCount(count);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _maxCountController,
                        decoration: InputDecoration(
                          hintText: '数以下',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.trending_down),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          final count = int.tryParse(value);
                          context.read<ItemProvider>().setMaxCount(count);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    _nameController.clear();
                    _categoryController.clear();
                    _minCountController.clear();
                    _maxCountController.clear();
                    context.read<ItemProvider>().clearFilters();
                    setState(() {});
                  },
                  child: const Text('フィルターをリセット'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ...existing code...
class _CounterButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final VoidCallback onLongPressStart;
  final VoidCallback onLongPressContinue;

  const _CounterButton({
    required this.icon,
    required this.onPressed,
    required this.onLongPressStart,
    required this.onLongPressContinue,
  });

  @override
  State<_CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<_CounterButton> {
  bool _isLongPressed = false;

  @override
  void initState() {
    super.initState();
    _isLongPressed = false;
  }

  void _startLongPress() {
    _isLongPressed = true;
    widget.onLongPressStart();
    _continueLongPress();
  }

  Future<void> _continueLongPress() async {
    while (_isLongPressed && mounted) {
      await Future.delayed(const Duration(milliseconds: 250));
      if (_isLongPressed && mounted) {
        widget.onLongPressContinue();
      }
    }
  }

  void _stopLongPress() {
    _isLongPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) => _startLongPress(),
      onLongPressEnd: (_) => _stopLongPress(),
      child: IconButton(icon: Icon(widget.icon), onPressed: widget.onPressed),
    );
  }
}

class _CounterLabelButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final VoidCallback onLongPressStart;
  final VoidCallback onLongPressContinue;

  const _CounterLabelButton({
    required this.label,
    required this.onPressed,
    required this.onLongPressStart,
    required this.onLongPressContinue,
  });

  @override
  State<_CounterLabelButton> createState() => _CounterLabelButtonState();
}

class _CounterLabelButtonState extends State<_CounterLabelButton> {
  bool _isLongPressed = false;

  void _startLongPress() {
    _isLongPressed = true;
    widget.onLongPressStart();
    _continueLongPress();
  }

  Future<void> _continueLongPress() async {
    while (_isLongPressed && mounted) {
      await Future.delayed(const Duration(milliseconds: 250));
      if (_isLongPressed && mounted) {
        widget.onLongPressContinue();
      }
    }
  }

  void _stopLongPress() {
    _isLongPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) => _startLongPress(),
      onLongPressEnd: (_) => _stopLongPress(),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        ),
        child: Text(widget.label, style: const TextStyle(fontSize: 11)),
      ),
    );
  }
}
