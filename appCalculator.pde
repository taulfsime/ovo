class calculator extends application
{
  calculator() {super(new applicationInfo("data/apps/calculator.json"));}
  
  float fNum = 0.0;
  float sNum = 0.0;
  float result = 0.0;
  String operation = null;
  boolean showResult = false;

  button num0;
  button num1;
  button num2;
  button num3;
  button num4;
  button num5;
  button num6;
  button num7;
  button num8;
  button num9;

  button dot;
  button plus;
  button minus;
  button by;
  button divide;
  button equals;
  button percentage;
  button sqrt;

  button c;
  button ce;
  button backspace;

  button mc;
  button mr;
  button ms;
  button mPlus;
  button mMinus;

  button plusMinus;
  button inverse;

  label output;

  layout layout;

  void init()
  {
    layout = new layout(213, 285);
    mc = new button(11, 85, 34, 27, "MC");
    mr = new button(50, 85, 34, 27, "MR");
    ms = new button(89, 85, 34, 27, "MS");
    mPlus = new button(128, 85, 34, 27, "M+");
    mMinus = new button(167, 85, 34, 27, "M-");
    dot = new button(89, 245, 34, 27, ".");
    plus = new button(128, 245, 34, 27, "+");
    minus = new button(128, 213, 34, 27, "-");
    by = new button(128, 181, 34, 27, "*");
    divide = new button(128, 149, 34, 27, "/");
    equals = new button(167, 213, 34, 59, "=");
    inverse = new button(167, 181, 34, 27, "1/x");
    percentage = new button(167, 149, 34, 27, "%");
    plusMinus = new button(128, 117, 34, 27, "±");
    sqrt = new button(167, 117, 34, 27, "√");
    c = new button(89, 117, 34, 27, "C");
    ce = new button(50, 117, 34, 27, "CE");
    backspace = new button(11, 117, 34, 27, "<-");
    num0 = new button(11, 245, 73, 27, "0");
    num1 = new button(11, 213, 34, 27, "1");
    num2 = new button(50, 213, 34, 27, "2");
    num3 = new button(89, 213, 34, 27, "3");
    num4 = new button(11, 181, 34, 27, "4");
    num5 = new button(50, 181, 34, 27, "5");
    num6 = new button(89, 181, 34, 27, "6");
    num7 = new button(11, 149, 34, 27, "7");
    num8 = new button(50, 149, 34, 27, "8");
    num9 = new button(89, 149, 34, 27, "9");
    output = new label(11, 30, 190, 50, "");

    num0.bindKey('0');
    num1.bindKey('1');
    num2.bindKey('2');
    num3.bindKey('3');
    num4.bindKey('4');
    num5.bindKey('5');
    num6.bindKey('6');
    num7.bindKey('7');
    num8.bindKey('8');
    num9.bindKey('9');
    backspace.bindKey(BACKSPACE);
    plus.bindKey('+');
    minus.bindKey('-');
    by.bindKey('*');
    divide.bindKey('/');
    equals.bindKey(ENTER);
    ce.bindKey(DELETE);
    
    layout.addComponent(mc);
    layout.addComponent(mr);
    layout.addComponent(ms);
    layout.addComponent(mPlus);
    layout.addComponent(mMinus);
    layout.addComponent(dot);
    layout.addComponent(plus);
    layout.addComponent(minus);
    layout.addComponent(by);
    layout.addComponent(divide);
    layout.addComponent(equals);
    layout.addComponent(inverse);
    layout.addComponent(percentage);
    layout.addComponent(plusMinus);
    layout.addComponent(sqrt);
    layout.addComponent(c);
    layout.addComponent(ce);
    layout.addComponent(backspace);
    layout.addComponent(num0);
    layout.addComponent(num1);
    layout.addComponent(num3);
    layout.addComponent(num2);
    layout.addComponent(num4);
    layout.addComponent(num5);
    layout.addComponent(num6);
    layout.addComponent(num7);
    layout.addComponent(num8);
    layout.addComponent(num9);
    layout.addComponent(output);
    
    setLayout(layout);
  }

  void update()
  {
    String a = fNum + operation + sNum + "";
    output.setTextScale(max(30/( max(max(a.length() - 8, 1), (int) result)), 12));

    buttonClick();

    if (showResult)
    {
      output.setText(getResult() + "");
    } else
    {
      if (operation == null)
      {
        output.setText(fNum + "");
      } else
      {
        output.setText(fNum + operation + sNum + "");
      }
    }
  }

  float getResult()
  {
    if(operation != null)
    {
      switch(operation)
      {
      case "+":
        result = fNum + sNum;
        break;
  
      case "-":
        result = fNum - sNum;
        break;
  
      case "*":
        result = fNum * sNum;
        break;
  
      case "/":
        result = fNum / sNum;
        break;
      }
    }
    return result;
  }

  float setNum(float num, int addNum)
  {
    if (showResult)
    {
      fNum = 0.0;
      sNum = 0.0;
      result = 0.0;
      operation = null;

      showResult = false;
    }

    if (num == 0.0)
    {
      num = addNum;
    } else
    {
      if (num <= 999999)
      {
        num *= 10;
        num += addNum;
      }
    }
    return num;
  }

  void buttonClick()
  {
    //Buttons
    if (num0.isClicked())
    {
      if (operation == null)
      {
        fNum = setNum(fNum, 0);
      } else
      {
        sNum = setNum(sNum, 0);
      }
    } else if (num1.isClicked())
    {
      if (operation == null)
      {
        fNum = setNum(fNum, 1);
      } else
      {
        sNum = setNum(sNum, 1);
      }
    } else if (num2.isClicked())
    {
      if (operation == null)
      {
        fNum = setNum(fNum, 2);
      } else
      {
        sNum = setNum(sNum, 2);
      }
    } else if (num3.isClicked())
    {
      if (operation == null)
      {
        fNum = setNum(fNum, 3);
      } else
      {
        sNum = setNum(sNum, 3);
      }
    } else if (num4.isClicked())
    {
      if (operation == null)
      {
        fNum = setNum(fNum, 4);
      } else
      {
        sNum = setNum(sNum, 4);
      }
    } else if (num5.isClicked())
    {
      if (operation == null)
      {
        fNum = setNum(fNum, 5);
      } else
      {
        sNum = setNum(sNum, 5);
      }
    } else if (num6.isClicked())
    {
      if (operation == null)
      {
        fNum = setNum(fNum, 6);
      } else
      {
        sNum = setNum(sNum, 6);
      }
    } else if (num7.isClicked())
    {
      if (operation == null)
      {
        fNum = setNum(fNum, 7);
      } else
      {
        sNum = setNum(sNum, 7);
      }
    } else if (num8.isClicked())
    {
      if (operation == null)
      {
        fNum = setNum(fNum, 8);
      } else
      {
        sNum = setNum(sNum, 8);
      }
    } else if (num9.isClicked())
    {
      if (operation == null)
      {
        fNum = setNum(fNum, 9);
      } else
      {
        sNum = setNum(sNum, 9);
      }
    } 
    else if (dot.isClicked())
    {
      
    } else if (plus.isClicked())
    {
      operation = "+";
    } else if (minus.isClicked())
    {
      operation = "-";
    } else if (by.isClicked())
    {
      operation = "*";
    } else if (divide.isClicked())
    {
      operation = "/";
    } else if (equals.isClicked())
    {
      showResult = true;
    } else if (percentage.isClicked())
    {
    } else if (sqrt.isClicked())
    {
    } else if (c.isClicked())
    {
    } else if (ce.isClicked())
    {
      result = 0.0;
      fNum = 0.0;
      sNum = 0;
      showResult = false;
      operation = null;
    } 
    else if (backspace.isClicked())
    {
    } else if (mc.isClicked())
    {
    } else if (ms.isClicked())
    {
    } else if (mPlus.isClicked())
    {
    } else if (mMinus.isClicked())
    {
    } else if (sqrt.isClicked())
    {
    } else if (inverse.isClicked())
    {
    } else if (plusMinus.isClicked())
    {
    }
  }
}

class carCalculator extends application
{
  carCalculator() {super(new applicationInfo("data/apps/carCalculator.json"));}
  
  double lpk1 = 0, lpk2 = 0;
  double l1 = 0, l2 = 0;
  double cp1 = 0, cp2 = 0;

  textField[] enter;
  label[] texts;
  layout main;
  button finish;
  
  void init()
  {
    enter = new textField[7];
    texts = new label[6];
    
    main = new layout(275, 260);
    
    texts[1] = new label(10, 5, 125, 30, "Car1");
    texts[2] = new label(140, 5, 125, 30, "Car2");
    
    enter[0] = new textField(10, 40, 125, 30, "Fuel for 100km:");
    enter[1] = new textField(140, 40, 125, 30, "Fuel for 100km:");
    
    enter[2] = new textField(10, 75, 125, 30, "Price for liter:");
    enter[3] = new textField(140, 75, 125, 30, "Price for liter:");
    
    enter[4] = new textField(10, 110, 125, 30, "Price engine:");
    enter[5] = new textField(140, 110, 125, 30, "Price engine:");
    
    finish = new button(10, 150, 125, 30, "Calculate");
    texts[0] = new label(140, 150, 125, 30, "");
    
    texts[3] = new label(140, 185, 125, 30, "");
    enter[6] = new textField(10, 185, 125, 30, "km per year:");
    
    texts[4] = new label(10, 220, 125, 30, "");
    texts[5] = new label(140, 220, 125, 30, "");
    
    for(int a = 0; a < 7; a++)
    {
      enter[a].setFilter("0123456789.");
      main.addComponent(enter[a]);
    }
    main.addComponent(finish);
    
    for(int a = 0; a < 6; a++)
    {
      main.addComponent(texts[a]);
    }
    
    setLayout(main);
  }
  
  void update()
  {
    boolean active = true;
    for(int a = 0; a < 6; a++)
    {
      if(enter[a].getText() == "")
      {
        active = false;
      }
    }
    finish.setActive(active);
    
    if(finish.isClicked())
    {
      
      double a1 = Double.parseDouble(enter[0].getText());
      double a2 = Double.parseDouble(enter[1].getText());
      
      double b1 = Double.parseDouble(enter[2].getText());
      double b2 = Double.parseDouble(enter[3].getText());
      
      double c1 = Double.parseDouble(enter[4].getText());
      double c2 = Double.parseDouble(enter[5].getText());
      
      double d1 = Double.parseDouble(enter[6].getText());
      
      if(a1 > a2 && c1 < c2)
      {
        String r = String.format("%.2f", ((c2 - c1)/(a1*b1 - a2*b2))*100);
        texts[3].setText(String.format("%.2f", (dmax(c1, c2)/(a1*b1 - a2*b2))*100));
        texts[0].setText("" + r);
      }
      else if(a1 > a2 && c1 > c2)
      {
        String r = String.format("%.2f", ((c1 - c2)/(a2*b2 - a1*b1))*100);
        texts[3].setText(String.format("%.2f", (dmax(c1, c2)/(a2*b2 - a1*b1))*100));
        texts[0].setText("" + r);
      }
      
      texts[4].setText(String.format("%.2f", (a1*b1*d1/100)));
      texts[5].setText(String.format("%.2f", (a2*b2*d1/100)));
    }
  }
  
  double dmax(double m1, double m2)
  {
    if(m1 > m2)
    {
      return m1;
    }
    else
    {
      return m2;
    }
  }
}