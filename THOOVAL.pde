//Note: Follow the arrow and you will get result

// What follows here is what we have done using the sample code given as example for OneDollarUnistrokeRecognizer
// There is probably a better way to do it, but this works. 


import controlP5.*;

PImage imagealphabet;


PImage right;
PImage wrong;
PImage refresh;
PImage board;
PImage welcomescreen;
PImage curso;

ControlP5 cp5; //library for text box I/O


int f;
int obj,pos;

int choice;
String imagedisp;
String imagedisp2;
String check;
String check2;

int NumTemplates = 16;
int NumPoints = 64;
int openwindow;

float SquareSize = 250.0;
float HalfDiagonal = 0.5 * sqrt(250.0 * 250.0 + 250.0 * 250.0);
float AngleRange = 45.0;
float AnglePrecision = 2.0;
float Phi = 0.5 * (-1.0 + sqrt(5.0)); // Golden Ratio

Float xaxis;
Float yaxis;

String [] pointsload;
String [] pointschangegesture;
Pointchange [] pointchangeobj;

//object creation of classes used

Recognizer recognizer;
Recorder recorder;
Result result;
PFont font;

  
void setup() 
{
  curso=loadImage("THOOVAL.png");
  board=loadImage("BackgroundImage.png");            //desired background image
  welcomescreen=loadImage("welcome.png");            //desired start up page

size(1024,895);
cursor(curso,0,61);

openwindow=0;                                         //to control the entry to the application (works as a flag)

  right=loadImage("right.png");                       //the image to be displayed when the result is 'right'
  wrong=loadImage("wrong1.png");                      //the image to be displayed when the result is 'wrong'
  
  
  imagealphabet=loadImage("A.png");                   
  check="A";
  
  pointsload=loadStrings("GESTURE.txt");              // the file in which all the gestures are stored in a file
  pointschangegesture=loadStrings("movingpointsgestures.txt");
  pointchangeobj=new Pointchange[100];
  for(int i1=0;i1<pointschangegesture.length;i1++)
  {
   println(pointschangegesture[i1]);
    pointchangeobj[i1]= new Pointchange(i1); 
  }
  
  recognizer = new Recognizer();
  recorder = new Recorder();
  smooth();

  strokeWeight(5);                                    //thickness of the points to be displayed
   result=new Result("refresh",0.0,0.0);
   result.Name="refresh";
}

void draw() 
{
  if(openwindow==0)
  {
    background(255);
    image(welcomescreen,100,300);
  }else
  { 
    /*
    stroke(0,0,255);
    point((Float)pointchangeobj[obj].pointChangeAList.get(1),(Float)pointchangeobj[obj].pointChangeAList.get(2));
    */
    
    image(board,0,0);
    image(imagealphabet,125,200);
    recorder.update();
    recorder.draw();
  if( recorder.hasPoints)
  {
    Point [] points = recorder.points;
    result = recognizer.Recognize( points );
    recorder.hasPoints = false;
  }  
  if( result != null)
  {
    textAlign(CENTER, CENTER);
    fill( color( 12,12,12));
    imagedisp2=result.Name+".png";
    if(result.Name.equals("refresh")==true)          //||result.Name.equals("- none -")
    {
                                                      //display the image if its a new click ("refresh")                      
    }
    else if(result.Name.equals(check)==true)
    {
       image(right,640,70);                            //display the image if true  
     }
     else
     {
       image(wrong,640,70);                             //display the image if false
     }    
   }
   
  stroke(0,0,255);
 point((Float)pointchangeobj[obj].pointChangeAList.get(0),(Float)pointchangeobj[obj].pointChangeAList.get(1));

  }  //moving points
  for(int k=0;k<f;k=k+2)
  {
  strokeWeight(10);
  if(k==(f-1)){
  /*stroke(0,0,255);
 xaxis= (Float)pointchangeobj[obj].pointChangeAList.get(pos);
 
 yaxis= (Float)pointchangeobj[obj].pointChangeAList.get(pos+1);

point(xaxis,yaxis);
*/
  }else
  {
   stroke(0,0,255);
   //point((Float)pointchangeobj[obj].pointChangeAList.get(k),(Float)pointchangeobj[obj].pointChangeAList.get(k+1));
  }
}  
}

// to avoid multiple load save the images in an array in setup( if the error of memory outof bounds pops out)

// loading corresponding image to the click

void mousePressed()
{
  
  if ((mouseX>=380 && mouseX<=610)&&(mouseY>=350 && mouseY<=525))
  {
    openwindow=1;
     obj=0;
    f=1;
    
    pos=0;
  }
    
  if ((mouseX>=86 && mouseX<=141)&&(mouseY>=580 && mouseY<=623))
  {
    imagealphabet=loadImage("A.png");
    
    check="A";
    result.Name="refresh";
    obj=0;
    f=1;
   
    pos=0;
    
  }else if ((mouseX>=145 && mouseX<=200)&&(mouseY>=580 && mouseY<=623))
  {  
    imagealphabet=loadImage("AA.png");
    check="AA";
    result.Name="refresh";
    obj=1;
    f=1;
  
    pos=0;
  }else if ((mouseX>=203 && mouseX<=250)&&(mouseY>=580 && mouseY<=623))
  { 
    imagealphabet=loadImage("I.png");
    check="I";
    result.Name="refresh";
    check="I";
    obj=2;
    f=1;
    pos=0;
  }else if ((mouseX>=254 && mouseX<=298)&&(mouseY>=580 && mouseY<=623))
  { 
    imagealphabet=loadImage("U.png");
    check="U";
    result.Name="refresh";
    obj=3;
    f=1;
    pos=0;
  }else if ((mouseX>=301 && mouseX<=348)&&(mouseY>=580 && mouseY<=623))
  { 
    imagealphabet=loadImage("R.png");
    check="R";result.Name="refresh";obj=4;
    f=1;
    pos=0;
  }else if ((mouseX>=351 && mouseX<=399)&&(mouseY>=580 && mouseY<=623))
  {  
    imagealphabet=loadImage("E.png");
    check="E";
    result.Name="refresh";obj=5;
    f=1;
    pos=0;
  }else if ((mouseX>=402 && mouseX<=449)&&(mouseY>=580 && mouseY<=623))
  {  
    imagealphabet=loadImage("EE.png");
    result.Name="refresh";
    check="EE";obj=6;
    f=1;
    pos=0;
  }else if ((mouseX>=452 && mouseX<=499)&&(mouseY>=580 && mouseY<=623))
  {  
    imagealphabet=loadImage("O.png");
    result.Name="refresh";
    check="O";obj=7;
    f=1;
    pos=0;
  }else if ((mouseX>=501 && mouseX<=543)&&(mouseY>=580 && mouseY<=623))
  {  
    imagealphabet=loadImage("KA.png");
    result.Name="refresh";
    check="KA";obj=8;
    f=1;
    pos=0;
  }else if ((mouseX>=546 && mouseX<=586)&&(mouseY>=580 && mouseY<=623))
  {  
    imagealphabet=loadImage("KHA.png");result.Name="refresh";
    check="KHA";obj=9;
    f=1;
    pos=0;
  }else if ((mouseX>=590 && mouseX<=636)&&(mouseY>=580 && mouseY<=623))
  {  
    imagealphabet=loadImage("GA.png");result.Name="refresh";
    check="GA";obj=10;
    f=1;
    pos=0;
  }else if ((mouseX>=640 && mouseX<=685)&&(mouseY>=580 && mouseY<=623))
  {  
    imagealphabet=loadImage("GHA.png");result.Name="refresh";
    check="GHA";obj=11;    f=1;    pos=0;
  }else if ((mouseX>=691 && mouseX<=731)&&(mouseY>=580 && mouseY<=623))
  {  
    imagealphabet=loadImage("NGA.png");result.Name="refresh";
    check="NGA";obj=12;
    f=1;
    pos=0;
  }else if ((mouseX>=733 && mouseX<=779)&&(mouseY>=580 && mouseY<=623))
  {      
    imagealphabet=loadImage("CA.png");result.Name="refresh";
    check="CA";obj=13;
    f=1;
    pos=0; 
  }else if ((mouseX>=85 && mouseX<=132)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("CHA.png");result.Name="refresh";
    check="CHA";obj=14;
    f=1;
    pos=0;
  }else if ((mouseX>=136 && mouseX<=178)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("JA.png");result.Name="refresh";
    check="JA";obj=15;
    f=1;
    pos=0;
  }else if ((mouseX>=181 && mouseX<=244)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("JHA.png");result.Name="refresh";
    check="JHA";obj=16;
    f=1;
    pos=0;
  }else if ((mouseX>=248 && mouseX<=294)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("NYA.png");result.Name="refresh";
    check="NYA"; obj=17;     f=1;     pos=0;
  }else if ((mouseX>=297 && mouseX<=328)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("TTA.png");result.Name="refresh";
    check="GA"; obj=18;     f=1;     pos=0;               //GA and TTA have same gester
  }else if ((mouseX>=331 && mouseX<=365)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("TTHH.png");result.Name="refresh";
    check="TTHH"; obj=19;     f=1;     pos=0;
  }else if ((mouseX>=368 && mouseX<=416)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("DDA.png");result.Name="refresh";
    check="DDA"; obj=20;     f=1;     pos=0;
  }else if ((mouseX>=420 && mouseX<=474)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("DDHA.png");result.Name="refresh";
    check="DDHA"; obj=21;     f=1;     pos=0;
  }else if ((mouseX>=478 && mouseX<=524)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("NNA.png");result.Name="refresh";
    check="NNA"; obj=22;     f=1;     pos=0;
  }else if ((mouseX>=528 && mouseX<=570)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("TA.png");result.Name="refresh";
    check="TA"; obj=23;     f=1;     pos=0;
  }else if ((mouseX>=573 && mouseX<=614)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("THA.png");result.Name="refresh";
    check="THA"; obj=24;     f=1;     pos=0;
  }else if ((mouseX>=617 && mouseX<=648)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("DA.png");result.Name="refresh";
    check="DA"; obj=25;     f=1;     pos=0;          
  }else if ((mouseX>=650 && mouseX<=688)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("DHA.png");result.Name="refresh";
    check="DHA"; obj=26;     f=1;     pos=0;
  }else if ((mouseX>=692 && mouseX<=730)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("NA.png");result.Name="refresh";
    check="NA"; obj=27;     f=1;     pos=0;
  }else if ((mouseX>=734 && mouseX<=779)&&(mouseY>=634 && mouseY<=676))
  {  
    imagealphabet=loadImage("PA.png");result.Name="refresh";
    check="PA"; obj=28;     f=1;     pos=0;
  }else if ((mouseX>=86 && mouseX<=137)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("PHA.png");result.Name="refresh";
    check="PHA"; obj=29;     f=1;     pos=0;
  }else if ((mouseX>=141 && mouseX<=189)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("BA.png");result.Name="refresh";
    check="BA"; obj=30;     f=1;     pos=0;
  }else if ((mouseX>=194 && mouseX<=227)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("BHA.png");result.Name="refresh";
    check="BHA"; obj=31;     f=1;     pos=0;
  }else if ((mouseX>=229 && mouseX<=257)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("MA.png");result.Name="refresh";
    check="MA"; obj=32;     f=1;     pos=0;
  }else if ((mouseX>=261 && mouseX<=301)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("YA.png");result.Name="refresh";
    check="YA"; obj=33;     f=1;     pos=0;
  }else if ((mouseX>=304 && mouseX<=337)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("RA.png");result.Name="refresh";
    check="RA"; obj=34;     f=1;     pos=0;
  }else if ((mouseX>=340 && mouseX<=378)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("LA.png");result.Name="refresh";
    check="LA"; obj=35;     f=1;     pos=0;
  }else if ((mouseX>=382 && mouseX<=420)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("VA.png");result.Name="refresh";
    check="VA"; obj=36;     f=1;     pos=0;
  }else if ((mouseX>=423 && mouseX<=462)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("SHA.png");result.Name="refresh";
    check="SHA"; obj=37;     f=1;     pos=0;
  }else if ((mouseX>=465 && mouseX<=514)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("SSA.png");result.Name="refresh";
    check="SSA"; obj=38;     f=1;     pos=0;
  }else if ((mouseX>=518 && mouseX<=565)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("SA.png");result.Name="refresh";
    check="SA"; obj=39;     f=1;     pos=0;
  }else if ((mouseX>=569 && mouseX<=617)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("HA.png");result.Name="refresh";
    check="HA"; obj=40;     f=1;     pos=0;
  }else if ((mouseX>=620 && mouseX<=657)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("LLA.png");result.Name="refresh";
    check="LLA"; obj=41;     f=1;     pos=0;
  }else if ((mouseX>=660 && mouseX<=691)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("LLLA.png");result.Name="refresh";
    check="LLLA"; obj=42;     f=1;     pos=0;
  }else if ((mouseX>=696 && mouseX<=723)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("RRA.png");result.Name="refresh";
    check="RRA"; obj=43;     f=1;     pos=0;
  }else if ((mouseX>=627 && mouseX<=779)&&(mouseY>=687 && mouseY<=729))
  {  
    imagealphabet=loadImage("ennn.png");result.Name="refresh";
    check="ennn"; obj=44;     f=1;     pos=0;
  }else if ((mouseX>=86 && mouseX<=129)&&(mouseY>=738 && mouseY<=778))
  {  
    imagealphabet=loadImage("nnn.png");result.Name="refresh";
    check="nnn"; obj=45;     f=1;     pos=0;
  }else if ((mouseX>=133 && mouseX<=175)&&(mouseY>=738 && mouseY<=778))
  {  
    imagealphabet=loadImage("elll.png");result.Name="refresh";
    check="elll"; obj=46;     f=1;     pos=0;
  }else if ((mouseX>=180 && mouseX<=220)&&(mouseY>=738 && mouseY<=778))
  {  
    imagealphabet=loadImage("lll.png");result.Name="refresh";
    check="lll"; obj=47;     f=1;     pos=0;
  }else if ((mouseX>=228 && mouseX<=260)&&(mouseY>=738 && mouseY<=778))
  {  
    imagealphabet=loadImage("rrr.png");result.Name="refresh";
    check="rrr"; obj=48;     f=1;     pos=0;
  }
}
void mouseDragged()
{
  line(pmouseX,pmouseY,mouseX,mouseY);
 
  if(f<pointchangeobj[obj].pointChangeAList.size())
    { stroke(0,0,255);
 xaxis= (Float)pointchangeobj[obj].pointChangeAList.get(pos);
 yaxis= (Float)pointchangeobj[obj].pointChangeAList.get(pos+1);
 point(xaxis,yaxis);
    }
 
  if(((mouseX-xaxis)*(mouseX-xaxis)+(mouseY-yaxis)*(mouseY-yaxis))<=25)
  {
    if(f<pointchangeobj[obj].pointChangeAList.size())
    {
    f=f+2;
    println("f=  "+f);
    pos=pos+2;
    println("pos= "+pos);
    }
  }
}

void mouseReleased()
{
  f=1;pos=0;}
