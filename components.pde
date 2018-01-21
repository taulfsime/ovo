/***************************
 - Component
 - Collision Box
 - Button
 - Label
 - Switch Button
 - Text
 - Progress Bar
 - Text Area
 - Layout
 - Slider
 - Item List
 - Image
 - CheckBox
 - Radio Group
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
  public boolean isVisible = true;

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
  void setActive(boolean active) {this.isActive = active;}
}

//Collision Box
class collisionBox extends component
{
  collisionBox(int x, int y, int w, int h) 
  {
    super(x, y, w, h);
  }

  public boolean isOver()
  {
    if (this.isActive)
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

  void render()
  {
    cb = new collisionBox(x + tx, y + ty, w, h);

    if (img1 == null && img2 == null)
    {
      noStroke();
      fill(border);
      rect(x + tx, y + ty, w, h);
    }
    if (this.isActive && cb.isOver())
    {
      if (mouseClicked)
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
    if (!this.isActive)
    {
      noStroke();
      fill(normal);
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

  void setTextScale(int scale)
  {
    this.textScale = scale;
  }

  void render()
  {
    if (isActive)
    {
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

//Switch Button //WORK 20.01.18
class switchButton extends component
{
  boolean isClicked = false;
  boolean isOver = false;
  PImage imgOff = null;
  PImage imgOn = null;
  String text = null;
  collisionBox cb;
  text showText;

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

      if (text != null && imgOn == null)
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

  progressBar(int xPos, int yPos, int xLength, int yLength) 
  {
    super(xPos, yPos, xLength, yLength);
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

//Text area //WORK 10.12.17
class textArea extends component
{
  String text = "";
  collisionBox cb;
  int maxSym = -1;
  boolean enterText = false;

  textArea(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
  }

  void setMax(int max)
  {
    this.maxSym = max;
  }

  void render()
  {
    if (this.isActive)
    {
      cb = new collisionBox(x + tx, y + ty, w, h);
      if (mouseClicked)
      {
        if (cb.isOver())
        {
          enterText = true;
        } else
        {
          enterText = false;
        }
      }

      if (enterText && keyPressed)
      {
        //line(textWidth(text) + x + tx, y + ty, textWidth(text) + x + tx, y + ty + 20);
        if (keyCode == BACKSPACE) 
        {
          if (text.length() > 0)
          {
            text = text.substring(0, text.length() - 1);
          }
        } 
        else if (keyCode >= 32 && keyCode <= 126) //keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT
        {
          text += key;
        }
      }
      fill(border);
      rect(x + tx, y + ty, w, h);

      fill(normal);
      rect(x + tx + borderWidth, y + ty + borderWidth, w - borderWidth*2, h - borderWidth*2);

      fill(0);
      text(text, x + borderWidth + tx + 5, y + ty + 20);
    }
  }
}

//Layout
class layout extends component
{
  ArrayList<component> components = new ArrayList<component>();

  layout(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
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
    if (this.isActive)
    {
      for (component comp : components) 
      {
        comp.translate(this.x, this.y);
        comp.render();
      }
    } 
    else
    {
    }
  }
}

//Slider
class slider extends component
{
  int sx = 0;
  int newX;
  PImage img = null;
  collisionBox cb;
  final int sliderWidth = 5;
  boolean showPercentage = false;
  color slider = color(80, 80, 80);
  text showText;

  slider(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
  }

  slider(int xPos, int yPos, int xLength, int yLength, PImage img)
  {
    super(xPos, yPos, xLength, yLength);
    this.img = img;
  }
 
  void showPercentage(boolean show)
  {
    showPercentage = show;
    showText = new text(w);
  }

  float getPercentage()
  {
    return (float) (sx / (float) (this.w - sliderWidth));
  }

  void setImage(PImage img)
  {
    this.img =  img;
  }

  void render()
  {
    cb = new collisionBox(x + tx + borderWidth, y + ty, w - borderWidth*2, h);
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

    //border
    fill(border);
    rect(x + tx, y + ty + 2, w, h - 4);

    //base
    if (img == null)
    {
      fill(normal);
      rect(x + borderWidth + tx, y + borderWidth + 2 + ty, w - borderWidth*2, h - borderWidth*2 - 4);
    }
    else
    {
      image(img, x + borderWidth + tx, y + borderWidth + 2 + ty, w - borderWidth*2, h - borderWidth*2 - 4);
    }
    
    //text
    if(showPercentage)
    {
      String per = showText.toString((int) (getPercentage()*100) + " %");
      textSize(12);
      fill(0, 0, 0);
      text(per, tx + x + w/2 - textWidth(per)/2, ty + y + h*0.62);
    }

    //slider
    fill(slider);
    rect(x + sx + tx, y + ty, sliderWidth, h);
  }
}

//Item List
class itemList extends component
{
  ArrayList<button> item = new ArrayList<button>();
  switchButton show;
  label title;
  int selected = -1;

  itemList(int xPos, int yPos, int xLength, int yLength, String title)
  {
    super(xPos, yPos, xLength, yLength);
    show = new switchButton((x + tx) + w - h, y + ty, h, h, loadImage("textures/arrowDown.png"));
    this.title = new label(x + tx, y + ty, w - h, h, title);
  }

  void addItem(String itemTitle)
  {
    this.item.add(new button(x + tx, y + ty + (h + 1) * max(this.item.size() + 1, 1), w, h, itemTitle));
  }

  void removeItem(String itemTitle)
  {
    for (int a = 0; a < item.size(); a++)
    {
      if (item.get(a).getText().toLowerCase() == itemTitle.toLowerCase())
      {
        item.remove(item.get(a));
      }
    }
  }

  String getSelected()
  {
    if (selected >= 0)
    {
      return item.get(selected).getText();
    }

    return title.getText();
  }

  int getSelectedNum()
  {
    if (selected >= 0)
    {
      return selected;
    }
    return 0;
  }

  void render()
  {

    show.translate(tx, ty);
    title.translate(tx, ty);

    title.setText(getSelected());

    show.render();
    title.render();

    if (show.isClicked)
    {
      for (int a = 0; a < item.size(); a++)
      {
        item.get(a).translate(tx, ty);
        item.get(a).render();

        if (item.get(a).isClicked)
        {
          selected = a;
          show.setClicked(false);
        }
      }
    }
    collisionBox cb = new collisionBox(x + tx, y + ty, w, h + h*item.size());
    if (mouseClicked && !cb.isOver())
    {
      show.setClicked(false);
    }
  }
}

//Image
class image extends component
{
  PImage img = null;
  image(int xPos, int yPos, int xLength, int yLength, PImage img)
  {
    super(xPos, yPos, xLength, yLength);
    this.img = img;
  }

  image(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
  }

  void setImage(PImage img)
  {
    this.img = img;
  }

  void render()
  {
    image(img, x + tx, y + ty, w, h);
  }
}

class checkBox extends component
{
  collisionBox cb;
  String text = null;
  boolean clicked = false;
  boolean update = false;
  text showText;
  checkBox(int xPos, int yPos, int xLength, int yLength, String text)
  {
    super(xPos, yPos, xLength, yLength);
    this.text = text;
    showText = new text(w - h - 5);
  }
  
  void render()
  {
    cb = new collisionBox(x + tx + 3, y + ty + 3, h - 6, h - 6);
    
    fill(border);
    rect(x + 3 + tx, y + ty + 3, h - 6, h - 6);
    
    fill(normal);
    rect(x + tx + borderWidth + 3, y + ty + borderWidth + 3, h - borderWidth*2 - 6, h - borderWidth*2 - 6);
    
    fill(0);
    text(showText.toString(text), tx + x + h + 5, ty + y + h*0.62);
    
    if(cb.isOver() && mouseClicked)
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

//Radio Group
class radioGroup extends component
{
  ArrayList<checkBox> checkBoxes = new ArrayList<checkBox>();
  checkBox cb;
  radioGroup()
  {
    super(0, 0, 0, 0);
  }
  
  void addItem(checkBox c)
  {
    checkBoxes.add(c);
    if(checkBoxes.size() == 1)
    {
      checkBoxes.get(0).clicked = true;
      checkBoxes.get(0).update = true;
    }
  }
  
  void show()
  {
    int x = width;
    int y = height;
    int y1 = 0;
    int w = 0;
    int tx = width;
    int ty = height;
        
    for(checkBox c : checkBoxes)
    {
      x = min(c.x, x);
      y = min(c.y, y);
      y1 = max(c.y + c.h, y1);
      w = max(c.w, w);
      tx = min(c.tx, tx);
      ty = min(c.ty, ty);
    }
    
    fill(0, 255, 0);
    rect(x + tx, y + ty, w, y1 - y);
   }
  
  void render()
  {
    for(checkBox c : checkBoxes)
    {
      if(c.update)
      {
        if(c == cb)
        {
          c.clicked = true;
        }
        cb = c;
        c.update = false;
      }
    }
    
    for(checkBox c : checkBoxes)
    {
      if(c != cb)
      {
        c.clicked = false;
      }
    }
  }
}

//Text
class text
{
  int w;
  text(int w) {this.w = w;}
  
  String toString(String text)
  {
    if(textWidth(text) > w)
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