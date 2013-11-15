
class Pointchange
{
  ArrayList pointChangeAList=new ArrayList();
  Pointchange(int i)
  {
    splitting(i);
  }

void splitting(int j)
{ 
  String str=pointschangegesture[j];
  String []str1=split(str,',');
  int siz=str1.length-1;
  println("siz= "+siz);

  print(str1[0]);
  for(int ii=1;ii<str1.length;ii=ii+2)
  {

    print("!!"+str1[ii]+","+str1[ii+1]);
   pointChangeAList.add(Float.parseFloat(str1[ii]));
    pointChangeAList.add(Float.parseFloat(str1[ii+1]));
  
  } 
 
 
 println(" size of A List "+(pointChangeAList).size());
  
}
}
