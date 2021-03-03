import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewTransaction extends StatefulWidget {
  final Function newTransaction;
  NewTransaction(this.newTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController=TextEditingController();
  final _amountController=TextEditingController();
  DateTime _selectedDate;
  void _submitData(){
    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitle=_titleController.text;
    final enteredAmount=double.parse(_amountController.text);
    if(enteredTitle.isEmpty || enteredAmount<=0 || _selectedDate==null){
      return;
    }
    widget.newTransaction(
        enteredTitle,
        enteredAmount,
        _selectedDate,
    );
    Navigator.of(context).pop();
  }
  void _presentDatePicker(){
    showDatePicker(
        context: context, 
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
    ).then((pickedDate){
      if(pickedDate==null){
        return;
      }
      else{
        setState(() {
          _selectedDate=pickedDate;
        });
      }
    });
  }

@override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Card(
    elevation: 3,
    child: Container(
      //margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom+10,
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title',labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15),),
            controller: _titleController,
            onSubmitted: (_)=>_submitData(),
            //onChanged: (val)=>titleInput=val,
          ),

          TextField(
            decoration: InputDecoration(labelText: 'Amount',labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15),),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_)=>_submitData(),
            //onChanged: (val)=>amountInput=val,
          ),
          Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

              Text(_selectedDate== null?'No date chosen!':'Picked Date : ${DateFormat.yMMMd().format(_selectedDate)}',style: TextStyle(fontFamily: 'Quicksand',),),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Chose Date',style: TextStyle(fontWeight: FontWeight.bold),),
                onPressed: _presentDatePicker),
            ],),
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text('Add Transaction',style: TextStyle(fontWeight: FontWeight.bold),),
            onPressed: _submitData,
            textColor: Theme.of(context).textTheme.button.color,
          ),
        ],
      ),
    ),
),
  );
}
}
