import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormListElement extends StatelessWidget {
  var add;

  FormListElement({
    Key? key,
    required this.add
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final TextEditingController productController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    return Container(
      height: 55, // Add a fixed height here
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: productController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Nazwa",
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white24.withOpacity(0.1),
                filled: true,
              ),
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: priceController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Cena",
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white24.withOpacity(0.1),
                      filled: true,
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.add_box),
                  color: Colors.blueAccent,
                  onPressed: () {
                    if(priceController.text.isNotEmpty && productController.text.isNotEmpty) {
                      add(double.parse(priceController.text.trim()), productController.text.trim());
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
