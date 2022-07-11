import 'package:flutter/material.dart';

import '../../models/field_model.dart';

class GameBoard extends StatelessWidget {
  final List<Field> fields;
  final Function onTap;

  const GameBoard({
    Key? key,
    required this.fields,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Center(
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            children: [
              for (int i = 0; i < fields.length; i++)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: InkWell(
                    onTap: () => onTap(i),
                    child: Center(
                      child: Text(
                        fields[i].symbol,
                        style: TextStyle(fontSize: 12.0 * fields[i].currentLevel),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
