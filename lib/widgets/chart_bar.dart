import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(this.label, this.spendingAmount, this.spendingPecentageOfTotal,
      {Key? key})
      : super(key: key);

  final String label;
  final double spendingAmount;
  final double spendingPecentageOfTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
        ),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromARGB(255, 233, 233, 233),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPecentageOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
