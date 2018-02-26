class textEditor extends application
{
  dtext dtxt;
  layout createFile;
  textField enterName;
  button load;
  button create;
  
  layout main;
  textArea enterText;
  button newFile;
  button saveFile;
  
  void init()
  {
    /* WRITING */
    main = new layout(576, 500);
    enterText = new textArea(0, 0, 500, 500);
    saveFile = new button(510, 70, 25, 25, getImage("textures/button/tools/active/save_file.png"));
    newFile = new button(540, 70, 25, 25, getImage("textures/button/tools/active/new_file.png"));
    
    main.addComponent(enterText);
    main.addComponent(saveFile);
    main.addComponent(newFile);
    
    /* CREATE FILE */
    createFile = new layout(250, 100);
    create = new button(150, 60, 90, 30, "Create new");
    load = new button(85, 60, 60, 30, "Load");
    enterName = new textField(10, 10, 230, 30, "Name");
    
    createFile.addComponent(create);
    createFile.addComponent(load);
    createFile.addComponent(enterName);
    
    setLayout(createFile);
  }
  
  void update()
  {
    if(getLayout() == main)
    {
      if(saveFile.isClicked)
      {
        dtxt = new dtext(enterName.getText());
        dtxt.save(enterText.getText());
      }
    }
    else if(getLayout() == createFile)
    {
      if(load.isClicked)
      {
        dtxt = new dtext(enterName.getText());
        enterText.setText(dtxt.load());
        setLayout(main);
      }
      else if(create.isClicked)
      {
        setLayout(main);
      }
    }
  }
}