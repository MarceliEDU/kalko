import 'package:flutter/material.dart';

class ListElement extends StatefulWidget {
  final String product;
  final double price;
  final int displayAmount;
  final String documentId;
  final remove;
  final bool isChanged;
  final setChange;

  ListElement({
    Key? key,
    required this.documentId,
    required this.product,
    required this.price,
    required this.displayAmount,
    required this.remove,
    required this.isChanged,
    required this.setChange,
  }) : super(key: key);

  @override
  _ListElementState createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _amountController = TextEditingController(text: widget.displayAmount.toString());
    });
  }

  @override
  void didUpdateWidget(ListElement oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.displayAmount != int.tryParse(_amountController.text)) {
      _amountController.text = widget.displayAmount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF4AF4F7).withOpacity(0.1),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.product,
            style: const TextStyle(
              color: Colors.white, fontSize: 16,
            ),
          ),
          Row(
            children: [
              Text(
                "${widget.price.toStringAsFixed(2)} zł",
                style: const TextStyle(
                  color: Colors.white, fontSize: 16
                ),
              ),
              const SizedBox(width: 10,),
              Container(
                width: 70,
                child: TextField(
                  controller: _amountController,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(color: widget.isChanged == true? Colors.amber : Colors.lightGreenAccent, fontSize: 20),
                  onEditingComplete: () {
                    widget.setChange(int.parse(_amountController.text), widget.price);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white.withOpacity(0.05),
                    filled: true,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.remove(widget.price, widget.product);
                },
                icon: const Icon(Icons.delete),
                color: Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
