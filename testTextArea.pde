class testTextArea extends application
{
  layout l;
  textArea a;
  void init()
  {
    l = new layout(500, 400);
    a = new textArea(10, 50, 480, 345);
    
    l.addComponent(a);
  }
  
  void update()
  {
    setLayout(l);
  }
}