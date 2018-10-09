Letters c;
//Circles c2 = new Circles(random(2,26),random(2,26), 0.0006, 150, 250);

PFont font;

//Necessary for OSC communication with Wekinator:
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;


void setup() {
  //size(800,600);
  fullScreen();
  background(0);
  
  //Initialize OSC communication
  oscP5 = new OscP5(this,12000); //listen for OSC messages on port 12000 (Wekinator default)
  dest = new NetAddress("127.0.0.1",6448); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
  

  noFill();
  colorMode(HSB, 100);
  
  //  Letters(float csH, float snH, float incre, int m, float amp, float lSizeMax) 
  c = new Letters(random(2, 26), random(2, 26), 0.003, 50, 700,70);

  font = loadFont("Courier-168.vlw");
  textFont(font, 32);
  
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  c.display();
  popMatrix();
  c.update();
  //println(frameRate);
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
 if (theOscMessage.checkAddrPattern("/wek/outputs")==true) {
     if(theOscMessage.checkTypetag("ffffff")) { //Now looking for 2 parameters
        float p1 = theOscMessage.get(0).floatValue(); //get this parameter
        float p2 = theOscMessage.get(1).floatValue(); //get 2nd parameter
        float p3 = theOscMessage.get(2).floatValue(); //get third parameters
        float p4 = theOscMessage.get(3).floatValue(); //get fourth parameters
        float p5 = theOscMessage.get(4).floatValue(); //get fifth parameters
        float p6 = theOscMessage.get(5).floatValue(); //get sixth parameters
        //functions to update the values
        
        //p1 Lsticky color 7 values
        c.changeColors(p1);
        //p2 Lstickx cosHarmo, 8 values
        c.changeCosHarmo(p2);
        //p3 RstickX sinHarmo, 8 values
        c.changeSinHarmo(p3);
        //p4 RstickY letterSize 5values
        c.changeLetSizeMax(p4);
        //p5 R2 inc, 5 values
        c.changeInc(p5);
        //p6 L2 4 values
         c.changeFunction(p6);
         
        
        
        
       // println("Received new params value from Wekinator");  
      } else {
        println("Error: unexpected params type tag received by Processing");
      }
 }
}




//void keyPressed() {

//  //c.changeHarmo(random(2, 16), random(2, 16));
//  c.changeInc(random(0.0001,0.003));
//  c.changeLetSizeMax(random(10,50));
//  c.changeFunction(int(random(0,4)));
  
//  c.changeColors(random(1,8));
//  c.changeLetter();
//}
