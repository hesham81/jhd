import 'package:flutter/material.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';

class OrderWidget extends StatefulWidget {
  final List<CategoryDataModel> list;
  final bool isHaveInitialOption;
  final int indexOfInitialOption;
  final void Function(List<CategoryDataModel> categories) onTap;

  const OrderWidget({
    super.key,
    required this.list,
    this.isHaveInitialOption = false,
    this.indexOfInitialOption = 0,
    required this.onTap,
  });

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  final List<CategoryDataModel> _selectedItems = [];
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void dispose() {
    _removeOverlay(rebuild: false);
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _removeOverlay({bool rebuild = true}) {
    _overlayEntry?.remove();
    _overlayEntry = null;

    if (rebuild && mounted) {
      setState(() {
        _isOpen = false;
      });
    } else {
      _isOpen = false;
    }
  }

  void _notifyParent() {
    widget.onTap(List<CategoryDataModel>.from(_selectedItems));
  }

  void _showOverlay() {
    if (!mounted) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _removeOverlay(),
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 6),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 300),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: StatefulBuilder(
                      builder: (context, setOverlayState) {
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: widget.list.length,
                          separatorBuilder: (_, __) => Divider(
                            height: 1,
                            color: Colors.green[300],
                          ),
                          itemBuilder: (context, index) {
                            final item = widget.list[index];
                            final isSelected = _selectedItems.contains(item);

                            return InkWell(
                              borderRadius: index == 0
                                  ? const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    )
                                  : index == widget.list.length - 1
                                      ? const BorderRadius.vertical(
                                          bottom: Radius.circular(12),
                                        )
                                      : BorderRadius.zero,
                              onTap: () {
                                setOverlayState(() {
                                  if (isSelected) {
                                    _selectedItems.remove(item);
                                  } else {
                                    _selectedItems.add(item);
                                  }
                                });

                                if (mounted) {
                                  setState(() {});
                                }

                                _notifyParent();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: isSelected
                                              ? Colors.green[800]
                                              : Colors.black87,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check,
                                        color: Colors.green[700],
                                        size: 20,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    if (mounted) {
      setState(() {
        _isOpen = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _toggleDropdown,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _isOpen ? Colors.green : Colors.grey.shade400,
                  width: _isOpen ? 1.5 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedItems.isEmpty
                          ? 'Select Category'
                          : '${_selectedItems.length} selected',
                      style: TextStyle(
                        fontSize: 15,
                        color: _selectedItems.isEmpty
                            ? Colors.grey.shade500
                            : Colors.black87,
                        fontWeight: _selectedItems.isEmpty
                            ? FontWeight.normal
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_selectedItems.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _selectedItems.map((item) {
                return Chip(
                  label: Text(item.name),
                  deleteIcon: const Icon(Icons.close, size: 14),
                  onDeleted: () {
                    setState(() {
                      _selectedItems.remove(item);
                    });
                    _notifyParent();
                  },
                  backgroundColor: Colors.green[100],
                  side: BorderSide(color: Colors.green[300]!),
                  labelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
