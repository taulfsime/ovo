class command extends application
{
  layout main;
  textField enterCommand;
  button enter;
  label test;
  String cmd = null;
  
  void init()
  {
    main = new layout(456, 327);
    enterCommand = new textField(10, 260, 370, 30, "Enter command:");
    enter = new button(385, 260, 50, 30, "Enter");
    test = new label(10, 50, 100, 30, "");
    
    enter.bindKey(ENTER);
    
    main.addComponent(enterCommand);
    main.addComponent(enter);
    main.addComponent(test);
  }
  
  void update()
  {
    setLayout(main);
    test.setText(cmd + ";");
    
    if(enter.isClicked)
    {
      cmd = enterCommand.getText();
    }
    
    
   if(cmd != null)
   {
     println(cmd);
     if(cmd == "painter")
     {
       println(0);
       system.getWindow("painter").open();
     }
     
     cmd = null;
   }
    
  }
}