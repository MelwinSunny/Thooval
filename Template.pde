
// A template holds a name and a set of reduced points that represent
// a single gesture.  
class Template
{
  String Name;
  Point [] Points;
  Template( String name, Point [] points)
  {
    Name = name;
    Points = Resample( points, NumPoints);   
    Points = RotateToZero( Points );    
    Points = ScaleToSquare( Points, SquareSize);    
    Points = TranslateToOrigin( Points );
  }
}

