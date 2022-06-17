import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({ Key? key }) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  var UserQuestion="";
  var UserAnswer="";


  final List<String> btns=
  [
    "C" , "Del" , "%" , "/",
    "9" , "8" , "7" , "x",
    "6" , "5" , "4" , "-",
    "3" , "2" , "1" , "+",
    "0" , "." , "Ans" , "=",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],

      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 50,),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(UserQuestion,style: TextStyle(fontSize: 20),)
                    ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(UserAnswer,style: TextStyle(fontSize: 50),)
                    ),
                ],
              ),

            ),
          ),
          Expanded(
            flex: 2, //2 times greater than top portion
            child: Container(
              child: GridView.builder(
               itemCount: btns.length,
               gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
               itemBuilder: (BuildContext context, int index){
               
               //Clear Button
               if (index==0)
               {
                  return Buttons(
                  ButtonTapped: (){
                    setState(() {
                      UserQuestion='';
                    });
                  },
                  ButtonText:btns[index] ,
                  Color_b:  Colors.green,
                  TextColor: Colors.white 
                );
               }
               //Delete Button
               else if(index==1)
               {
                  return Buttons(
                  ButtonTapped: (){
                    setState(() {
                      UserQuestion = UserQuestion.substring(0,UserQuestion.length-1);
                    });
                  },
                  ButtonText:btns[index] ,
                  Color_b:  Colors.red,
                  TextColor: Colors.white
                  );
               }
               //Equals Button
               else if(index==btns.length-1)
               {
                  return Buttons(
                  ButtonTapped: (){
                    setState(() {
                      EqualPressed();
                    });
                  },
                  ButtonText:btns[index] ,
                  Color_b:  Colors.deepPurple,
                  TextColor: Colors.white
                  );
               }
               else
               {
                 return Buttons(
                  ButtonTapped: (){
                    setState(() {
                      UserQuestion += btns[index];   
                    });
                    
                  },
                  ButtonText:btns[index] ,
                  Color_b: IsOperator(btns[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                  TextColor: IsOperator(btns[index])? Colors.white : Colors.deepPurple 
                );
               }
               }),

            ),
          ),
        ],
      ),
    );
  }

  //method
  bool IsOperator(String x)
  {
    if(x == "%" || x == "/" || x == "x" || x == "+" || x == "-" || x == "=" )
    {
      return true;
    }
    return false;
  }


  void EqualPressed() {
    String FinalQuestion=UserQuestion;
    
    FinalQuestion=FinalQuestion.replaceAll("x", "*");
    FinalQuestion=FinalQuestion.replaceAll("Ans", UserAnswer);

    Parser p = Parser();
    Expression exp = p.parse(FinalQuestion);

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    UserAnswer=eval.toString();
  }
}