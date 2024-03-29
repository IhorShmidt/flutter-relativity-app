import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_relativity/classes/relativity_class.dart';
import 'package:flutter_relativity/utilities/constants.dart';

class RelativityScreen extends StatefulWidget {
  @override
  _RelativityScreenState createState() => _RelativityScreenState();
}

final gradientColors = [
  Color(0xFF73AEF5),
  Color(0xFF61A4F1),
  Color(0xFF478DE0),
  Color(0xFF398AE5),
];

class _RelativityScreenState extends State<RelativityScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Relativity relativity = new Relativity();

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildInput(positionName, number) {
    _onChanged(val) {
      var res = double.parse(val);
      setState(() {
        print(res);
        print(number);
        if (number == 1) {
          relativity.set1tNumber(res);
        }
        if (number == 2) {
          relativity.set2tNumber(res);
        }
        if (number == 3) {
          relativity.set3tNumber(res);
        }
        if (number == 4) {
          relativity.set4tNumber(res);
        }
      });
    }

//    relativity.onReset(()  {
//
//    })

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(positionName, style: kLabelStyle),
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          margin: EdgeInsets.only(bottom: 20.0),
          height: 60.0,
          width: 120.0,
          padding: EdgeInsets.only(left: 35, bottom: 15.0),
          child: TextField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            onChanged: _onChanged,
            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
            ),
          ),
        )
      ],
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
        stops: [0.1, 0.4, 0.7, 0.9],
      ),
    );
  }

  _resultBox() {
    var res = relativity.getResult().toStringAsFixed(2);

    return Container(
        child: ListTile(
            title: Container(
      alignment: Alignment.center,
      child: Text(
        res,
        style: TextStyle(
            fontFamily: 'OpenSans', fontSize: 30, color: Colors.white),
      ),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: buildBoxDecoration(),
                  ),
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 120.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          headingText,
                          SizedBox(height: 60.0),
                          buildFirstRow(),
                          buildSecondRow(),
                          SizedBox(height: 20.0),
                          _resultBox(),
                          SizedBox(height: 30.0),
//                          buildResetButton(), // todo: implement in future
                        ],
                      ),
                    ),
                  ),
                ]))));
  }

  Row buildFirstRow() {
    return Row(children: <Widget>[
      _buildInput('First', 1),
      Spacer(),
      _buildInput('Second', 2),
    ]);
  }

  Row buildSecondRow() {
    return Row(children: <Widget>[
      _buildInput('Third', 3),
      Spacer(),
      _buildInput('Fourth', 4),
    ]);
  }

  FlatButton buildResetButton() {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.white)),
      padding:
          EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
      child: Text("Reset",
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 30,
            color: Colors.white,
          )),
      onPressed: () {
        relativity.reset();
      },
    );
  }
}
