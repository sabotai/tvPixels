class Television {
  int xPos, yPos;
  int videoScale;
  int cols, rows;
  
  PImage tvImage;
  
  Television(){ // <-----default constructor
    cols = 160;
    rows = 120;
    videoScale = 2;
    
  tvImage = loadImage("tv.png");
  }
  
  void init(){
    xPos = int(random(0,width - cols));
    yPos = int(random(0,height - rows));
  }
  
  void run(){
    
    
    for (int i = 0; i < cols; i++) { 
      for (int j = 0; j < rows; j++) {
        int x = i * videoScale;
        int y = j * videoScale;
        int loc = i + j * tv.width;  
        color c = tv.pixels[loc];
        float sz = (brightness(c)/255.0)*videoScale * 3;
  
        rectMode(CENTER);
        fill(255);
        noStroke();
        
        pushMatrix();
       // translate(videoScale * x + videoScale/2, videoScale * y+videoScale/2);
        translate(videoScale * x + xPos, videoScale * y + yPos);
  
        float newHue = hue(c);
        float newBright = brightness(c);
        
        rectMode(CENTER);
        
        if (which){
          fill(newHue, 80, 150);
          //rect(0,0,sz*10,sz*10);
          rect(0,0,23,23,3);
          fill(newHue, 80, 200);
          //rect(0,0,sz*10,sz*10);
          rect(0,0,20,20,3);
          
          fill(newHue, 100, 255);
          rect(0, 0, sz, sz, 3);
        }
        else {
          fill(newBright);
          //rect(0,0,sz*10,sz*10);
          rect(0,0,23,23,3);
          fill(newBright);
          //rect(0,0,sz*10,sz*10);
          rect(0,0,20,20,3);
          
          fill(newBright);
          rect(0, 0, sz, sz, 3);
        }
        popMatrix();
      }
    }
    
    image(tvImage, xPos - tvImage.width /8, yPos - tvImage.width/8);
  }
}
