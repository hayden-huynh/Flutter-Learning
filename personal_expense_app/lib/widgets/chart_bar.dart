import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder grants access to the default sizing constraints of widgets
    // Use LayoutBuilder to dynamically size widgets based on their width/height constraints
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                // FittedBox: Prevent the child from growing but just allow shrinking
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight *
                  0.6, // The maximum height the whole chart bar can take
              width: 10,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                // First widget added is the bottom-most one
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              child: FittedBox(child: Text(label)),
              height: constraints.maxHeight * 0.15,
            ),
          ],
        );
      },
    );
  }
}
