class example extends application
{
  layout layout;
  button button;
  label label;
  textField textField;
  switchButton switchButton;
  progressBar progressBar;
  slider slider1;
  slider slider2;
  itemList itemList; 
  checkBox checkBox1;
  checkBox checkBox2;
  textArea textArea;
  scrollBar scrollBar;
    
  void init()
  {
    //register component
    layout = new layout(500, 500);
                                           //+40 - first col
    button = new button                (20, 20, 100, 30, "Button");
    label = new label                  (20, 60, 100, 30, "Label");
    switchButton = new switchButton    (20, 100, 100, 30, "SwitchButton");
    progressBar = new progressBar      (20, 140, 100, 30);
    slider1 = new slider               (20, 180, 100, 30);
    slider2 = new slider               (20, 220, 100, 30);
    textField = new textField          (20, 260, 300, 30, "Text Field");
    checkBox1 = new checkBox           (20, 300, 100, 30, "CheckBox1");
    checkBox2 = new checkBox           (20, 340, 100, 30, "CheckBox2");
                                           //+40 - second col
    textArea = new textArea            (130, 20, 150, 100);
    itemList = new itemList            (150, 220, 100, 300);
    scrollBar = new scrollBar          (480, 20, 15, 450);
    
    //Custom settings
    itemList.addItem("iwan1");
    itemList.addItem("iwan2");
    itemList.addItem("iwan3");
    itemList.addItem("iwan4");
    progressBar.showPercentage(true);
    slider1.showPercentage(true);
    slider2.showPercentage(true);
    progressBar.setColor(150, 0, 255);
    textField.addToLibrary("text");
    textField.addToLibrary("test");
    textField.addToLibrary("iwan");
    textField.addToLibrary("peter");
    textField.addToLibrary("peterdwa");
    slider2.setType("vertical");
    scrollBar.setScrollSize(50);
    
    //add component to layout
    layout.addComponent(button);
    layout.addComponent(label);
    layout.addComponent(switchButton);
    layout.addComponent(progressBar);
    layout.addComponent(slider1);
    layout.addComponent(slider2);
    layout.addComponent(itemList);
    layout.addComponent(textField);
    layout.addComponent(checkBox1);
    layout.addComponent(checkBox2);
    layout.addComponent(textArea);
    layout.addComponent(scrollBar);
  }
    
  void update()
  {
    setLayout(layout);

    itemList.setOpen(switchButton.isClicked);
    
    progressBar.setProgress(slider1.getPercentage());
  }  //<>//
}