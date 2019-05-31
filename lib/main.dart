import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "";

  String currentNum = "";
  String result = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";
  bool fin = false;

  buttonPressed(String buttonText) {
    if (buttonText == "C" || fin) {
      currentNum = "";
      result = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
      fin = false;
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "X" ||
        buttonText == "/") {
      num1 = double.parse(currentNum);
      operand = buttonText;
      currentNum = "";
      result += buttonText;
    } else if (buttonText == ".") {
      if (currentNum.contains(".")) {
        print("Already contains a decimal");
        return;
      } else {
        currentNum += buttonText;
        result += buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(currentNum);
      if (operand == "+") {
        result = (num1 + num2).toString();
      }
      if (operand == "-") {
        result = (num1 - num2).toString();
      }
      if (operand == "X") {
        result = (num1 * num2).toString();
      }
      if (operand == "/") {
        result = (num1 / num2).toString();
      }
      fin = true;
    } else if (buttonText == "(" || buttonText == ")" || buttonText == "+/-") {
      if (result == "0") {
        result = buttonText;
      } else {
        result += buttonText;
      }
    } else {
      if (result == "0") {
        result = buttonText;
      } else {
        result += buttonText;
      }
      currentNum += buttonText;
    }

    setState(() {
      output = result;
    });
  }

  Color makeColor(String buttonText) {
    if (buttonText == "C") {
      return Colors.red;
    }
    if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "X" ||
        buttonText == "/") {
      return Colors.lightBlue;
    }
    if (buttonText == "=") {
      return Colors.green;
    }
    if (buttonText == "(" || buttonText == ")") {
      return Colors.orange;
    }
    if (buttonText == "+/-" || buttonText == ".") {
      return Colors.blue;
    }
    return Colors.lightBlueAccent;
  }

  sumColor() {
    if (fin) {
      return Color.fromRGBO(0, 51, 0, 100);
    }
    else {
      return null;
    }
  }

  Widget buildButton(String buttonText) {
    return new Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 18.0,
        color: makeColor(buttonText),
        clipBehavior: Clip.antiAlias,
        child: new MaterialButton(
          padding: new EdgeInsets.all(24.0),
          child: new Text(
            buttonText,
            style: TextStyle(
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              alignment: Alignment.centerRight,
              padding: new EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: new Text(
                output,
                style: new TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: sumColor(),
                ),
              ),
            ),
            new Expanded(
              child: new Divider(),
            ),
            new Column(children: [
              new Row(children: [
                buildButton("C"),
                buildButton("("),
                buildButton(")"),
                buildButton("/")
              ]),
              new Row(children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("X")
              ]),
              new Row(children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("-")
              ]),
              new Row(children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("+")
              ]),
              new Row(children: [
                buildButton("+/-"),
                buildButton("0"),
                buildButton("."),
                buildButton("=")
              ]),
            ])
          ],
        ),
      ),
    );
  }
}
