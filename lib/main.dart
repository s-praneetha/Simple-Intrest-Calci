import 'package:flutter/material.dart';

void main()
{
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Intrest Calculator',
        home: SIForm(),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.brown,
        ),
      )
  );
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}
class _SIFormState extends State<SIForm>{

  var _formKey = GlobalKey<FormState>();

  var _curriences=['dollars','rupees','pounds'];
  final double _minipadding=5.0;
  var _currentItemSelected='';
  @override
  void initState(){
    super.initState();
    _currentItemSelected=_curriences[0];
  }

  TextEditingController principalController=TextEditingController();
  TextEditingController roiController=TextEditingController();
  TextEditingController termController=TextEditingController();

  var displayResult= '';

  @override
  Widget build(BuildContext context) {

                TextStyle textStyle=Theme.of(context).textTheme.title;

    return Scaffold(
      //resizeToAvoidBottomPadding:false ,
      appBar: AppBar(
        title: Text('Simple Intrest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child:Padding(
        padding: EdgeInsets.all(_minipadding*5),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
                padding: EdgeInsets.only(top: _minipadding,bottom: _minipadding),
                child:TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter principal amount';
                    }
                  },
                  decoration: InputDecoration(

                    labelText: 'Principal',
                    hintText: 'Enter Principal eg:12000',
                    errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15.0
                    ),
                    labelStyle: textStyle,
                    border : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: _minipadding,bottom: _minipadding),
                child:TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter rate of interest';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Rate of Intrest',
                    labelStyle: textStyle,
                    hintText: 'In Percent',
                    errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15.0
                    ),
                    border : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: _minipadding,bottom: _minipadding),
                child:Row(
                  children: <Widget>[
                    Expanded(child:TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter time';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Term',
                        labelStyle: textStyle,
                        hintText: 'time in years',
                        errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15.0
                        ),
                        border : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                      ),
                    )),
                    Container(
                      width: _minipadding*5,
                    ),
                    Expanded(child:DropdownButton<String>(
                      items: _curriences.map((String value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),

                        );
                      }).toList(),
                      value: _currentItemSelected,

                      onChanged: (String newValueSelected) {
                        // Your code to execute, when a menu item is selected from dropdown
                        _onDropDownItemSelected(newValueSelected);
                      },
                    ))
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(top: _minipadding,bottom: _minipadding),
                child:Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Colors.brown,
                        child: Text('Calculate',style: TextStyle(color:Colors.white,fontSize: 20.0),),
                        onPressed: (){
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  this.displayResult = _calculateTotalReturns();
                                }
                              });
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.brown,
                        child: Text('Reset',style: TextStyle(color:Colors.white,fontSize: 20.0),),
                        onPressed: (){
                          setState(() {
                            _reset();
                          });
                        },
                      ),),
                  ],)),
            Padding(
              padding: EdgeInsets.all(_minipadding*2),
              child: Text(this.displayResult,style: textStyle,),
            )
          ],

        ),
        )),
    );
  }
  Widget getImageAsset(){
    AssetImage assetImage=AssetImage('images/money.png');
    Image image=Image(
      image: assetImage,
      width: 255.0,
      height: 255.0,
    );
    return Container(child: image, margin: EdgeInsets.all(_minipadding*8),);
  }
void _onDropDownItemSelected(String newValueSelected){
    setState(() {
      this._currentItemSelected=newValueSelected;
    });
}
String _calculateTotalReturns(){
  double principal = double.parse(principalController.text);
  double roi = double.parse(roiController.text);
  double term = double.parse(termController.text);

  double totalAmountPayable = principal + (principal * roi * term) / 100;

  String result = 'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
  return result;
}
  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected=_curriences[0];
  }
}
