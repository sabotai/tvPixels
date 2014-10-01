class Television {
  int xPos, yPos;
  int videoScale;
  int cols, rows, lines;
  boolean evenLine, oddLine, interlaceSet;

  PImage tvImage;
  float[] oldPixel = new float[19200];
  int[] changeCount = new int[19200];
  int changeLimit, threshold;
  //OpenCV opencv;
  int closeCount, closeMax;
  boolean closed;

  Television() { // <-----default constructor
    cols = 160;
    rows = 120;
    videoScale = 2;
    evenLine = true;
    oddLine = false;
    interlaceSet = true;
    lines = 2;
    changeLimit = 15;
    threshold = 70;
    closeMax = 5;


    rectMode(CENTER);
    tvImage = loadImage("tv.png");
  }

  void init() {
    xPos = int(random(0, width - cols));
    yPos = int(random(0, height - rows));
  }

  void run() {

    opencv.loadImage(tv);
    eyecv.loadImage(tv);
    Rectangle[] faces = opencv.detect();
    Rectangle[] eyes = eyecv.detect();
    //println("happenz");
    if (faces.length > 0) {
      xPos = int((float(faces[0].x) / cols) * width) * -1 + width/2;
      yPos = int((float(faces[0].y) / rows) * height);
      //println(xPos + " xpos   " + yPos + " ypos");
    }
    if (eyes.length < 1) {

      if (closeCount >= closeMax) {

        visible = false;
      } else {
        closeCount++;
      }
    } else {
      visible = true; 
      closeCount = 0;
    }


if (visible) {
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
      float corners = 0.3 * videoScale; //old = 3

      color altColor = color(newHue, 80, 255);






      if (newHue - oldPixel[loc] < threshold) { //IF NO MOVEMENT

        if ((changeCount[loc] > 0) && (changeCount[loc] < changeLimit)) {  
          changeCount[loc]++;
          float progress = float(changeCount[loc]) / float(changeLimit);
          //println("change is " + changeCount[loc]);
          altColor = lerpColor(altColor, c, progress);
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

            if ((j % lines == 0)) {
              fill(altColor);
              rect(testX, testY, lrg, lrg, corners);

              fill(newHue, 100, 255);
            }
          } else {
            if ((j % lines != 0)) {
              fill(altColor);
              rect(testX, testY, lrg, lrg, corners);
            }
          }
        } else { // REGULAR COLORS
          //println("reg colors");
          if (interlaceSet) {
            fill(hue(c), saturation(c), brightness(c));


            if ((j % lines == 0)) {
              rect(testX, testY, lrg, lrg, corners);
            }
          } else {
            fill(hue(c), saturation(c), brightness(c));
            if ((j % lines != 0)) {
              rect(testX, testY, lrg, lrg, corners);
            }
          }
        }
      } else { // BLACK AND WHITE
        if (interlaceSet) {
          if ((j % lines == 0)) {
            fill(newBright);
            rect(testX, testY, lrg, lrg, corners);
          }
        } else {
          if ((j % lines != 0)) {
            fill(newBright);
            rect(testX, testY, lrg, lrg, corners);
          }
        }
      }
      oldPixel[loc] = newHue;

      interlaceSet = !interlaceSet;
    }
  }

  image(tvImage, xPos - tvImage.width /8, yPos - tvImage.width/8);
}
/*
  for (int i = 0; i < faces.length; i++) {
 println(faces[i].x + "," + faces[i].y);
 rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
 }
 */
}
}
