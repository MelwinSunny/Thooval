class Recognizer
{
   Template [] Templates = {};
  
   Recognizer( )
   {
     for(int i=0;i<pointsload.length;i++)
     {       
       splitting(i);
     }
   }
     
 
void splitting(int j)                                                   //The part where the gesters are loaded from the file we have saved
{
  String str=pointsload[j];
  String []str1=split(str,',');
  int z=(str1.length-1)/2;
  
  Point [] points=new Point[z];
  for(int ii=1;ii<str1.length;)
  {    
    points[(ii-1)/2]=new Point(Float.parseFloat(str1[ii]),Float.parseFloat(str1[ii+1]));
    ii=ii+2;
   }
   
   AddTemplate(str1[0], points);
}
     
     
     Result Recognize( Point [] points)
     {
        points = Resample( points, NumPoints);
        points = RotateToZero( points );
        points = ScaleToSquare(points, SquareSize);
        points = TranslateToOrigin(points);
        float best = Infinity;
        float sndBest = Infinity;
        int t = -1;
        for( int i = 0; i < Templates.length; i++)
        {
          float d = DistanceAtBestAngle( points, Templates[i], -AngleRange, AngleRange, AnglePrecision);
          if( d < best )
          {
            sndBest = best;
            best = d;
            t = i;
          }
          else if( d < sndBest)
          {
            sndBest = d;
          }
        }
        float score = 1.0 - (best / HalfDiagonal);
        float otherScore = 1.0 - (sndBest / HalfDiagonal);
        float ratio = otherScore / score;
        // The threshold of 0.7 is arbitrary, and not part of the original code.
        if( t > -1 && score > 0.7)
        {
          return new Result( Templates[t].Name, score, ratio );
        }
        else
        {
          return new Result( "- none - ", 0.0, 1.0);
        }
     }
     
     int AddTemplate( String name, Point [] points)
     {
          Templates = (Template []) append( Templates, new Template(name, points)); 
          int num = 0;
          for( int i = 0; i < Templates.length; i++)
          {
            if( Templates[ i ].Name == name)
            {
              num++;
            }
          } 
          return num;    
     }
     
     void DeleteUserTemplates( )
     {
       Templates = (Template [])subset(Templates, 0, NumTemplates);
     }
     
}


float PathLength( Point [] points)
{
  float d = 0.0;
  for( int i = 1; i < points.length; i++)
  {
    d += points[i-1].distance( points[i]);
  }
  return d;
}

float PathDistance( Point [] pts1, Point [] pts2)
{
   if( pts1.length != pts2.length)
   {
     println( "Lengths differ. " + pts1.length + " != " + pts2.length);
     return Infinity;
   }
   float d = 0.0;
   for( int i = 0; i < pts1.length; i++)
   {
     d += pts1[i].distance( pts2[i]);
   }
   return d / (float)pts1.length;
}

Rectangle BoundingBox( Point [] points)
{
  float minX = Infinity;
  float maxX = -Infinity;
  float minY = Infinity;
  float maxY = -Infinity;

  for( int i = 1; i < points.length; i++)
  {
    minX = min( points[i].X, minX);
    maxX = max( points[i].X, maxX);
    minY = min( points[i].Y, minY);
    maxY = max( points[i].Y, maxY);
  }
  return new Rectangle( minX, minY, maxX - minX, maxY - minY);
}

Point Centroid( Point [] points)
{
  Point centriod = new Point(0.0, 0.0);
  for( int i = 1; i < points.length; i++)
  {
      centriod.X += points[i].X;
      centriod.Y += points[i].Y;
  }  
  centriod.X /= points.length;
  centriod.Y /= points.length;
  return centriod;
}

Point [] RotateBy( Point [] points, float theta)
{
   Point c = Centroid( points );
   float Cos = cos( theta );
   float Sin = sin( theta );
   
   Point [] newpoints = {};
   for( int i = 0; i < points.length; i++)
   {
     float qx = (points[i].X - c.X) * Cos - (points[i].Y - c.Y) * Sin + c.X;
     float qy = (points[i].X - c.X) * Sin + (points[i].Y - c.Y) * Cos + c.Y;
     newpoints = (Point[]) append(newpoints, new Point( qx, qy ));
   }
   return newpoints;
}

Point [] RotateToZero( Point [] points)
{
   Point c = Centroid( points );
   float theta = atan2( c.Y - points[0].Y, c.X - points[0].X);
   return RotateBy( points, -theta);
}

Point [] Resample( Point [] points, int n)
{
   float I = PathLength( points ) / ( (float)n -1.0 );
   float D = 0.0;
   Point [] newpoints = {};
   Stack stack = new Stack();
   for( int i = 0; i < points.length; i++)
   {
     stack.push( points[ points.length -1 - i]);
   }   
   
   while( !stack.empty())
   {
       Point pt1 = (Point) stack.pop();
       
       if( stack.empty())
       {
         newpoints = (Point [])append( newpoints, pt1);
         continue;
       }
       Point pt2 = (Point) stack.peek();
       float d = pt1.distance( pt2);
       if( (D + d) >= I)
       {
          float qx = pt1.X + (( I - D ) / d ) * (pt2.X - pt1.X);
          float qy = pt1.Y + (( I - D ) / d ) * (pt2.Y - pt1.Y);
          Point q = new Point( qx, qy);
          newpoints = (Point [])append( newpoints, q);
          stack.push( q );
          D = 0.0;
       } else {
         D += d;
       }
   }
   
   if( newpoints.length == (n -1) )
   {
     newpoints = (Point [])append( newpoints, points[ points.length -1 ]);
   }
   return newpoints;
   
}

Point [] ScaleToSquare( Point [] points, float sz)
{
    Rectangle B = BoundingBox( points );
    Point [] newpoints = {};
    for( int i = 0; i < points.length; i++)
    {
       float qx = points[i].X * (sz / B.Width);
       float qy = points[i].Y * (sz / B.Height);
       newpoints = (Point [])append( newpoints,  new Point(qx, qy));
    }
    return newpoints;
}

float DistanceAtBestAngle( Point [] points, Template T, float a, float b, float threshold)
{
   float x1 = Phi * a + (1.0 - Phi) * b;
   float f1 = DistanceAtAngle(points, T, x1);
   float x2 = (1.0 - Phi) * a + Phi * b;
   float f2 = DistanceAtAngle(points, T, x2);
   while( abs( b - a ) > threshold)
   {
     if( f1 < f2 )
     {
       b = x2;
       x2 = x1;
       f2 = f1;
       x1 = Phi * a + (1.0 - Phi) * b;
       f1 = DistanceAtAngle(points, T, x1);
     }
     else
     {
       a = x1;
       x1 = x2;
       f1 = f2;
       x2 = (1.0 - Phi) * a + Phi * b;
       f2 = DistanceAtAngle(points, T, x2);
     }
   }
   return min(f1, f2);
}


float DistanceAtAngle( Point [] points, Template T, float theta)
{
  Point [] newpoints = RotateBy( points, theta);
  return PathDistance( newpoints, T.Points);
}


Point [] TranslateToOrigin( Point [] points)
{
   Point c = Centroid( points);
   Point [] newpoints = {};
   for( int i = -0; i < points.length; i++)
   {
     float qx = points[i].X - c.X;
     float qy = points[i].Y - c.Y;
     newpoints = (Point [])append( newpoints,  new Point(qx, qy));
   }
   return newpoints;
}
