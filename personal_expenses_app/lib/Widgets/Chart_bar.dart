import 'package:flutter/material.dart';
class  ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final spendingPercentageOfTotal;
  const ChartBar(this.label,this.spending,this.spendingPercentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
      return Column(children: [
        Container(
            height:constraints.maxHeight*0.15,
            child: FittedBox(
              // ignore: deprecated_member_use
                child: Text('\₹${spending.toStringAsFixed(0)}',style: Theme.of(context).textTheme.title,))),
        SizedBox(height: constraints.maxHeight*0.05,),
        Container(
          height: constraints.maxHeight*0.6,
          width: 10,
          child:Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12,width: 1 ),
                color: Color.fromRGBO(220,220,220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPercentageOfTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],),
        ),
        SizedBox(
          height: constraints.maxHeight*0.05,
        ),
        // ignore: deprecated_member_use
        Container(
            height: constraints.maxHeight*0.15,
            child:FittedBox(

                child: Text(
                  // ignore: deprecated_member_use
                  label,style: Theme.of(context).textTheme.title,))),
      ],);
    },);
  }
}
