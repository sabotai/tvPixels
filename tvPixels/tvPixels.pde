
import processing.video.*;


int videoScale = 4;
int cols, rows;
Capture video, tv;

int objectCount;

ArrayList<Television> teevees = new ArrayList();
boolean which;

void setup() {
  size(1920, 1440);
  
  cols = 160;
  rows = 120;
  
//  video = new Capture(this, cols, rows,30);
//  video.start();

      tv = new Capture(this, cols, rows,30);
      tv.start();
      
  colorMode(HSB);
  
    Television myTeevees = new Television();
  teevees.add(myTeevees);
}  

void draw() {
  background(0);
  
  if (tv.available()) {
    tv.read();
  }
  tv.loadPixels();
  
  for (int xx=0; xx < width; xx++) {
    float noiseScale = 1;
    float noiseVal = noise((mouseX+xx)*noiseScale, 
                            mouseY*noiseScale);
    stroke(noiseVal*255);
    line(xx, mouseY+noiseVal*80, xx, height);
  }


    


  for (int i = 0; i < teevees.size(); i++){
    Television t = (Television) teevees.get(i);
    if (i == 0){ 
        t.xPos = mouseX;
        t.yPos = mouseY;
      }
    //image(man, 0, 0);
    if (teevees.size() > 0){
      t.run();
    }
  }
  
}

void mouseClicked(){
  Television myTeevees = new Television();
  myTeevees.init();
  teevees.add(myTeevees); 
  
  println(teevees.size());
}

void keyPressed(){
 which = !which; 
}
