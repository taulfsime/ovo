
/***************************
 - Component
 - Collision Box
 - Button
 - Label
 - Switch Button
 - Text
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
class collisionBox extends component
{
  boolean isActive = true;
  
  collisionBox(int x, int y, int w, int h) 
  {
    super(x, y, w, h);
  }
  
  void setActive(boolean active) 
  {
    this.isActive = active;
  }

  public boolean isOver()
  {
    if (isActive)
    {
      return (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h);
    }
    return false;
  }
}

//Button
class button extends component
{
  collisionBox cb;
  String text = null;
  PImage img = null;
  PImage img1 = null, img2 = null;
  boolean isClicked = false;
  boolean isOver = false;
  char bindKey;
  boolean useBindKey = false;
  text showText;
  boolean isActive = true;
  boolean isWorking = true;

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
  
  void setWorking(boolean work)
  {
    isWorking = work;
  }
  
  void setActive(boolean active)
  {
    isActive = active;
  }
  
  void bindKey(char bKey)
  {
    bindKey = bKey;
    useBindKey = true;
  }

  void render()
  {
    cb = new collisionBox(x + tx, y + ty, w, h);
    cb.setActive(isActive && isWorking);

    if (img1 == null && img2 == null)
    {
      noStroke();
      fill(border);
      rect(x + tx, y + ty, w, h);
    }
    
    if(isActive && isWorking)
    {
      if (cb.isOver() || (keyClicked && key == bindKey && useBindKey))
      {
        if (mouseClicked || (keyClicked && key == bindKey && useBindKey))
        {
          noStroke();
          fill(click); //clicked
          this.isClicked = true;
        } 
        else
        {
          noStroke();
          fill(over); //over
          this.isClicked = false;
          this.isOver = true;
        }
      } 
      else
      {
        noStroke();
        fill(normal); //normal
        this.isOver = false;
        this.isClicked = false;
      }
    }
    else
    {
      noStroke();
      fill(over);
    }

    if (img1 == null && img2 == null)
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
    else if (this.text == null && this.img != null && this.img1 != null && this.img2 != null)        //image x3
    {
      if (this.isClicked)
      {
        image(img2, x + tx, y + ty, w, h);  //clicked
      } 
      else if (this.isOver)
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
  collisionBox cb;

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

  void render()
  {
    cb = new collisionBox(x, y, w, h);
    if (text == null && img != null)
    {
      noStroke();
      fill(border);
      rect(x, y, w, h);
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
  boolean isOver = false;
  PImage imgOff = null;
  PImage imgOn = null;
  String text = null;
  collisionBox cb;
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
    cb = new collisionBox(x + tx, y + ty, w, h);
    cb.setActive(isActive);

    if (isActive)
    {
      if (cb.isOver())
      {
        if (mouseClicked)
        {
          isClicked = !isClicked;
        }
        isOver = true;
      } 
      else
      {
        isOver = false;
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
        if (isOver)
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
  collisionBox cb;

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
    cb = new collisionBox(x, y, w, h);
    
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
  String text = "";
  String dText = "";
  collisionBox cb;
  boolean enterText = false;
  final String symbols = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM><.,0123456789*-+=!?& ";
  String filter = null;
  ArrayList<String> library = new ArrayList<String>();
  String example = null;
  boolean isActive = true;
  boolean isWorking = true;
    
  textField(int xPos, int yPos, int xLength, int yLength, String displayText)
  {
    super(xPos, yPos, xLength, yLength);
    this.dText = displayText;
  }
  
  void setActive(boolean active) 
  {
    this.isActive = active;
  }
  
  void setWorking(boolean work)
  {
    isWorking = work;
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

  void render()
  {
    cb = new collisionBox(x + tx, y + ty, w, h);
    cb.setActive(isActive);
    if (isActive && isWorking)
    {
      if (mouseClicked)
      {
        enterText = cb.isOver();
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
              text += (char) key;
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
      fill(0, 0, 0);
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
  final String symbols = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM><.,0123456789*-+=!?& ";
  int maxLines;
  String[] text;
  int curLine = 0;
  float textPointerX = 0;
  boolean enterText = false;
  collisionBox cb;
  boolean isActive = true;
  
  textArea(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
    maxLines = h / 22;
    text = new String[maxLines];
    
    for(int a = 0; a < maxLines; a++)
    {
      text[a] = "";
    }
  }
  
  void setActive(boolean active) 
  {
    this.isActive = active;
  }
  
  void render()
  {
    cb = new collisionBox(x + tx, y + ty, w, h);
    cb.setActive(isActive);
    
    if(isActive)
    {
      if (mouseClicked)
      {
        enterText = cb.isOver();
      }
      
      if(keyClicked && enterText)
      {
        switch(key)
        {
          case BACKSPACE:
          {
            if (text[curLine].length() > 0)
            {
              text[curLine] = text[curLine].substring(0, text[curLine].length() - 1);
            }
          }
          break;
          
          case ENTER:
          {
            //if(curLine < maxLines - 1)
            //{
            //  curLine++;
            //  textPointerX = (int) textWidth(text[curLine]);
            //}
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
                  if(textPointerX > textWidth(text[curLine]))
                  {
                    textPointerX = textWidth(text[curLine]);
                  }
                }
              }
              break;
              
              case DOWN:
              {
                if(curLine < maxLines - 1)
                {
                  curLine++;
                  if(textPointerX > textWidth(text[curLine]))
                  {
                    textPointerX = textWidth(text[curLine]);  
                  }
                }
              }
              break;
              
              case LEFT:
              {
                //String t = text[curLine];
                
              }
              break;
              
              case RIGHT:
              {
                
              }
              break;
              
              default:
              {
                if (checkSymbol((char) key) && textWidth(text[curLine] + (char) key) < w)
                {
                  text[curLine] += (char) key;
                }    
              }
              break;
            }
          }
          break;
        }
      }
    }
      
    textPointerX = textWidth(text[curLine]); //<>//
    
    //println(textPointerX, textWidth(text[curLine]));
    
    fill(border);
    rect(x + tx, y + ty, w, h);
    
    fill(normal);
    rect(x + tx + borderWidth, y + ty + borderWidth, w - borderWidth*2, h - borderWidth*2);
    
    textSize(14);
    fill(0, 0, 0);
    for(int a = 0; a < text.length; a++)
    {
      text(text[a], x + borderWidth + tx + 5, y + ty + 20 + 22*a);
    }
    
    if(enterText)
    {
      fill(0, 0, 0);
      rect((float) (x + tx + borderWidth + 5 + textPointerX), y + ty + 2 + 22*curLine, 2, 20);
    }
    
    //println(textWidth(text[curLine]), textPointerX);
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
      c.translate(this.x, this.y);
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
  collisionBox cb;
  final int sliderWidth = 5;
  boolean showPercentage = false;
  color slider = color(80, 80, 80);
  text showText;
  boolean isActive = true;
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
  
  void setActive(boolean active)
  {
    isActive = active;
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

  void render()
  {
    cb = new collisionBox(x + tx + borderWidth, y + ty, w - borderWidth*2, h);
    cb.setActive(isActive);
    
    if(isActive)
    {
      if(!vertical)
      {
        newX = (mouseX - (x + tx + sliderWidth/2));
    
        if (mousePressed && cb.isOver())
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
        
        if (mousePressed && cb.isOver())
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
  boolean isOpen = false;
  boolean isActive = true;

  itemList(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
  }
  
  void setActive(boolean active)
  {
    isActive = active;
  }

  void addItem(String itemTitle)
  {
    this.itemTitle.add(itemTitle);
  }
  
  void setOpen(boolean open)
  {
    this.isOpen = open;
  }

  void removeItem(String itemTitle)
  {
    for (int a = 0; a < this.itemTitle.size(); a++)
    {
      if (this.itemTitle.get(a).toLowerCase() == itemTitle.toLowerCase())
      {
        this.itemTitle.remove(this.itemTitle.get(a));
      }
    }
  }

  String getSelected()
  {
    if (selected >= 0)
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
    if (isOpen && isActive)
    {
      for(int a = 0; a < this.itemTitle.size(); a++)
      {
        button b = new button(x + tx, y + ty + a*(h/8) + 20, w, h/8, itemTitle.get(a));
        b.render();
      }
    }
  }
}

//Image
class image extends component
{
  PImage img = null;
  boolean isActive = true;
  collisionBox cb;
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

  void setImage(PImage img)
  {
    this.img = img;
  }
  void render()
  {
    cb = new collisionBox(x, y, w, h);
    
    if(img != null)
    {
      image(img, x + tx, y + ty, w, h);
    }
  }
}

//Check Box
class checkBox extends component
{
  collisionBox cb;
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
  
  void render()
  {
    cb = new collisionBox(x + tx + 3, y + ty + 3, h - 6, h - 6);
    cb.setActive(isActive);
    
    fill(border);
    rect(x + 3 + tx, y + ty + 3, h - 6, h - 6);
    
    fill(normal);
    rect(x + tx + borderWidth + 3, y + ty + borderWidth + 3, h - borderWidth*2 - 6, h - borderWidth*2 - 6);
    
    fill(0);
    textSize(15);
    text(showText.toString(text), tx + x + h + 5, ty + y + h*0.62);
    
    if(isActive && cb.isOver() && mouseClicked)
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
      
      if(cb.isOver())
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
  collisionBox cb;
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
  
  void setScrollSize(int w)
  {
    sScale = w;
  }
  
  float getPer()
  {
    return (float) (sy / (float) (h - sScale));
  }
  
  void render()
  {
    if(isActive)
    {
      cb = new collisionBox(x + tx, y + ty, w, h);
      newY = mouseY - (y + ty + sScale/2);
      
      if(mousePressed && cb.isOver())
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
      
      if(sy + sScale > h)
      {
        sy = h - sScale;
      }
      
      if(sScale < w)
      {
        sScale = w;
      }
      
      fill(c, 230);
      rect(x + tx, y + ty, w, h);
      
      if(cb.isOver())
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