import'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return  transactions.isEmpty
            ? LayoutBuilder(builder: (ctx,cnsts){
              return Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.title,
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                      height: cnsts.maxHeight*0.4 ,
                      child: Image.asset('assests/images/waiting.png',fit: BoxFit.cover,)),
                ],);
    },)
        : ListView.builder(
          itemBuilder: (ctx,index){
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 4 , horizontal: 5),
              child: ListTile(leading : CircleAvatar(radius: 35,child:Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FittedBox(child: Text('₹${transactions[index].amount}')),
                     ),
                  ),
                  // ignore: deprecated_member_use
                  title: Text(transactions[index].title,style: Theme.of(context).textTheme.title,),
                  subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                  ),
                trailing: MediaQuery.of(context).size.width>360
                    ?
                      FlatButton.icon(
                        icon: const Icon(Icons.delete,color: Colors.grey,),
                        label: const Text('Delete',style: TextStyle(color: Colors.grey),),
                        onPressed: ()=>deleteTx(transactions[index].id) ,
                      )
                    :
                  IconButton(
                  icon: const  Icon(Icons.delete),
                  onPressed: ()=>deleteTx(transactions[index].id) ,
                ),
                ),
            );
          },
          itemCount: transactions.length,
        );
  }
}
