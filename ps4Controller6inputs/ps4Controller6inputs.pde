/**
 When this sketch runs it will try and find
 a game device that matches the configuration
 file 'ps4Controller' if it can't match this device
 then it will present you with a list of devices
 you might try and use.
 
 The chosen device requires 6 sliders
 LeftStickX, LeftStickY, RightStickX, RightStickY, L2,R2
 
 then sends the values to wekinator
 This sends 6 input values to port 6448 using message /wek/inputs
 */

import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

ControlIO control;
Configuration config;
ControlDevice gpad;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

//Controller input
float leftStickX, leftStickY, rightStickX, rightStickY, l2,r2;

//Circle variables
float x,y,w,h,hosc,vosc;
float af = 0.0;

public void setup() {
  size(400, 240);
  // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  // Find a device that matches the configuration file
  gpad = control.getMatchedDevice("ps4Controller");
  if (gpad == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
  
    /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,9000);
  dest = new NetAddress("127.0.0.1",6448);
}



public void draw() {
  background(0);
  retrieveInput();
  displayValues();
  
    if(frameCount % 2 == 0) {
    sendOsc();
  }
}

public void retrieveInput(){
  leftStickX = gpad.getSlider("LeftStickX").getValue();
  leftStickY = gpad.getSlider("LeftStickY").getValue();
  rightStickX = gpad.getSlider("RightStickX").getValue();
  rightStickY = gpad.getSlider("RightStickY").getValue();
  l2 = gpad.getSlider("L2").getValue();
  r2 = gpad.getSlider("R2").getValue();
}

public void displayValues(){
  fill(255);
  text("Left Stick X",20,50);
  text(leftStickX,100,50);
  
  text("Left Stick Y",20,70);
  text(leftStickY,100,70);
  
  text("Right Stick X",20,90);
  text(rightStickX,100,90);
  
  text("Right Stick Y",20,110);
  text(rightStickY,100,110);
  
  text("L2",20,130);
  text(l2,100,130);
  
    text("R2",20,150);
  text(r2,100,150);
  
  x = map(leftStickX,-1,1,0,width);
  y = map(leftStickY,-1,1,0,height);
  w = map(rightStickX,-1,1,20,100);
  h = map(rightStickY,-1,1,20,100);
  vosc = map(r2,-1,1,0,100)*sin(af);;
  hosc = map(l2,-1,1,0,100)*cos(af);
  fill(255,50);
  ellipse(x+hosc,y+vosc,w,h);
  af+=0.1;
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add((float)leftStickX); 
  msg.add((float)leftStickY);
  msg.add((float)rightStickX);
  msg.add((float)rightStickY);
  msg.add((float)l2);
  msg.add((float)r2);
  
  oscP5.send(msg, dest);
}
