import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './Widgets/Chart.dart';
import './Widgets/transaction_list.dart';
import './Widgets/new_transaction.dart';
import './models/transaction.dart';

void main(){
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(PersonalExpensesApp());
}
class PersonalExpensesApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'MyApp',
      theme:ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              title:TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            button: TextStyle(color: Colors.white),
          ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                title: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                  fontWeight:FontWeight.bold ,
                ),
            ),
        )
      ) ,
      home: MyHomepage(),
    );
  }

}
class MyHomepage extends StatefulWidget{
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  final List<Transaction> _userTransaction=[
  ];
  bool _showChart= false;
  List<Transaction> get _recentTransactions{
    return _userTransaction.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7) ),);
    }).toList();
  }
  void _addNewTransaction(String txTitle,double txAmount,DateTime txDate){
    final  newTx=Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(newTx);
    });

  }
  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((tx){
        return  tx.id==id;
      });
    });
  }

//for sliding add transaction window
  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context:ctx,builder: (_) {
      return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: (){},
        behavior: HitTestBehavior.opaque,

      );
    },);
  }
  void _startHelp(BuildContext ctx){
    showModalBottomSheet(context:ctx,builder: (_) {
      return Card(
        elevation: 5,
        margin: EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 60),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: GestureDetector(
                child: Text(
                  'How to use this App ?',
                  style: TextStyle(
                      fontSize: 25,fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                onTap: (){},
                behavior: HitTestBehavior.opaque,

              ),

            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
              padding: EdgeInsets.all(5),
              child: Text('1) This app is useful for recording your daily transactions.',style: TextStyle(fontSize: 15,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
              padding: EdgeInsets.all(5),
              child: Text('2) To record a transaction , click on \'+\' below on your screen.',style: TextStyle(fontSize: 15,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                padding: EdgeInsets.all(5),
                child: Text('3)Choose the title , amount and date of transaction.',style: TextStyle(fontSize: 15,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                padding: EdgeInsets.all(5),
                child: Text('4) You can see your spending of a day in a chart bar.',style: TextStyle(fontSize: 15,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
            ),

          ],
        ),
      );
    },);
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape = MediaQuery.of(context).orientation==Orientation.landscape;
    final appbar =AppBar(
      //centerTitle: true,
      title: Text('Personal Expenses'),
      //backgroundColor: Colors.lightBlue,
      actions: [
        IconButton(
          icon: Icon(Icons.help),
          onPressed: ()=>_startHelp(context),)
      ],
    );
    final txWidget= Container(
        height: (MediaQuery.of(context).size.height-appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.75,
        child: TransactionList(_userTransaction,_deleteTransaction));
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch ,
          children: [
           if(isLandScape) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: deprecated_member_use
                  Text('Show Chart',style:TextStyle(fontFamily: 'Quicksand')),
                  Switch(value: _showChart,onChanged: (val){
                  setState(() {
                    _showChart=val;
                  });
                  }),
              ],
            ),
           if(!isLandScape) Container(
               height: (MediaQuery.of(context).size.height-appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
               child: Chart(_recentTransactions)),
           if(!isLandScape) txWidget,
            if(isLandScape) _showChart?Container(
                height: (MediaQuery.of(context).size.height-appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.6,
               child: Chart(_recentTransactions)):
                txWidget
         ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,),
        onPressed: ()=>_startAddNewTransaction(context ),
        //backgroundColor: Colors.lightBlue,
      ),
    );
  }
}