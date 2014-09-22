class Television {
  int xPos, yPos;
  int videoScale;
  int cols, rows, lines;
  boolean evenLine, oddLine, interlaceSet;

  PImage tvImage;
  float[] oldPixel = new float[19200];
  int[] changeCount = new int[19200];
  int changeLimit, threshold;

  Television() { // <-----default constructor
    cols = 160;
    rows = 120;
    videoScale = 2;
    evenLine = true;
    oddLine = false;
    interlaceSet = true;
    lines = 2;
    changeLimit = 5;
    threshold = 70;


    rectMode(CENTER);
    tvImage = loadImage("tv.png");
  }

  void init() {
    xPos = int(random(0, width - cols));
    yPos = int(random(0, height - rows));
  }

  void run() {


    for (int i = 0; i < cols; i++) { 
      for (int j = 0; j < rows; j++) {
        int x = i * videoScale;
        int y = j * videoScale;
        int loc = i + j * tv.width;  
        color c = tv.pixels[loc];
        c = color(hue(c), saturation(c), brightness(c) * 1.5); //it was too dark
        float sz = (brightness(c)/255.0)*videoScale * 3;

        rectMode(CENTER);
        //fill(255);
        //draw a 
        //noStroke();
        stroke(0, 200);
        strokeWeight(0.5);


        int testX = videoScale * x + xPos;
        int testY = videoScale * y + yPos;
        float newHue = hue(c);
        float newBright = brightness(c);
        newHue = newBright;
        float lrg = 2 * videoScale; //old = 23
        float sml = 1 * videoScale; //old = 20
        float corners = 0.4 * videoScale; //old = 3
        // println("sz = " + sz);

        if (newHue - oldPixel[loc] < threshold) { //IF NO MOVEMENT

          if ((changeCount[loc] > 0) && (changeCount[loc] < changeLimit)) {  
            changeCount[loc]++;
          } else {
            changeCount[loc] = 0;
          }
        } else { // IF THERE WAS MOVEMENT

          changeCount[loc]++;
        }


        if (changeCount[loc] > changeLimit) {  
          oldPixel[loc] = newHue;
          changeCount[loc] = 0;
        }


        if (which) {
          if (changeCount[loc] > 0) {
            //println("alt colors");  
            if (interlaceSet) {

              if ((j % lines == 0)) {// && (j % 2 == 0)){
                //evenLine = true; 
                //println("even J is " + j);
                fill(newHue, 80, 255);
                rect(testX, testY, lrg, lrg, corners);

                fill(newHue, 100, 255);
                //rect(testX,testY, sz, sz, corners);
              }
            } else {
              //if ((j % 2 != 0) && (i % 2 != 0)){

              if ((j % lines != 0)) {// && (j % 2 != 0)){
                //println("odd J is " + j);
                fill(newHue, 80, 255);
                rect(testX, testY, lrg, lrg, corners);
                
                
                fill(newHue, 100, 255);
                //rect(testX,testY, sz, sz, corners);
              }
            }
          } else { // REGULAR COLORS
            //println("reg colors");
            if (interlaceSet) {
              fill(hue(c), saturation(c),brightness(c));
              
              
              if ((j % lines == 0)) {
                rect(testX, testY, lrg, lrg, corners);
              }
            } else {
              fill(hue(c), saturation(c),brightness(c));
              if ((j % lines != 0)) {
                rect(testX, testY, lrg, lrg, corners);
              }
            }
          }
          
          
          
          
          
        } else { // BLACK AND WHITE
          if (interlaceSet) {
            if ((j % lines == 0)) {// && (j % 2 == 0)){
              //evenLine = true; 
              //println("even J is " + j);
              fill(newBright);
              rect(testX, testY, lrg, lrg, corners);

              //fill(newBright, 200);
              //rect(testX,testY,sml,sml,corners);

              //fill(newBright, 255);
              //rect(testX,testY, sz, sz, corners);
            }
          } else {
            //if ((j % 2 != 0) && (i % 2 != 0)){

            if ((j % lines != 0)) {// && (j % 2 != 0)){
              //println("odd J is " + j);
              fill(newBright);
              rect(testX, testY, lrg, lrg, corners);

              //fill(newBright);
              //rect(testX,testY,sml,sml,corners);

              //fill(newBright);
              //rect(testX,testY, sz, sz, corners);
            }
          }
        }
        oldPixel[loc] = newHue;

        interlaceSet = !interlaceSet;
      }
    }

    image(tvImage, xPos - tvImage.width /8, yPos - tvImage.width/8);
  }
}

