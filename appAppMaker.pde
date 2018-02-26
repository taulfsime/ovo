class appMaker extends application
{
  int ww = 600;
  int wh = 680;
  
  ArrayList<component> components = new ArrayList<component>();
  ArrayList<String> save = new ArrayList<String>();
  int editComponent = -1;
  
  /* CREATING */
  layout main;
  appElement ae;
  button drawLabel;
  button drawButton;
  button export;
  textField[] coord = new textField[4];
  textField text;
  
  /* CREATE */
  layout createLayout;
  textField enterName;
  textField enterWidth;
  textField enterHeight;
  button createButton;
  button loadButton;
  button edit;
  
  /* EDITOR */
  layout editor;
  textArea codeArea;
  label showCurComponent;
  itemList show;
  button back;
  void init()
  {
    initCreating();
    
    /* CREATE */
    createLayout = new layout(250, 130);
    enterName = new textField(10, 10, 230, 30, "Name");
    enterWidth = new textField(10, 50, 110, 30, "Width");
    enterHeight = new textField(130, 50, 110, 30, "Height");
    createButton = new button(10, 90, 110, 30, "Create");
    loadButton = new button(130, 90, 110, 30, "Load");
    
    enterWidth.setFilter("0123456789");
    enterHeight.setFilter("0123456789");
    
    createLayout.addComponent(enterName);
    createLayout.addComponent(enterWidth);
    createLayout.addComponent(enterHeight);
    createLayout.addComponent(createButton);
    createLayout.addComponent(loadButton);
    
    setLayout(createLayout);
  }
  
  void update()
  {
    if(getLayout() == main)
    {
      creating();
    }
    else if(getLayout() == createLayout)
    {
      create();
    }
    else if(getLayout() == editor)
    {
      editor();
    }
  }
  
  void editor()
  {
    if(back.isClicked)
    {
      setLayout(main);
    }
    
    for(String s : save)
    {
      String[] t = split(s, ' ');
      if(checkStrings(t[0], "function") && show.getSelected() != null)
      {
        if(checkStrings(t[1], show.getSelected()))
        {
          //showCurComponent.setText(t[1]);
          //codeArea.text[0] = "function " + "f_" + t[1] + "()";
          //codeArea.text[1] = t[2].charAt(0) + "";
        }
        
      }
    }
  }
  
  void create()
  {
    int ww = 600;
    int wh = 680;
    createButton.setEnable(enterName.getText() != "");
    loadButton.setEnable(enterName.getText() != "" && enterWidth.getText() == "" && enterHeight.getText() == "");
    
    if(createButton.isClicked)
    {
      if(enterWidth.getText() != "")
      {   
        int w1 = Integer.parseInt(enterWidth.getText());
      
        if(w1 > 200 && w1 < width - 300)
        {
          ww = w1;
        }
      }
      
      if(enterHeight.getText() != "")
      {
        int h1 = Integer.parseInt(enterHeight.getText());
        if(h1 > 100 && h1 < height - 300)
        {
          wh = h1;
        }
      }
      
      this.ww = ww;
      this.wh = wh;
      initCreating();
      
      setLayout(main);
    }
  }
  
  void creating()
  {
    buttonClick();
    
    if(components.size() > 0)
    {
      for(int a = components.size() - 1; a >= 0 ; a--)
      {
        component comp = components.get(a);
        collisionBox cba = new collisionBox(x + comp.x, y + comp.y, comp.w, comp.h);
        collisionBox cb = new collisionBox(x + ae.x, y + ae.y, ae.w, ae.h);
        
        if(mouseClicked && cb.isOver())
        {
          if(cba.isOver())
          {
            editComponent = a;
            
            coord[0].setText(components.get(editComponent).x + "");
            coord[1].setText(components.get(editComponent).y + "");
            coord[2].setText(components.get(editComponent).w + "");
            coord[3].setText(components.get(editComponent).h + "");
            
            break;
          }
          else
          {
            editComponent = -1;
          }
        }
      }
    }
    
    if(editComponent >= 0)
    {
      /* COMPONENT X */
      if(coord[0].getText().length() > 0)
      {
        int n = Integer.parseInt(coord[0].getText());
        if(n < ae.x)
        {
          components.get(editComponent).x = ae.x;
        }
        else if(n > ae.x + ae.w)
        {
          components.get(editComponent).x = (ae.x + ae.w) - components.get(editComponent).w;
        }
        else
        {
          components.get(editComponent).x = n;
        }
      }
      else
      {
        components.get(editComponent).x = ae.x;
      }
      
      /* COMPONENT Y */
      if(coord[1].getText().length() > 0)
      {
        int n = Integer.parseInt(coord[1].getText());
        if(n < ae.y)
        {
          components.get(editComponent).y = ae.y;
        }
        else if(n > ae.y + ae.h)
        {
          components.get(editComponent).y = (ae.y + ae.h) - components.get(editComponent).h;
        }
        else
        {
          components.get(editComponent).y = n;
        }
      }
      else
      {
        components.get(editComponent).y = ae.y;
      }
      
      /* COMPONENT WIDTH */
      if(coord[2].getText().length() > 0)
      {
        int n = Integer.parseInt(coord[2].getText());
        
        if(n > 0 && n < ae.w - components.get(editComponent).x)
        {
          components.get(editComponent).w = n;
        }        
      }
      
      /* COMPONENT HEIGHT */
      if(coord[3].getText().length() > 0)
      {
        int n = Integer.parseInt(coord[3].getText());
        
        if(n > 0 && n < ae.h - components.get(editComponent).y)
        {
          components.get(editComponent).h = n;
        }        
      }
      
      /* COMPONENT TEXT */
      if(text.getText().length() > 0)
      {
        //components.get(editComponent).text = text.getText();
      }
      
      String fType = "";
      String test = components.get(editComponent).getClass().toString();
      
      for(int q = 0; q < test.length(); q++)
      {
        if(test.charAt(q) == '$')
        {
          fType = test.substring(q + 1);
          break;
        }
      }
      
      component c = components.get(editComponent);
      switch(fType)
      {
        case "button":
        {
          /* ERROR */
          //text.setWorking(true);
          if(text.getText().length() > 0)
          {
            button bTest = new button(c.x, c.y, c.w, c.h, text.getText());
            components.set(editComponent, bTest);
          }
        }
        break;
        
        case "label":
        {
          
        }
        break;
      }
    }
    else
    {
      /* EMPTY TEXT FIELDS */
      
      for(int a = 0; a < coord.length; a++)
      {
        coord[a].setText("");
      }
      text.setText("");
      //text.setWorking(false);
    }
    
    if(ae.isReady)
    {
      component c = ae.getComponent();
      main.addComponent(c);
      components.add(c);
      String name = ae.getType() + save.size()/2;
      save.add("init " + ae.getType() + " " + name + " (" + c.x + "$" + c.y + "$" + c.w + "$" + c.h + ")");
      save.add("function " + name + " {}");
      ae.reset();
    }
  }
  
  void export()
  {
    ArrayList<String> init = new ArrayList<String>();
    ArrayList<String> initF = new ArrayList<String>();
    
    for(String s : save)
    {
      String[] c = split(s, ' ');
      
      String arg = "";
      for(int a = 0; a < c[3].length(); a++)
      {
        if(c[3].charAt(a) != '$')
        {
          arg += c[3].charAt(a);
        }
        else
        {
          arg += ", ";
        }
      }
      
      switch(c[0])
      {
        case "init":
        {
          init.add((c[1] + " " + c[2]));
          
          initF.add(c[2] + " = new " + c[1] + arg);
          
        }
        break;
      }
    }
    
    printArray(init);
    printArray(initF);
  }
  
  void load()
  {
    
  }
  
  void buttonClick()
  {
    if(drawLabel.isClicked)
    {
      ae.setComponent("label");
    }
    else if(drawButton.isClicked)
    {
      ae.setComponent("button");
    }
    else if(export.isClicked)
    {
      export();
    }
    else if(edit.isClicked)
    {
      show.clear();
      for(String s : save)
      {
        String[] t = split(s, ' ');
        if(checkStrings(t[0], "init"))
        {
          show.addItem(t[2]);
        }
      }
      setLayout(editor);
    }
  }
  
  void initCreating()
  {
      /* CREATING */
    main = new layout(ww + 200, wh);
    ae = new appElement(10, 10, ww, wh - 20);
    drawLabel = new button(ww + 15, 10, 60, 30, "Label");
    drawButton = new button(ww + 85, 10, 60, 30, "Button");
    export = new button(ww + 15, 50, 160, 30, "Export Application");
    coord[0] = new textField(ww + 15, 90, 40, 30, "X:");
    coord[1] = new textField(ww + 15 + 45, 90, 40, 30, "Y:");
    coord[2] = new textField(ww + 15 + 90, 90, 40, 30, "W:");
    coord[3] = new textField(ww + 15 + 135, 90, 40, 30, "H:");
    text = new textField(ww + 15, 140, 160, 30, "Text:");
    edit = new button(ww + 15, 190, 160, 30, "Editor");
    
    main.addComponent(ae);
    main.addComponent(drawLabel);
    main.addComponent(drawButton);
    main.addComponent(export);
    main.addComponent(text);
    main.addComponent(edit);
    
    for(int a = 0; a < coord.length; a++)
    {
      main.addComponent(coord[a]);
    }
    
    /* EDITOR */
    editor = new layout(main.w, main.h);
    codeArea = new textArea(10, 45, ww, wh - 75);
    showCurComponent = new label(50, 10, 300, 30, " ");
    show = new itemList(ww + 20, 45, 150, wh - 75);
    back = new button(10, 10, 30, 30, "<");
    
    editor.addComponent(codeArea);
    editor.addComponent(showCurComponent);
    editor.addComponent(show);
    editor.addComponent(back);
  }
}

class appElement extends component
{
  int cx = 0;
  int cy = 0;
  int cw = 0;
  int ch = 0;
  String component = null;
  boolean isReady = false;
  collisionBox cb;
  final color base = color(206, 206, 206);
  
  appElement(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
  }
  
  void setComponent(String c)
  {
    component = c;
  }
  
  String getType()
  {
    return component;
  }
  
  component getComponent()
  {
    int x = cx - tx;
    int y = cy - ty;
    int w = cw;
    int h = ch;
    
    if(w < 1)
    {
      x += w;
      w *= -1;
    }
    
    if(h < 1)
    {
      y += h;
      h *= -1;
    }
        
    switch(component)
    {
      case "label":
      {
        return new label(x, y, w, h, "");
      }
      
      case "button":
      {
        return new button(x, y, w, h, "");
      }
    }
    
    return null;
  }
  
  void reset()
  {
    cx = 0;
    cy = 0;
    cw = 0;
    ch = 0;
    isReady = false;
  }
  
  void render()
  {
    cb = new collisionBox(x + tx, y + ty, w, h);
    
    fill(border);
    rect(x + tx, y + ty, w, h);
    
    fill(base);
    rect(x + tx + borderWidth, y + ty + borderWidth, w - borderWidth*2, h - borderWidth*2);
    
    if(cb.isOver() && component != null)
    {
      if(mouseClicked)
      {
        cx = mouseX;
        cy = mouseY;
      }
      
      if(cx > x + tx && cy > y + ty && mousePressed)
      {
        cw = mouseX - cx;
        ch = mouseY - cy;
        
        fill(border);
        rect(cx, cy, cw, ch);
        
        fill(normal);
        rect(cx + borderWidth, cy + borderWidth, cw - borderWidth*2, ch - borderWidth*2);
      }
      
      if(cx != 0 && cy != 0 && cw != 0 && ch != 0 && mouseReleased)
      {
        isReady = true;
      }
    }
  }
}