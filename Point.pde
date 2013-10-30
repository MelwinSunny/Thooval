// simple class for recording points

float Infinity = 1e9;

// Base point class. 
class Point
{
  float X;
  float Y;
  Point( float x, float y)
  {
    X = x;
    Y = y;
  }
  
  float distance( Point other)
  {
    return dist( X, Y, other.X, other.Y);
  }
}

