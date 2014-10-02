import gab.opencv.*;
import java.awt.*;



import processing.video.*;

boolean finished, visible;

int cols, rows;
Capture video, tv;
OpenCV opencv;
OpenCV eyecv;

int objectCount;
boolean frame;

ArrayList<Television> teevees = new ArrayList();
boolean which;

void setup() {
  size(1920, 1440);
  which = true;
  cols = 160;
  rows = 120;

  opencv = new OpenCV(this, cols, rows);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  eyecv = new OpenCV(this, cols, rows);
  eyecv.loadCascade(OpenCV.CASCADE_EYE); 

  // opencv = new OpenCV(this, 640/2, 480/2);

  //  video = new Capture(this, cols, rows,10);
  //  video.start();

  tv = new Capture(this, cols, rows, 30);
  tv.start();

  colorMode(HSB);

  Television myTeevees = new Television();
  teevees.add(myTeevees);

  noSmooth();
  // thread("noiseBG");
        strokeCap(PROJECT);
}  

void draw() {
  if (frame){
  println(frameRate);}
  scale(1.0, 1.0);
  //println(frameRate);

  strokeWeight(1);

  background(0);

  if (tv.available()) {
    tv.read();
  }
  tv.loadPixels();


  if (!visible) {
    int noisePixel = 5;
    
    for (int yy = 0; yy < height / noisePixel; yy++) {
      for (int xx = 0; xx < width / noisePixel; xx++) {
        float noiseScale = 5 * frameCount; 


        float noiseVal = noise(random(0,width)*noiseScale, random(0,height)*noiseScale);
        stroke(noiseVal*255);
        strokeWeight(noisePixel);
        line(xx*noisePixel, yy*noisePixel, xx*noisePixel, yy*noisePixel);
      }
    }
  } else {
    for (int xx = 0; xx < width; xx++) {
      float noiseScale = 5 * frameCount;



      float noiseVal = noise((mouseX+xx)*noiseScale, mouseY*noiseScale);
      stroke(noiseVal*255);
      line(xx, mouseY+noiseVal*240, xx, height);
    }
  }



  //thread("noiseBG");
  for (int i = 0; i < teevees.size (); i++) {
    Television t = (Television) teevees.get(i);
    if (i == 0) { 
      //t.xPos = mouseX;
      //t.yPos = mouseY;
    }
    //image(man, 0, 0);
    if (teevees.size() > 0) {
      t.run();
    }
  }
}

void mouseClicked() {
  Television myTeevees = new Television();
  myTeevees.init();
  teevees.add(myTeevees); 

  println(teevees.size());
}

void keyPressed() {
  
  if(keyCode == ALT){
  which = !which;
  } else{ if (keyCode == SHIFT){
   frame = !frame; 
  }}
}

void noiseBG() {
}

