
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplitBill extends StatefulWidget {
  @override
  _SplitBillState createState() => _SplitBillState();
}

class _SplitBillState extends State<SplitBill> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;
  @override
  Widget build(BuildContext context) {
    _saveBookmark() {
      debugPrint('Bookmark button pressed !!!');
    }

    _goBack() {
      debugPrint('Back button pressed !!!');
    }

    return Scaffold(

      appBar: AppBar(

        title: Text(
          'BillSplitter',
          style: TextStyle(color: Colors.deepPurple.shade100),

        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
            icon: Icon(
              Icons.backspace,
              color: Colors.deepPurple.shade100,
            ),
            onPressed: _goBack),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.deepPurple.shade100,
              ),
              onPressed: _saveBookmark),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.deepPurple,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            // Balance Box
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.deepPurple.shade100),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total Per Person',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.deepPurple),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('\$ ${calculateBill(_billAmount, _personCounter, _tipPercentage)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.deepPurple)),
                    ) //$3 cant be used as $ invokes identifier
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 35.0),
              padding: EdgeInsets.all(12.0),
              height: 350,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.deepPurple,
                    style: BorderStyle.solid,
                  )),
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: Colors.deepPurple),
                      decoration: InputDecoration(
                          hintText:'Bill Ammount',
                          prefixIcon: Icon(Icons.attach_money,color: Colors.deepPurple,)),
                      onChanged: (String value) {
                        try {
                          _billAmount = double.parse(value);
                        } catch (exception) {
                          _billAmount = 0.0;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Text(
                          'Split',
                          style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 17,),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_personCounter > 1) {
                                    _personCounter--;
                                  }
                                });
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.deepPurple),
                                child: Center(
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                        color: Colors.deepPurple.shade50,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '$_personCounter',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _personCounter++;
                                });
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.deepPurple),
                                child: Center(
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                        color: Colors.deepPurple.shade50,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Tip',
                          style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 17,),),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            '\$ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '$_tipPercentage%',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.deepPurple,
                          divisions: 10,
                          inactiveColor: Colors.deepPurple.shade100,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              _tipPercentage = value.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  calculateBill(double billAmount, int splitby, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitby, tipPercentage) + billAmount) /
            splitby;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitby, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}
