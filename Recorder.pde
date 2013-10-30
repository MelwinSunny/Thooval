class Recorder
{
  Point [] points;
  boolean recording;
  boolean hasPoints;
  
  Recorder()
  {
     points = new Point[0];
     recording = false;
  }
  
  void update()
  {
    if( recording)
    {
      if( mousePressed )
      {
        if(mouseX>=90 && mouseX<760)
   { if(mouseY>=86 && mouseY<497)
     {stroke(5);
     
     points = (Point[])append(points, new Point( mouseX, mouseY));
     }else {noStroke();}
    
    
  }
  else{ noFill();noStroke();}

        
      }
      else
      {
        recording = false;
        if( points.length > 5)
        {
          hasPoints = true;
        }
      }
    }
    else
    {
      if( mousePressed)
      {
        points = new Point[0];
        recording = true;
        hasPoints = false;
      }
    }
  }
  
  void draw( )
  {
     color c = color(0,0,0);
     if( recording )
     {
       c = color(255, 255, 0);
     }
     if( points.length > 1)
     {
       for( int i = 1; i < points.length; i++)
       {
         stroke( c );
         line( points[i-1].X, points[i-1].Y, 
               points[i  ].X, points[i  ].Y);
       }
     }
  }
}

