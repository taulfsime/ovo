
/***************************
 - Component
 - Collision Box
 - Button
 - Label
 - Switch Button
 - Progress Bar
 - Text Field
 - Text Area
 - Layout
 - Slider
 - Item List
 - Image
 - CheckBox
 - Scroll Bar
 - Text 
 ***************************/

//Component
class component
{
  public int tx = 0;
  public int ty = 0;

  public int x;
  public int y;
  public int w;
  public int h;
    
  public boolean isActive = true;
  public boolean isEnable = true;

  final int borderWidth = 1;
  color normal = color(183, 183, 183);
  color over = color(165, 165, 165);
  color click = color(135, 135, 135);
  color border = color(127, 127, 127);

  component(int x, int y, int w, int h) 
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  component(int x, int y) 
  {
    this.x = x;
    this.y = y;
    this.w = 100;
    this.h = 50;
  }
  
  void setActive(boolean active)
  {
    isActive = active;
  }
  
  void setEnable(boolean enable)
  {
    isEnable = enable;
  }

  void updateComponent(int x, int y)
  {
    this.x = x;
    this.y = y;
  }

  void updateComponent(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void translate(int x, int y)
  {
    this.tx = x;
    this.ty = y;
  }

  void render() {}
}

//Collision Box
//class collisionBox extends component
//{
//  collisionBox(int x, int y, int w, int h) 
//  {
//    super(x, y, w, h);
//  }

//  public boolean isOver()
//  {
//    if (isActive)
//    {
//      return (mouseX >= (x + tx) && mouseX <= (x + ty + w) && mouseY >= (y + ty) && mouseY <= (y + h + ty));
//    }
//    return false;
//  }
//}

//Button
class button extends component
{
  String text = null;
  PImage img = null;
  PImage img1 = null, img2 = null;
  char bindKey;
  boolean useBindKey = false;
  text showText;

  button(int xPos, int yPos, int xLength, int yLength, String text)
  {
    super(xPos, yPos, xLength, yLength);
    if (this.img == null)
    {
      this.text = text;
      showText = new text(w - borderWidth*2);
    }
  }

  button(int xPos, int yPos, int xLength, int yLength, PImage image)
  {
    super(xPos, yPos, xLength, yLength);
    if (this.text == null)
    {
      this.img = image;
    }
  }
  
  button(int xPos, int yPos, int xLength, int yLength, PImage image, PImage image1)
  {
    super(xPos, yPos, xLength, yLength);
    if (this.text == null)
    {
      this.img = image;
      this.img1 = image1;
    }
  }

  button(int xPos, int yPos, int xLength, int yLength, PImage normal, PImage over, PImage clicked)
  {
    super(xPos, yPos, xLength, yLength);
    if (this.text == null)
    {
      this.img = normal;
      this.img1 = over;
      this.img2 = clicked;
    }
  }
  
  void bindKey(char bKey)
  {
    bindKey = bKey;
    useBindKey = true;
  }
  
  boolean isOver()
  {
    if(mouseX > tx + x && mouseX < tx + x + w && mouseY > ty + y && mouseY < ty + y + h)
    {
      return true;
    }
    
    return false;
  }
  
  boolean isClicked()
  {
    if(isActive && isOver() && mouseClicked)
    {
      return true;
    }
    
    return false;
  }

  void render()
  {
    if (img2 == null)
    {
      noStroke();
      fill(border);
      rect(x + tx, y + ty, w, h);
    }
    
    if(isEnable)
    {
      if (isActive && (isOver() || (keyClicked && key == bindKey && useBindKey)))
      {
        if (isClicked() || (keyClicked && key == bindKey && useBindKey))
        {
          noStroke();
          fill(click); //clicked
        } 
        else
        {
          noStroke();
          fill(over); //over
        }
      } 
      else
      {
        noStroke();
        fill(normal); //normal
      }
    }
    else
    {
      if(img1 == null)
      {
        noStroke();
        fill(click); //normal
      }
      else
      {
        noStroke();
        fill(normal); //normal
      }
    }

    if (img2 == null)
    {
      rect(x + borderWidth + tx, y + borderWidth + ty, w - borderWidth*2, h - borderWidth*2);
    }

    if (this.text == null && this.img != null && this.img1 == null && this.img2 == null)               //image
    {
      image(this.img, this.x + this.w*0.15 + tx, this.y + this.h*0.15 + ty, this.w*0.7, this.h*0.7);
    } 
    else if (this.text != null && this.img == null)                                                   //text
    {
      fill(0);
      textSize((int) (this.h * 0.5));
      String t = showText.toString(this.text);
      text(t, this.x + tx + this.w/2 - textWidth(t)/2, this.y + ty + this.h*2/3);
    } 
    else if(this.text == null && this.img != null && this.img1 != null && this.img2 == null)          //image x2
    {
      if(isEnable)
      {
        image(this.img, this.x + this.w*0.15 + tx, this.y + this.h*0.15 + ty, this.w*0.7, this.h*0.7);
      }
      else
      {
        image(this.img1, this.x + this.w*0.15 + tx, this.y + this.h*0.15 + ty, this.w*0.7, this.h*0.7);
      }
    }
    else if (this.text == null && this.img != null && this.img1 != null && this.img2 != null)        //image x3
    {
      if (isClicked())
      {
        image(img2, x + tx, y + ty, w, h);  //clicked
      } 
      else if (isOver())
      {
        image(img1, x + tx, y + ty, w, h); //over
      } 
      else
      {
        image(img, x + tx, y + ty, w, h); //normal
      }
    }
  }

  void setText(String text)
  {
    if (img == null && img1 == null && img2 == null)
    {
      this.text = text;
    }
  }

  String getText()
  {
    return text;
  }

  void setImage(PImage image)
  {
    if (text == null && img1 == null && img2 == null)
    {
      this.img = image;
    }
  }
  
  void setImage(PImage image, PImage image1)
  {
    if (text == null && img2 == null)
    {
      this.img = image;
      this.img1 = image1;
    }
  }

  void setImage(PImage image, PImage image1, PImage image2)
  {
    if (text == null)
    {
      this.img = image;
      this.img2 = image1;
      this.img2 = image2;
    }
  }
}

//Label
class label extends component
{
  String text = null;
  PImage img = null;
  int textScale;
  text showText;
  boolean isActive = true;

  label(int xPos, int yPos, int xLength, int yLength, String text) 
  {
    super(xPos, yPos, xLength, yLength);
    if (this.img == null)
    {
      this.text = text;
      showText = new text(w);
    }

    textScale = (int) (h * 0.5);
  }

  label(int xPos, int yPos, int xLength, int yLength, PImage image) 
  {
    super(xPos, yPos, xLength, yLength);
    if (this.text == null)
    {
      this.img = image;
    }

    textScale = (int) (h * 0.5);
  }
  
  void setActive(boolean active)
  {
    isActive = active;
  }

  void setTextScale(int scale)
  {
    this.textScale = scale;
  }
  
  boolean isOver()
  {
    if(mouseX > tx + x && mouseX < tx + x + w && mouseY > ty + y && mouseY < ty + y + h)
    {
      return true;
    }
    
    return false;
  }

  void render()
  {
    if (text == null && img != null)
    {
      noStroke();
      fill(border);
      rect(x + tx, y + ty, w, h);
      fill(normal);
      rect(x + borderWidth + tx, y + borderWidth + ty, w - borderWidth*2, h - borderWidth*2);
      image(img, x + borderWidth + tx, y + borderWidth + ty, w - borderWidth*2, h - borderWidth*2);
    } 
    else if (text != null && img == null)
    {
      noStroke();
      fill(border);
      rect(x + tx, y + ty, w, h);
      fill(normal);
      rect(x + borderWidth + tx, y + borderWidth + ty, w - borderWidth*2, h - borderWidth*2);

      fill(0);
      textSize(textScale);
      String t = showText.toString(text);
      text(t, x + tx + w/2 - (int) textWidth(t)/2, y + ty + h*2/3);
    }
  }

  String getText()
  {
    return text;
  }

  void setText(String text)
  {
    this.text = text;
    if (this.img != null)
    {
      this.img = null;
    }
  }

  void setImage(PImage image)
  {
    this.img = image;
    if (this.text != null)
    {
      this.text = null;
    }
  }
}

//Switch Button
class switchButton extends component
{
  boolean isClicked = false;
  PImage imgOff = null;
  PImage imgOn = null;
  String text = null;
  text showText;
  boolean isActive = true;

  switchButton(int xPos, int yPos, int xLength, int yLength, String text)
  {
    super(xPos, yPos, xLength, yLength);
    this.text = text;
    showText = new text(w);
  }

  switchButton(int xPos, int yPos, int xLength, int yLength, PImage imgON, PImage imgOFF)
  {
    super(xPos, yPos, xLength, yLength);
    this.imgOn = imgON;
    this.imgOff = imgOFF;
  }

  switchButton(int xPos, int yPos, int xLength, int yLength, PImage img)
  {
    super(xPos, yPos, xLength, yLength);
    this.imgOn = img;
  }
  
  void setActive(boolean active) 
  {
    this.isActive = active;
  }

  void setClicked(boolean clicked)
  {
    isClicked = clicked;
  }

  String getText()
  {
    return text;
  }

  void setText(String text)
  {
    if (imgOn == null && imgOff == null)
    {
      this.text = text;
    }
  }
  
  boolean isOver()
  {
    if(mouseX > tx + x && mouseX < tx + x + w && mouseY > ty + y && mouseY < ty + y + h)
    {
      return true;
    }
    
    return false;
  }
  
  boolean isClicked()
  {
    return isClicked;
  }

  void setImage(PImage img)
  {
    if (text == null)
    {
      this.imgOn = img;
    }
  }

  void setImage(PImage imgON, PImage imgOFF)
  {
    if (text == null)
    {
      this.imgOn = imgON;
      this.imgOff = imgOFF;
    }
  }

  void render()
  {

    if (isActive)
    {
      if (isOver())
      {
        if (mouseClicked)
        {
          isClicked = !isClicked;
        }
      }
    }

    noStroke();
    fill(border);
    rect(x + tx, y + ty, w, h);

    if (text == null && imgOn != null && imgOff != null)
    {
      if (isClicked)
      {
        image(this.imgOn, this.x + borderWidth + tx, this.y + borderWidth + ty, this.w - borderWidth*2, this.h - borderWidth*2);
      } 
      else
      {
        image(this.imgOff, this.x + borderWidth + tx, this.y + borderWidth + ty, this.w - borderWidth*2, this.h - borderWidth*2);
      }
    } 
    else
    {   
      if (isClicked)
      {
        fill(click);
      } 
      else 
      {
        if (isOver())
        {
          fill(over);
        } 
        else
        {
          fill(normal);
        }
      }

      rect(x + borderWidth + tx, y + borderWidth + ty, w - borderWidth*2, h - borderWidth*2);

      if (imgOn == null)
      {
        fill(0);
        textSize((int) (this.h * 0.5));
        String t = showText.toString(text);
        text(t, this.x + tx + this.w/2 - textWidth(t)/2, this.y + ty + this.h*2/3);
      } 
      else
      {
        image(this.imgOn, this.x + borderWidth + tx, this.y + borderWidth + ty, this.w - borderWidth*2, this.h - borderWidth*2);
      }
    }
  }
}

//Progress Bar
class progressBar extends component
{
  float percentage = 0;
  boolean showPercentage = false;
  color bar = color(0, 255, 0);
  text showText;
  boolean isActive = true;

  progressBar(int xPos, int yPos, int xLength, int yLength) 
  {
    super(xPos, yPos, xLength, yLength);
  }
  
  void setActive(boolean active)
  {
    isActive = active;
  }

  float getPercentage()
  {
    return percentage;
  }
  
  boolean isOver()
  {
    if(mouseX > tx + x && mouseX < tx + x + w && mouseY > ty + y && mouseY < ty + y + h)
    {
      return true;
    }
    
    return false;
  }

  void showPercentage(boolean show)
  {
    showPercentage = show;
    showText = new text(w);
  }
  
  void setColor(int red, int green, int blue)
  {
    bar = color(red, green, blue);
  }

  void setProgress(float percentage)
  {
    if(percentage < 0)
    {
      percentage = 0;
    } 
    else if(percentage > 1)
    {
      percentage = 1;
    } 
    else 
    {
      this.percentage = percentage;
    }
  }

  void render()
  {
    fill(border);
    rect(x + tx, y + ty, w, h);
    
    fill(normal);
    rect(x + borderWidth + tx + percentage*(w - borderWidth*2), y + ty + borderWidth, w - percentage*(w - borderWidth*2) - borderWidth*2, h - borderWidth*2);
    
    fill(bar);
    rect(x + borderWidth + tx, y + ty + borderWidth, percentage*(w - borderWidth*2), h - borderWidth*2);

    if (showPercentage)
    {
      String per = showText.toString((int) (percentage*100) + " %");
      textSize(12);
      fill(0, 0, 0);
      text(per, tx + x + w/2 - textWidth(per)/2, ty + y + h*0.62);
    }
  }
}

//Text Field
class textField extends component
{
  color textColor = color(0, 0, 0);
  String text = "";
  String dText = "";
  boolean enterText = false;
  final String symbols = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM><.,0123456789*-+=!?& /[]{}()";
  String filter = null;
  ArrayList<String> library = new ArrayList<String>();
  String example = null;
  int maxSymbols = 0;
    
  textField(int xPos, int yPos, int xLength, int yLength, String displayText)
  {
    super(xPos, yPos, xLength, yLength);
    this.dText = displayText;
  }
  
  void setMaxSymbols(int n)
  {
    if(n >= 0)
    {
      maxSymbols = n;
    }
  }
  
  String getText()
  {
    if(text.length() == 0)
    {
      return "";
    }
    return text;
  }
  
  void setFilter(String f)
  {
    filter = f;
  }
  
  void setText(String t)
  {
    text = t;
  }
  
  void addToLibrary(String text)
  {
    library.add(text);
  }

  boolean isOver()
  {
    if(mouseX > tx + x && mouseX < tx + x + w && mouseY > ty + y && mouseY < ty + y + h)
    {
      return true;
    }
    
    return false;
  }
  
  boolean isClicked()
  {
    if(isActive && isOver() && mouseClicked)
    {
      return true;
    }
    
    return false;
  }

  void render()
  {
    if (isActive && isEnable)
    {
      if(mouseClicked)
      {
        enterText = isClicked();
      }
            
      if (enterText && keyClicked)
      {
        switch(key)
        {
          case BACKSPACE:
          {
            if (text.length() > 0)
            {
              text = text.substring(0, text.length() - 1);
            }
          }
          break;
          
          case TAB:
          {
            if(example != null)
            {
              text += example;
              example = null;
            }
          }
          break;
          
          default:
          {
            if (checkSymbol((char) key) && (int) (textWidth(text + (char) key)) < w)
            {
              if(maxSymbols == 0)
              {
                text += (char) key;
              }
              else if(text.length() < maxSymbols)
              {
                text += (char) key;
              }
            }
            
            if(text.length() > 0)
            {              
              boolean match = true;
              String[] t = split(text, ' ');
              String testText = t[t.length - 1];
              
              example = null;
                                          
              for(int txt = 0; txt < library.size(); txt++)
              {
                match = true;
                for(int a = 0; a < testText.length(); a++)
                {
                  if(match && testText.charAt(a) != library.get(txt).charAt(a))
                  {
                    match = false;
                    break;
                  }
                }
                
                if(match)
                {
                  example = library.get(txt).substring(testText.length());
                }
              }
            }
          }
          break;
        }
      }
    }
      
    fill(border);
    rect(x + tx, y + ty, w, h);

    fill(normal);
    rect(x + tx + borderWidth, y + ty + borderWidth, w - borderWidth*2, h - borderWidth*2);

    textSize(14);
    if(text != "")
    {
      fill(textColor);
      text(text, x + borderWidth + tx + 5, y + ty + 20);
      
      if(example != null)
      {
        fill(189, 0, 0);
        text(example, x + borderWidth + tx + 5 + textWidth(text), y + ty + 20);
      }
    }
    else
    {
      fill(98, 98, 98);
      text(dText, x + borderWidth + tx + 5, y + ty + 20);
    }
    
    if(enterText)
    {
      fill(0, 0, 0);
      int lx = (int) (textWidth(text) + x + tx + borderWidth + 6); 
      rect(lx, y + ty + 2, 2, h - 4);
    }
  }
  
  void setTextColor(color c)
  {
    textColor = c;
  }
  
  boolean checkSymbol(char ch)
  {
    for(int a = 0; a < symbols.length(); a++)
    {
      if(ch == symbols.charAt(a))
      {
        if(filter != null)
        {
          for(int b = 0; b < filter.length(); b++)
          {
            if(ch == filter.charAt(b))
            {
              return true;
            }
          }
        }
        else
        {
          return true;
        }
      }
    }
    
    return false;
  }
}

//Text Area
class textArea extends component
{
  final String symbols = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM><.,0123456789*-+=!?& /[]{}()";
  ArrayList<String> texts = new ArrayList<String>();
  int curLine = 0;
  int vLines;
  int maxLines = -1;
  int pc = 20;
  boolean enterText = false;
  scrollBar scroll;
  
  textArea(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
    texts.add("");
    pc = texts.get(0).length();
    
    vLines = w/15;
    
    scroll = new scrollBar(x + w - 15, y , 15, h - 4);
    scroll.setScrollSize(0, 0);

    scroll.setColor(normal);
  }
  
  void setMaxLines(int m)
  {
    maxLines = m;
  }
  
  boolean isOver()
  {
    if(mouseX > tx + x && mouseX < tx + x + w && mouseY > ty + y && mouseY < ty + y + h)
    {
      return true;
    }
    
    return false;
  }
  
  boolean isClicked()
  {
    if(isActive && isOver() && mouseClicked)
    {
      return true;
    }
    
    return false;
  }
  
  void setText(String[] s)
  {
    texts.clear();
    for(String t : s)
    {
      texts.add(t);
    }
  }
  
  String[] getText()
  {
    String[] s = new String[texts.size()];
    for(int a = 0; a < texts.size(); a++)
    {
      s[a] = texts.get(a);
    }
    
    return s;
  }
  
  void render()
  {
    if(isActive)
    {
      if(mouseClicked)
      {
        println((mouseY - (y + ty))/20);
        
        enterText = isClicked();
      }
      
      if(keyClicked && enterText)
      {
        char ch = key;
        switch(ch)
        {
          case BACKSPACE:
          {
            if (texts.get(curLine).length() > 0)
            {
              texts.set(curLine, deleteFromText(texts.get(curLine), pc, true));
              pc--;
            }
            else
            {
              if(texts.get(curLine).length() <= 0 && curLine > 0)
              {
                curLine--;
              }
            }
          }
          break;
          
          case DELETE:
          {
            if (texts.get(curLine).length() > 0 && pc < texts.get(curLine).length() - 1)
            {
              texts.set(curLine, deleteFromText(texts.get(curLine), pc, false));
            }
          }
          break;
          
          case TAB:
          {
            //TABS
            for(int a = 0; a < 7; a++)
            {
              texts.set(curLine, writeToText(texts.get(curLine), pc, ' '));
              pc++;
            }
          }
          break;
          
          case ENTER:
          {            
            if(pc < texts.get(curLine).length())
            {
              curLine++;
              texts.add(curLine, texts.get(curLine - 1).substring(pc));
              texts.set(curLine - 1, texts.get(curLine - 1).substring(0, pc));
              pc = 0;
            }
            else
            {
              curLine++;
              texts.add(curLine, "");
              pc = texts.get(curLine).length();
            }
          }
          break;
          
          default:
          {
            switch(keyCode)
            {
              case UP:
              {
                if(curLine > 0)
                {
                  curLine--;
                  if(pc > texts.get(curLine).length())
                  {
                    pc = texts.get(curLine).length();
                  }
                }
              }
              break;
              
              case DOWN:
              {
                if(curLine < texts.size() - 1)
                {
                  curLine++;
                  if(pc > texts.get(curLine).length())
                  {
                    pc = texts.get(curLine).length();
                  }
                }
              }
              break;
              
              case LEFT:
              {
                if(pc > 0)
                {
                  pc--;
                }
              }
              break;
              
              case RIGHT:
              {
                if(pc < texts.get(curLine).length())
                {
                  pc++;
                }
              }
              break;
              
              case 35:
              {
                pc = texts.get(curLine).length();
              }
              break;
              
              case 36:
              {
                pc = 0;
              }
              break;
              
              default:
              {
                if (checkSymbol(ch) && textWidth(texts.get(curLine) + ch) < w)
                {
                  texts.set(curLine, writeToText(texts.get(curLine), pc, ch)); //texts.get(curLine) + ch)
                  pc++;
                }    
              }
              break;
            }
          }
          break;
        }
      }
      if(texts.size() > vLines)
      {
        int sc = min(scroll.h/2 - (int) (texts.size()*0.5), scroll.h/2);
        if(sc != scroll.sScale)
        {
          scroll.sy = scroll.h - scroll.sScale;
        }
        scroll.setScrollSize(vLines, texts.size());
      }
    } //<>//
        
    fill(border);
    rect(x + tx, y + ty, w, h);
    
    fill(normal);
    rect(x + tx + borderWidth, y + ty + borderWidth, w - borderWidth*2, h - borderWidth*2);
    
    if(texts.size() > vLines)
    {
      scroll.updateComponent(x + tx + w - scroll.w - 2, y + ty + 2);
      scroll.render();
    }
    fill(0, 0, 0);
    textSize(14);
    if (texts.size() > 0)
    {
      int start = texts.size() > vLines ? (int) (scroll.getPer()*(texts.size() - vLines)) : 0;
      int finish = texts.size() > vLines ? (start + vLines < texts.size() ? start + vLines : texts.size()) : texts.size();
      for (int a = start; a < finish; a++)
      {
        fill(0, 0, 0);
        if(a == curLine)
        {
          text(drawText(texts.get(a), pc), x + tx + borderWidth + 3, y + ty + borderWidth + 15*((a - start) + 1));
        }
        else
        {
          text(texts.get(a), x + tx + borderWidth + 3, y + ty + borderWidth + 15*((a - start) + 1));
        }
      }
      
      if(enterText)
      {
        fill(0, 0, 0);
        float ax = x + tx + borderWidth + 5 + pointerX(pc);
        rect(ax > 0 ? ax : 0, y + ty + 2 + 15* (curLine > vLines ? curLine - start : curLine), 2, 20);
      }
    }
  }
  
  String writeToText(String text, int num, char ch)
  {
    if(text.length() > num)
    {
      return text.substring(0, num) + ch + text.substring(num);
    }
    
    return text + ch;
  }
  
  String drawText(String text, int num)
  {
    if(text.length() > num && text.length() > 0)
    {
      return text.substring(0, num) + " " + text.substring(num);
    }
    
    return text;
  }
  
  String deleteFromText(String text, int num, boolean backspace)
  {
    if(text.length() > num)
    {
      if(num >= 0)
      {
        if(backspace)
        {
          if(num > 1)
          {
            return text.substring(0, num - 1) + text.substring(num);
          }
        }
        else
        {
          if(num >= text.length())
          {
            
          }
          return text.substring(0, num ) + text.substring(num + 1);
        }
      }
      else
      {
        return text;
      }
    }
    
    return text;
  }
  
  float pointerX(int num)
  {
    if(texts.get(curLine).length() > num)
    {
      if(num >= 0)
      {
        return textWidth(texts.get(curLine).substring(0, num));
      }
      else
      {
        return 0;
      }
    }
    
    return textWidth(texts.get(curLine));
  }
  
  boolean checkSymbol(char ch)
  {
    for(int a = 0; a < symbols.length(); a++)
    {
      if(ch == symbols.charAt(a))
      {
        return true;
      }
    }
    
    return false;
  }
}

//Layout //ACTIVE
class layout extends component
{
  ArrayList<component> components = new ArrayList<component>();
  boolean isActive = true;

  layout(int xLength, int yLength)
  {
    super(0, 0, xLength, yLength);
  }
  
  void setActive(boolean active) 
  {
    this.isActive = active;
  }
  
  layout get()
  {
    return new layout(w, h);
  }

  void addComponent(component c)
  {
    if (c != null)
    {
      this.components.add(c);
    }
  }

  void removeComponent(component c)
  {
    if (c != null)
    {
      this.components.remove(c);
    }
  }

  int size()
  {
    return components.size();
  }

  component get(int num)
  {
    return this.components.get(num);
  }

  void render()
  {
    for(component c : components)
    {
      c.setActive(isActive);
      c.translate(this.x + 1, this.y + 1);
      c.render();
    }
  }
}

//Slider
class slider extends component
{
  int sx = 0;
  int sy = 0;
  int newX;
  int newY;
  PImage img = null;
  final int sliderWidth = 5;
  boolean showPercentage = false;
  color slider = color(80, 80, 80);
  text showText;
  boolean vertical = false;

  slider(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
  }

  slider(int xPos, int yPos, int xLength, int yLength, PImage img)
  {
    super(xPos, yPos, xLength, yLength);
    this.img = img;
  }
  
  void setType(String t)
  {
    if(t.toLowerCase() == "vertical")
    {
      vertical = true;
    }
  }
  
  void setPercentage(float per)
  {
    if(vertical)
    {
      sy = (int) (per*(this.h - sliderWidth));
    }
    else
    {
      sx = (int) (per*(this.w - sliderWidth));
    }
  }
 
  void showPercentage(boolean show)
  {
    showPercentage = show;
    showText = new text(w);
  }

  float getPercentage()
  {
    if(vertical)
    {
      return (float) (sy / (float) (this.h - sliderWidth));
    }
    else
    {
      return (float) (sx / (float) (this.w - sliderWidth));
    }
  }

  void setImage(PImage img)
  {
    this.img =  img;
  }
  
  boolean isOver()
  {
    if(mouseX > tx + x && mouseX < tx + x + w && mouseY > ty + y && mouseY < ty + y + h)
    {
      return true;
    }
    
    return false;
  }
  
  boolean isClicked()
  {
    if(isActive && isOver() && mouseClicked)
    {
      return true;
    }
    
    return false;
  }

  void render()
  { 
    if(isActive)
    {
      if(!vertical)
      {
        newX = (mouseX - (x + tx + sliderWidth/2));
    
        if (mousePressed && isOver())
        {
          if (newX > w - sliderWidth)
          {
            sx = w - sliderWidth;
          } 
          else if (newX < 0)
          {
            sx = 0;
          } 
          else
          {
            sx = newX;
          }
        }
      }
      else
      {
        newY = (mouseY - (y + ty + sliderWidth/2));
        
        if (mousePressed && isOver())
        {
          if (newY > h - sliderWidth - 2)
          {
            sy = h - sliderWidth;
          } 
          else if (newY < 0)
          {
            sy = 0;
          } 
          else
          {
            sy = newY;
          }
        }
      }
    }

    //border
    fill(border);
    if(!vertical)
    {
      rect(x + tx, y + ty + 2, w, h - 4);
    }
    else
    {
      rect(x + tx + 2, y + ty, w - 4, h);
    }

    //base
    if (img == null)
    {
      fill(normal);
      if(!vertical)
      {
        rect(x + borderWidth + tx, y + borderWidth + ty + 2, w - borderWidth*2, h - borderWidth*2 - 4);
      }
      else
      {
        rect(x + borderWidth + tx + 2, y + borderWidth + ty, w - borderWidth*2 - 4, h - borderWidth*2);
      }
    }
    else
    {
      if(!vertical)
      {
        image(img, x + borderWidth + tx, y + borderWidth + ty + 2, w - borderWidth*2, h - borderWidth*2 - 4);
      }
      else
      {
        image(img, x + borderWidth + tx + 2, y + borderWidth + ty, w - borderWidth*2 - 4, h - borderWidth*2);
      }
    }
    
    //text
    if(showPercentage)
    {
      String per = showText.toString((int) (getPercentage()*100) + " %");
      textSize(12);
      fill(0, 0, 0);
      text(per, tx + x + w/2 - textWidth(per)/2, ty + y + h*0.62);
    }
    fill(slider);
    if(!vertical)
    {
      //slider
      rect(x + sx + tx, y + ty, sliderWidth, h);
    }
    else
    {
      //slider
      rect(x + tx, y + ty + sy, w, sliderWidth);
    }
  }
}

//Item List
class itemList extends component
{
  ArrayList<String> itemTitle = new ArrayList<String>();
  int selected = -1;
  scrollBar scroll;
  int vLines;
  boolean visible = true;
  button[] buttons;

  itemList(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
    vLines = h/40;
    buttons = new button[vLines];
    
    for(int a = 0; a < vLines; a++)
    {
      buttons[a] = new button(0,  ty + 40*a, w - 20, 39, "");
    }
    
    scroll = new scrollBar(w - 15, 4, 15, (40*vLines) - 8);
    scroll.setScrollSize(0, 0);

    scroll.setColor(normal);
  }

  void addItem(String itemTitle)
  {
    this.itemTitle.add(itemTitle);
  }
  
  void clear()
  {
    itemTitle.clear();
  }
  
  void setItems(String[] s)
  {
    itemTitle.clear();
    for(String t : s)
    {
      itemTitle.add(t);
    }
  }
  
  void setItemVisible(boolean v)
  {
    visible = v;
  }

  void removeItem(String itemTitle)
  {
    this.itemTitle.remove(itemTitle);
  }

  String getSelected()
  {
    if (selected >= 0 && selected < itemTitle.size())
    {
      return itemTitle.get(selected);
    }

    return null;
  }

  int getSelectedNum()
  {
    if (selected >= 0)
    {
      return selected;
    }
    return -1;
  }

  void render()
  {
    if (itemTitle.size() > vLines)
    {
      scroll.translate(x + tx, y + ty);
      scroll.render();
      
      scroll.setScrollSize(vLines, itemTitle.size());
    }
    
    int start;
    int finish;
    
    if (itemTitle.size() > 0)
    {
      start = itemTitle.size() > vLines ? (int) (scroll.getPer()*(itemTitle.size() - vLines)) : 0;
      finish = itemTitle.size() > vLines ? (start + vLines < itemTitle.size() ? start + vLines : itemTitle.size()) : vLines;
    }
    else
    {
      start = 0;
      finish = vLines;
    }
    
    for(int a = 0; a < vLines; a++)
    {
      buttons[a].setEnable(!(a == selected));
      buttons[a].translate(x + tx, y + ty);
    }
    
    for (int a = start; a < finish; a++)
    {
      buttons[a - start].setText(itemTitle.size() > a ? itemTitle.get(a) : "");
    }
    
    for(int a = 0; a < vLines; a++)
    {
      buttons[a].render();
      if(buttons[a].isClicked())
      {
        selected = a;
      }
    }
  }
}

//Image
class image extends component
{
  PImage img = null;
  boolean isActive = true;
  image(int xPos, int yPos, int xLength, int yLength, PImage img)
  {
    super(xPos, yPos, xLength, yLength);
    this.img = img;
  }

  image(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
    this.img = null;
  }
  
  void setActive(boolean active)
  {
    isActive = active;
  }
  
  PImage createImage(int w, int h, color c)
  {
    PGraphics image = createGraphics(w, h);
    image.beginDraw();
    image.noStroke();
    image.fill(c);
    image.rect(0, 0, w, h);
    image.endDraw();
    
    PImage a = image;
    
    return a;
  }
  
  boolean isOver()
  {
    if(mouseX > tx + x && mouseX < tx + x + w && mouseY > ty + y && mouseY < ty + y + h)
    {
      return true;
    }
    
    return false;
  }

  void setImage(PImage img)
  {
    this.img = img;
  }
  void render()
  {    
    if(img != null)
    {
      image(img, x + tx, y + ty, w, h);
    }
  }
}

//Check Box
class checkBox extends component
{
  String text = null;
  boolean clicked = false;
  boolean update = false;
  text showText;
  boolean isActive = true;
  
  checkBox(int xPos, int yPos, int xLength, int yLength, String text)
  {
    super(xPos, yPos, xLength, yLength);
    this.text = text;
    showText = new text(w - h - 5);
  }
  
  void setActive(boolean active)
  {
    isActive = active;
  }
  
  boolean isOver()
  {
    if(mouseX > tx + x && mouseX < tx + x + w && mouseY > ty + y && mouseY < ty + y + h)
    {
      return true;
    }
    
    return false;
  }
  
  boolean isClicked()
  {
    if(isActive && isOver() && mouseClicked)
    {
      return true;
    }
    
    return false;
  }
  
  void render()
  {
    fill(border);
    rect(x + 3 + tx, y + ty + 3, h - 6, h - 6);
    
    fill(normal);
    rect(x + tx + borderWidth + 3, y + ty + borderWidth + 3, h - borderWidth*2 - 6, h - borderWidth*2 - 6);
    
    fill(0);
    textSize(15);
    text(showText.toString(text), tx + x + h + 5, ty + y + h*0.62);
    
    if(isActive && isOver() && mouseClicked)
    {
      clicked = !clicked;
      update = true;
    }
    
    if(clicked)
    {
      fill(click);
      rect(x + tx + borderWidth + 7, y + ty + borderWidth + 7, h - borderWidth*2 - 14, h - borderWidth*2 - 14);
    }
    else
    {
      fill(click);
      rect(x + tx + borderWidth + 6, y + ty + borderWidth + 6, h - borderWidth*2 - 12, h - borderWidth*2 - 12);
      
      if(isOver())
      {
        fill(over);
      }
      else
      {
        fill(normal);
      }
      rect(x + tx + borderWidth + 7, y + ty + borderWidth + 7, h - borderWidth*2 - 14, h - borderWidth*2 - 14);
    }
  }
}

//Scroll Bar
class scrollBar extends component
{
  boolean isActive = true;
  int sy = 0;
  int newY;
  int sScale = 0;
  color c = normal;
  scrollBar(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
  }
  
  void setActive(boolean active)
  {
    isActive = active;
  }
  
  void setColor(color c)
  {
    this.c = c;
  }
  
  void setScrollSize(int cItems, int mItems)
  {
    sScale = max((int) ((float) cItems / (float) mItems * (float) h), 20);
  }
  
  float getPer()
  {
    return (float) (sy / (float) (h - sScale));
  }
  
  boolean isOver()
  {
    if(mouseX > tx + x && mouseX < tx + x + w && mouseY > ty + y && mouseY < ty + y + h)
    {
      return true;
    }
    
    return false;
  }
  
  boolean isClicked()
  {
    if(isActive && isOver() && mouseClicked)
    {
      return true;
    }
    
    return false;
  }
  
  void render()
  {
    if(isActive)
    {
      newY = mouseY - (y + ty + sScale/2);
 
      if(isOver())
      {
        if(mousePressed)
        {
          if(newY > h - sScale)
          {
            sy = h - sScale;
          }
          else if(newY < 0)
          {
            sy = 0;
          }
          else
          {
            sy = newY;
          }
        }
      }
      
      if(scroll != 0)
      {
        if(scroll*20 + sy > h - sScale)
        {
          sy = h - sScale;
        }
        else if(scroll*20 + sy < 0)
        {
          sy = 0;
        }
        else
        {
          sy += scroll*20;
        }
      }
      
      if(sy + sScale > h)
      {
        sy = h - sScale;
      }
      
      if(sScale < w)
      {
        sScale = w;
      }
    }
      
    fill(c, 230);
    rect(x + tx, y + ty, w, h);
    
    if(isOver() && isActive)
    {
      fill(click, 240);
    }
    else
    {
      fill(over, 240);
    }
    rect(x + tx + 1, y + ty + sy, w - 2, sScale);
  }
}

//Text
class text
{
  double w;
  text(double w) {this.w = w;}
  
  String toString(String text)
  {
    //println(text);
    if(text != null && textWidth(text) > w)
    {
      String r = "";
      for(int a = 0; a < text.length(); a++)
      {
        r += text.charAt(a);
        if(textWidth(r + "...") >= w - 7)
        {
          break;
        }
      }
      return r + "...";
    }
    
    return text;
  }
}